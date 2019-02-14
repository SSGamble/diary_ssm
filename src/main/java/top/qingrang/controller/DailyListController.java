package top.qingrang.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import top.qingrang.pojo.Admin;
import top.qingrang.pojo.DailyList;
import top.qingrang.service.IAdminService;
import top.qingrang.service.IDailyListService;
import top.qingrang.util.DateUtil;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("")
public class DailyListController {

	@Autowired
	IAdminService adminService;

	@Autowired
	IDailyListService dailyListService;

	@RequestMapping("daily_list")
	public String dailyList(String password, Model model, HttpSession session, String year){
		boolean isLogin;
		if(session.getAttribute("isDaily") == null){
			if(password != null){
				Admin admin = new Admin("caption",password);
				isLogin = adminService.checkAdmin(admin);
			}else {
				return "redirect:/note_list";
			}
		}else {
			isLogin = true;
		}

		// 年度总结：年份列表
		List<String> yearList = new ArrayList<>();
		for (int i = 2014; i <= Integer.valueOf(DateUtil.getYearNow()); i++){
			yearList.add(String.valueOf(i));
		}
		model.addAttribute("yearList",yearList);

		// 日志：年份列表
		List<String> dailyYearList = new ArrayList<>();
		for (int i = 2017; i < Integer.valueOf(DateUtil.getYearNow()); i++){
			dailyYearList.add(String.valueOf(i));
		}
		model.addAttribute("dailyYearList",dailyYearList);

		List<DailyList> dailyList;
		if(year != null){
			dailyList = dailyListService.getDailyListByYear(year);
		}else {
			dailyList = dailyListService.getDailyListByYear(DateUtil.getYearNow());
		}
		model.addAttribute("dailyList",dailyList);

		if(isLogin){
			session.setAttribute("isDaily", "ok"); // 保存 session
			return "admin/dailyList";
		}else {
			return "redirect:/note_list";
		}
	}

	@RequestMapping("daily_list_year")
	public String dailyListByYear(Model model, String year){
		return "admin/dailyList";
	}

	@RequestMapping("preview_daily")
	@ResponseBody
	public Object previewNote(String id){
		System.out.println(id);
		DailyList dailyList = dailyListService.getDailyByID(Integer.parseInt(id));
		return dailyList;
	}

	@RequestMapping("show_daily")
	public String showDailyList(int id,Model model){
		DailyList daily = dailyListService.getDailyByID(id);
		model.addAttribute("daily",daily);
		return "admin/daily";
	}

	@RequestMapping("search_daily")
	@ResponseBody
	public Object getSearchDailyListAjax(String searchKey){
		System.out.println(searchKey);
		List<DailyList> dailyList = dailyListService.getDailyListBySearch(searchKey);
		return dailyList;
	}
}
