package com.easyui.user.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.easyui.user.model.User;
import com.easyui.user.service.IUserService;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping("userController")
public class UserController {

	@Autowired
	private IUserService userService;
	
	/**
	 * 获取用户列表，普通的请求，并响应到一个页面
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/getUser")
	public ModelAndView getUser(HttpServletRequest request,HttpServletResponse response){
		return new ModelAndView("user/userList", null);
	}
	
	/**
	 * 获取用户列表，ajax或普通的请求，只回传结果，不指定页面
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/getUser2")
	@ResponseBody
	public void getUser2(HttpServletRequest request,HttpServletResponse response){
	
	}
	/**
	 * restful风格的url，@PathVariable在变量名不一致时可用来对应关系，此时url后不能再跟？传参数了
	 * @param name
	 * @param age
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/getUser3/{name}/{age}")
	public ModelAndView getUser3(String name,@PathVariable("age") Integer age,HttpServletRequest request,HttpServletResponse response){
		System.out.println("name" + name);
		System.out.println("age" + age);
		return new ModelAndView("user/userlist", null);
	}
	
	/**
	 * @param request
	 * @param response
	 */
	@RequestMapping("/getUser4")
	@ResponseBody
	public void getUser4(HttpServletRequest request,HttpServletResponse response){
		ObjectMapper mapper = new ObjectMapper();
        Map<String, Object> map = new HashMap<String, Object>();
        List<User> users = userService.getUsers();
        map.put("users", users);
        try {
			mapper.writeValue(response.getWriter(), users);
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}
}
