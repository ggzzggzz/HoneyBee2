package com.team.honeybee.domain;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
@Data
public class TalentReivewDto {
	private int reviewId;
	private String talentId;
	
	private String memberId;
	private String nickname;
	
	private String content;
	private int starRating;
	
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	private LocalDate inserted;
	
	private int refOrder;
	
	// dbì ìì
    private int starCount;
	private int starSum;
	
	
}
