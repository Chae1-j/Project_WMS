package com.itwillbs.project.controller;

import java.util.List;

import javax.lang.model.element.ModuleElement;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.project.service.In_scheduleService;
import com.itwillbs.project.vo.InScheduleVO;

@Controller
public class In_ScheduleController {

	@Autowired
	private In_scheduleService service;
	
	//--------입고예정 목록 표시 페이지 이동 -----------
	@GetMapping("/InList")
	public String islist(Model model, HttpSession session) {
		List<InScheduleVO> islist = service.getInscheduleList();
		
		model.addAttribute("islist", islist);
		
		return "in_schedule/in_list";
	} //입고예정 목록 표시 페이지 이동 끝 
	
	//-----------입고등록 폼-----------
	@GetMapping("/InRegisterForm")
	public String isinsertform(@ModelAttribute InScheduleVO inschedule, Model model) {
		
		return "in_schedule/in_register";
	}// 입고등록 폼 끝
	
	//------입고등록 PRO ------
	@PostMapping("/InscheduleRegisterPro")
	public String InscheduleRegisterPro(@ModelAttribute InScheduleVO ins
			,Model model 
			,HttpSession session) {
		System.out.println(ins);
		int insertCount = service.registerInschedule(ins);
		if(insertCount > 0) {
				
			return "redirect:/InList";
			}
		
		else {
			model.addAttribute("msg", "등록 실패!");
			return "fail_back";
		} 
		
	}
	//-----------입고 등록 PRO 끝------------
	
	//---------입고 수정 -----------
	@GetMapping("/InModifyForm")
	public String modify(@ModelAttribute InScheduleVO ins,
			Model model,
			HttpSession session,
			@RequestParam(defaultValue="1") int IN_SCHEDULE_CD) {
		ins = service.getInscheduleList(IN_SCHEDULE_CD);
		model.addAttribute("ins", ins);
		return "in_schedule/in_modifyform";
	}
	
	@PostMapping("/InModifyPro")
	public String modifyPro(@ModelAttribute InScheduleVO ins, 
			@RequestParam(defaultValue="1") int IN_SCHEDULE,
			Model model) {
		int updateCount = service.modifyPro(ins);
		if(updateCount >0) {
			return "redirect:/InList?IN_SCHEDULE_CD=" +ins.getIN_SCHEDULE_CD();
			
		}else {
			model.addAttribute("msg","수정 실패");
			return "fail_back";
			
		}
		
	}
	
	
	
//	//----------진행중 리스트----------
//	@GetMapping("/InProgressList")
//	public String progress(Model model, HttpSession session) {
//		List<InScheduleVO> progress = service.getInprogressList();
//		
//		model.addAttribute("progress", progress);
//		
//		return "in_schedule/in_progresslist";
//	}
	
	
	
}
