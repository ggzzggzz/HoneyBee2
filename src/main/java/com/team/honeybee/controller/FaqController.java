package com.team.honeybee.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team.honeybee.domain.FaqDto;
import com.team.honeybee.service.FaqService;

@Controller
@RequestMapping("faq")
public class FaqController {

	@Autowired
	private FaqService service;

	
	@GetMapping("insert")
	public void writeBoard() {

	}
	@RequestMapping("login")
	private void login() {
		
	}
	//1대1 문의 글 쓰기
	@PostMapping("insert")
	public String writeBoard(FaqDto faq,
							 RedirectAttributes rttr,
							 MultipartFile[] file,
							 Principal principal) {
		if(file != null) {
			List<String> fileList = new ArrayList<String>();
			for(MultipartFile f : file) {
				fileList.add(f.getOriginalFilename());
			}
			faq.setFileName(fileList);
		}
		
		
		faq.setMemberId(principal.getName());
		boolean success = service.addBoard(faq,file);
		if (success) {
			rttr.addFlashAttribute("message", "새 글이 등록되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "새 글이 등록되지 않았습니다.");
		}

		return "redirect:/faq/question";

	}
	
	@RequestMapping("faqList")
	public void faqList(Model model) {
		List<FaqDto> list = service.faqList();
		System.out.println(list);
		model.addAttribute("faqList",list);
}
	@RequestMapping("question")
	public void question() {
		
	}
	
	@GetMapping("faqGet")
	public void faqGet(int questionId,Model model) {
		FaqDto faq =service.getFaqById(questionId);
		model.addAttribute("faq",faq);
	}
	@PostMapping("removeFaq")
	public String removeFaq(@RequestParam("questionIdList") List<Integer> questionIdList,RedirectAttributes rttr) {
		boolean success = false;
		for(int questionId : questionIdList) {			
			success = service.removefaqId(questionId);
		}
		if (success) {
			rttr.addFlashAttribute("message", "글이 삭제 되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "글이 삭제 되지않았습니다.");
		}
		return "redirect:/faq/faqList";
	}
	@RequestMapping("notice")
	public void notice() {
		
	}
	
}	