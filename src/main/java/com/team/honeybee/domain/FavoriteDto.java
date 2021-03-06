package com.team.honeybee.domain;

import lombok.Data;

@Data
public class FavoriteDto {
	private int id;
	private String memberId;
	private int donationId;
	private int talentId;
	
	private int heart;
	
	private int count;
	private int exit;
	
	// db에 없는 property
	private char type;
	
	
	// favorite 테이블
	private int meetingId; 
	private int meetingReplyId; // 댓글 좋아요
}
