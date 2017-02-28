package com.easyui.base;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("baseController")
public class BaseController {
	
	@RequestMapping("parser")
	public ModelAndView parser(HttpServletRequest req,HttpServletResponse res){
		return new ModelAndView("1base/1parser");
	}
	@RequestMapping("easyLoader")
	public ModelAndView easyLoader(HttpServletRequest req,HttpServletResponse res){
		return new ModelAndView("1base/2easyLoader");
	}
}
