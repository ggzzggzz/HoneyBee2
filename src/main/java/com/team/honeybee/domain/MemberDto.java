package com.team.honeybee.domain;

import java.time.*;

import org.springframework.format.annotation.*;
import org.springframework.format.annotation.DateTimeFormat.*;

import lombok.*;

@Data
public class MemberDto {
	private String memberId;
	private String pw;
	private String name;
	private String email;
	private String nickname;
	private String postcode;
	private String address;
	private String detail;
	@DateTimeFormat(iso = ISO.DATE)
	private LocalDate birth;
	private String phone;
	
}