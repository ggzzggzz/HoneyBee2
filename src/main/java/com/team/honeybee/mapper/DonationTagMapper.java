package com.team.honeybee.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.team.honeybee.domain.DonationBoardDto;

@Mapper
public interface DonationTagMapper {
	//해쉬 태그마다, 게시글 가져오기
	List<DonationBoardDto> getDonationBoardByhashTag(@Param("hashTag")String hashTag, @Param("sort")String sort);

}
