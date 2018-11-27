package com.blog.controller.admin;

import com.blog.model.User;
import com.blog.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class LoginController {
	
	@Autowired
	private UserService userService;
	
	@RequestMapping("")
	public String index(HttpServletRequest request) {
		return "admin/login";
	}
	//登录请求
	@RequestMapping("/login")
	@ResponseBody
	public String login(HttpServletRequest request,HttpServletResponse response) {
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		List<User> list=userService.findUserByNameAndPwd(username,password);
		//若用户存在
		if(list.size() == 1) {
			//存到session
			HttpSession session=request.getSession();
			session.setAttribute("user",list.get(0));
			
			return "SUCCESS";
		}else {
			return "FAILED";
		}
	}
	//前往管理界面
	@RequestMapping("/index")
	public String goIndexPage(HttpServletRequest request) {

		HttpSession session=request.getSession();
		if(session.getAttribute("user") == null)
			return "redirect:/admin";
		else{
			return "admin/index";
		}
	}

	@RequestMapping("/logout")
    public String backLogin(HttpServletRequest request){
	    //消除session
        HttpSession session=request.getSession();
        session.setAttribute("user",null);
	    return "redirect:/admin";
    }

}
