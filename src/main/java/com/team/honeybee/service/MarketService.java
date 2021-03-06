package com.team.honeybee.service;

import java.awt.PageAttributes.MediaType;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;


import com.team.honeybee.domain.MarketDto;
import com.team.honeybee.domain.MemberDto;
import com.team.honeybee.domain.OrderPayDto;
import com.team.honeybee.mapper.MarketMapper;
import com.team.honeybee.mapper.PointMapper;
import com.team.honeybee.vo.DonationReplyVO;
import com.team.honeybee.vo.KakaoPayApprovalVO;

import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service
public class MarketService {
	
	@Autowired
	public MarketMapper mapper;
	
	
	
	@Autowired
	PointMapper pointMapper;

	
	
	private S3Client s3;
	
	@Value("${aws.s3.bucketName}")
	private String bucketName;
	
	
	
	
	//마켓 물건 리스트
	public List<MarketDto> getmarketlist() {
		return mapper.listMarket();
	}


	//마켓 물건 상세페이지
	public MarketDto getMarketId(int id) {
		
		MarketDto market = mapper.selectMarketId(id);
		System.out.println(market);
		List<String> fileNames = mapper.selectFileNameByMarketId(id);
		System.out.println(fileNames);
		mapper.updateViewCount(id);
		market.setFileName(fileNames);
		System.out.println(market);
		return market;
	}


	//마켓 구매 페이지
	public MarketDto getMarketById(int marketId) {
		return mapper.getMarketById(marketId);
	}




	// 구매할 게시판 정보를 결제 페이지로 보내기
	/*	public OrderPayDto selectMarketBoard(int orderId) {
			// 게시글 관련 결재 내용 가져오기
			OrderPayDto order = mapper.selectMarketBoard(orderId);
			
			return order;
		}*/

	// 마켓 관련 기타 정보 db에 저장
	public void setKakaoPayETCData(DonationReplyVO donationReplyVO, int orderId) {
		System.out.println("setKakaoPayETCData");
		System.out.println(donationReplyVO);
		System.out.println(orderId);
		
		donationReplyVO.setOrderId(orderId);
		mapper.insertKakaoPayETCData(donationReplyVO);
	}
		
	
	
	
}
