package com.team.honeybee.service;

import java.io.*;

import javax.annotation.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.crypto.bcrypt.*;
import org.springframework.stereotype.*;
import org.springframework.transaction.annotation.*;
import org.springframework.web.multipart.*;

import com.team.honeybee.domain.*;
import com.team.honeybee.mapper.*;

import software.amazon.awssdk.core.sync.*;
import software.amazon.awssdk.regions.*;
import software.amazon.awssdk.services.s3.*;
import software.amazon.awssdk.services.s3.model.*;

@Service
public class MemberService {

	private S3Client s3;

	@Value("${aws.s3.bucketName}")
	private String bucketName;

	@Autowired
	private MemberMapper mapper;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	@PostConstruct
	public void init() {
		Region region = Region.AP_NORTHEAST_2;
		this.s3 = S3Client.builder().region(region).build();
	}

	@PreDestroy
	public void destroy() {
		this.s3.close();
	}

	public boolean addMember(MemberDto member) {

		String encodedPassword = passwordEncoder.encode(member.getPw());

		member.setPw(encodedPassword);

		int cnt1 = mapper.insertMember(member);

		int cnt2 = mapper.insertAuth(member.getMemberId(), "ROLE_USER");

		return cnt1 == 1 && cnt2 == 1;
	}

	// 아이디 중복확인
	public boolean hasMemberId(String memberId) {
		return mapper.countMemberId(memberId) > 0;
	}

	// 이메일 중복확인
	public boolean hasMemberEmail(String email) {
		return mapper.countMemberEmail(email) > 0;
	}

	// 닉네임 중복확인
	public boolean hasMemberNickName(String nickname) {
		return mapper.countMemberNickName(nickname) > 0;
	}

	// 아이디 찾기
	public int findId(String name, String email) {
		return mapper.findId(name, email);
	}

	// 아이디 가져오기
	public String findId2(String name, String email) {
		return mapper.findId2(name, email);
	}

	// 회원 정보 불러오기
	public MemberDto memberInfo(String memberId) {
		return mapper.memberInfo(memberId);
	}

	// 회원 탈퇴
	@Transactional
	public boolean removeMember(MemberDto dto) {
		MemberDto member = mapper.memberInfo(dto.getMemberId());

		String rawPw = dto.getPw();
		String encodePw = member.getPw();

		if (passwordEncoder.matches(rawPw, encodePw)) {
			// 저장된 프로필 사진 폴더 포함 삭제
			if (dto.getProfile() != null && dto.getProfile().isEmpty()) {
				String folder = "${imageUrl}/member/" + dto.getMemberId() + "/";
				String path = folder + dto.getProfile();

				File file = new File(path);
				file.delete();

				File dir = new File(folder);
				dir.delete();

			}
			// 댓글 삭제 넣어야함

			// 이 멤버가 쓴 게시글 삭제 넣어야함

			// 권한 테이블 삭제
			mapper.deleteAuthById(dto.getMemberId());

			// 멤버 테이블 삭제
			int cnt = mapper.deleteMemberById(dto.getMemberId());
			return cnt == 1;
		}

		return false;
	}

	// 회원 정보 수정
	@Transactional
	public boolean modifyMember(MemberDto dto, String oldPw, MultipartFile profile) {
		// DB에서 member 읽어오기
		MemberDto oldMember = mapper.memberInfo(dto.getMemberId());

		dto.setPw(oldMember.getPw());
		int cnt = mapper.updateMember(dto);

		// 프로필 사진 업로드
		if (profile.getSize() > 0) {
			mapper.updateFile(dto.getMemberId(), profile.getOriginalFilename());
			saveProfile(dto.getMemberId(), profile);
		}

		return cnt == 1;

	}

	// 프로필 사진 저장
	private void saveProfile(String memberId, MultipartFile profile) {
		// 디렉토리
		saveFileAwsS3(memberId, profile);
	}

	private void saveFileAwsS3(String id, MultipartFile file) {
		String key = "member/" + id + "/" + file.getOriginalFilename();
		
		PutObjectRequest putObjectRequest = PutObjectRequest.builder()
				.acl(ObjectCannedACL.PUBLIC_READ)
				.bucket(bucketName)
				.key(key)
				.build();
		
		RequestBody requestBody;
		try {
			requestBody = RequestBody.fromInputStream(file.getInputStream(), file.getSize());
			s3.putObject(putObjectRequest, requestBody);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new RuntimeException(e);
		}
		
		
	}
	// 이메일을 이용한 비밀번호 찾기
	public void initPw(String memberId) {
		String pw = passwordEncoder.encode(memberId);
		mapper.initPwByMemberId(memberId, pw);
	}

	public String getEmailById(String memberId) {
		return mapper.selectEmailById(memberId);
	}

	// 마이페이지에서 회원 비밀번호 변경
	public boolean updatePw(String memberId, String pw, String newPw) {
		MemberDto oldMember = mapper.selectMemberById(memberId);

		String encodedPw = oldMember.getPw();
		if (passwordEncoder.matches(pw, encodedPw)) {

			// 암호 인코딩
			String encodedPassword = passwordEncoder.encode(newPw);

			return mapper.updatePw(memberId, encodedPassword);
		}

		return false;
	}

	public void changePw(String memberId, String newPw) {
		String encodedPw = passwordEncoder.encode(newPw);
		mapper.updatePw(memberId, encodedPw);
	}
}
