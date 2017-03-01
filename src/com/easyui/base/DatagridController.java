package com.easyui.base;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("datagridController")
public class DatagridController {
	
	@RequestMapping("table2grid")
	public ModelAndView table2grid(HttpServletRequest req,HttpServletResponse res){
		return new ModelAndView("6datagrid/table2grid");
	}
	
}
