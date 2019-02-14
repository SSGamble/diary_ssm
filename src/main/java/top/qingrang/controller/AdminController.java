package top.qingrang.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import top.qingrang.pojo.Admin;
import top.qingrang.service.IAdminService;
import top.qingrang.util.MD5;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("")
public class AdminController {

	@Autowired
	IAdminService adminService;

	/**
	 * 加载登录页面
	 */
	@RequestMapping("login_page")
	public String loginPage(){
		return "admin/login";
	}

	/**
	 * 登录验证
	 */
	@RequestMapping("login_check")
	public String loginCheck(String password, HttpSession session){
		// 登录检测，返回 Admin 实体类
		Admin admin = adminService.getAdminByName("caption");

		if(!admin.getPassword().equals(MD5.getMD5(password))){
			return "admin/login"; // 验证失败，跳转登录页面
		}else{	// 验证成功
			session.setAttribute("userSession", "caption"); // 保存 session
			return "redirect:/note_list";	// 跳转到主界面
		}
	}

}
