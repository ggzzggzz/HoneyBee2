package com.team.honeybee.service;

import java.io.IOException;
import java.lang.annotation.Target;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.team.honeybee.domain.DonationDto;
import com.team.honeybee.domain.DonationReplyDto;
import com.team.honeybee.domain.SummerNoteDto;
import com.team.honeybee.mapper.DonationBoardMapper;
import com.team.honeybee.mapper.DonationPayMapper;
import com.team.honeybee.mapper.DonationReplyMapper;
import com.team.honeybee.mapper.SummerNoteMapper;

import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service
public class DonationBoardService {
	@Autowired
	DonationBoardMapper mapper;
	
	@Autowired
	DonationReplyMapper replyMapper;
	
	@Autowired
	DonationPayMapper payMapper;
	
	@Autowired
	SummerNoteMapper summerNoteMapper;
	
	@org.springframework.beans.factory.annotation.Value("${aws.s3.bucketName}")
	private String bucketName;
	
	private S3Client amazonS3; 
	
	@PostConstruct   // s3 빈 생성
	public void init() {
		Region region = Region.AP_NORTHEAST_2;
		this.amazonS3 = S3Client.builder()
						.region(region)
						.build();
	}
	@PreDestroy // s3 빈이 사라지기 전
	public void destroy() {
		this.amazonS3.close();
	}
	
	// 게시글 목록
	public List<DonationDto> findOrder(String sort, String topic) {
		return mapper.selectOrder(sort, topic);
	}
	
	// 기부 게시글 보기
	@Transactional
	public DonationDto getBoard(int donationId) {
		DonationDto dto = mapper.getBoard(donationId);
		
		// 해쉬태그 가져오기
		List<String> hashTags = mapper.getHashTag(donationId);
		dto.setHashTag(hashTags);
		
		return dto;
	}

	// [임시] 도네이션 작성 게시판----------------------------------------------------------------------------------------
	@Transactional
	public void dontaionBoardWrite(DonationDto dto, MultipartFile mainPhoto, String hashTagLump, String folderName) {
		// 게시글 항목 저장
		mapper.dontaionBoardWrite(dto);
		System.out.println("dto : " + dto);
		
		// 해쉬 태그 분류 + db에 넣는 메소드
		makeHashTagWithoutShop(hashTagLump, dto.getDonationId());
		
	
		// 메인 사진 등록-----------------------
		if(mainPhoto.getSize() > 0) {
			// db 저장
			mapper.insertMainPhoto(dto.getDonationId(), mainPhoto.getOriginalFilename(), dto.getMemberId());
			
			// s3 저장
			saveMainPhotoAwsS3(dto.getDonationId(), mainPhoto, folderName); 
		}
		
		
		// Jsoup :  실제 이미지 업로드 판별
		//List<String> uploadImageAtTestArea = new ArrayList<>();
		Document doc = Jsoup.parse(dto.getContent());
		Elements imgs = doc.select("img[src]");
		
		// 정말 사용하는 이미지 리스트
		List<String> isImage = new ArrayList<>();
		for(Element img : imgs) {
			isImage.add(img.attr("src"));
		}
		System.out.println("isImage : "+ isImage);
		
		// 사용하지 않는 이미지 리스트
		// image_folder_id로 해당 db에 있는 이미지 정보 가져오기
		String imageFolderId = summerNoteMapper.getImageFolderIdImageUrl(isImage.get(0));  // 이미지url로, 관련 image_id가져오기 
		System.out.println(" imageFolderId : " + imageFolderId); // 
		
		List<String> dbImageUrlList = summerNoteMapper.getImageUrlByImageFolderId(imageFolderId);
		System.out.println("사용하지 않는 이미지 리스트 dbImageUrlList : " + dbImageUrlList);
		
		// 리스트끼리 비교해서 없는 것 분별하고 없는 거 db에서 삭제하기
		for(String imageUrl : dbImageUrlList) {
			if(! isImage.contains(imageUrl)) {
				// db 지우기
				System.out.println("db 지우기");
				summerNoteMapper.deleteImage(imageUrl);
				
				// s3 지우기
				deleteFromAwsS3(imageUrl);
			}
		}
		// donationId 넣어주기
		summerNoteMapper.setDonationId(dto.getDonationId(), imageFolderId);
		

	}
	// 해쉬태그 분류하기 + db에 넣기 메소드
	public void makeHashTagWithoutShop(String hashTagLump, int donationId) {
		
		String hashTag[] = hashTagLump.split("#");
		for(int i = 1; i < hashTag.length; i++) {
			// hashTags.add(hashTag[i].replaceAll(" ", "")); // 띄어쓰기 제거 후 넣기
			mapper.setHashTag(hashTag[i].replaceAll(" ", ""), donationId);
		}
	}
	
	
	// 메인 사진 등록 메소드
	private void saveMainPhotoAwsS3(int donationId, MultipartFile mainPhoto, String folderName) {
		// board/temp/12344.png
		String key = "donation/folderName/" + mainPhoto.getOriginalFilename();
		
		PutObjectRequest putObjectRequest = PutObjectRequest.builder()
				.acl(ObjectCannedACL.PUBLIC_READ) 		 // acl : 권한 설정
				.bucket(bucketName) 					// bucket 위치 설정
				.key(key)								// 키
				.build(); 								 // 이를 통해 PutObjectRequest객체 만듬
		
		RequestBody requestBody;
		try {
			requestBody = RequestBody.fromInputStream(mainPhoto.getInputStream(), mainPhoto.getSize());
			amazonS3.putObject(putObjectRequest, requestBody);
		} catch (IOException e) {
			e.printStackTrace();
			throw new RuntimeException(e); // 트랜잭션 때문에 모두 실패????????????
		}
	}
	
	// ++ aws의 s3에서 사진 삭제 메소드
	private void deleteFromAwsS3(String fileName) {
		System.out.println("삭제 가동");
		System.out.println(fileName.substring(75));
		String key = fileName.substring(75);
		
		DeleteObjectRequest deleteBucketRequest;
		deleteBucketRequest = DeleteObjectRequest.builder()
				.bucket(bucketName)
				.key(key)
				.build();
		
		amazonS3.deleteObject(deleteBucketRequest);
		
	}
	

	//--------------------------------------------------------------------------------------------------------------------
	
	// 기부금 결제
	public void donate(int donationId, int amount, String content, String memberId) {
		// 후기 저장
		DonationReplyDto replyDto = new DonationReplyDto();
		replyDto.setDonationId(donationId);
		replyDto.setContent(content);
		replyDto.setMemberId(memberId);
		replyMapper.addReply(replyDto);
		int replyIdForPay = replyDto.getReplyId();
		
		// 기부금액 저장
		payMapper.donate(amount, memberId, donationId, replyIdForPay);
		
		// 총 모금액 기록
		payMapper.addAmount(donationId);
		
	}

}