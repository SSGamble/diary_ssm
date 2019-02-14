package top.qingrang.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import top.qingrang.pojo.YearList;
import top.qingrang.service.IYearListService;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("")
public class YearListController {

	@Autowired
	IYearListService yearListService;

	@RequestMapping("year_list")
	public String yearList(Model model, HttpSession session, String year){
		if(session.getAttribute("isDaily") == null){
			return "redirect:/note_list";
		}

		YearList moveTop = yearListService.getYearListByGroupTop(1,year);
		List<YearList> moveOtherList = yearListService.getYearListByGroupOther(1,year);

		YearList bookTop = yearListService.getYearListByGroupTop(2,year);
		List<YearList> bookOtherList = yearListService.getYearListByGroupOther(2,year);

		List<YearList> musicList = yearListService.getYearListByGroupOther(3,year);

		List<YearList> eventList = yearListService.getYearListByGroupOther(4,year);

		model.addAttribute("moveTop",moveTop);
		model.addAttribute("moveOtherList",moveOtherList);
		model.addAttribute("bookTop",bookTop);
		model.addAttribute("bookOtherList",bookOtherList);
		model.addAttribute("musicList",musicList);
		model.addAttribute("eventList",eventList);
		model.addAttribute("year",year);
		return "admin/yearList";
	}

	@RequestMapping("insert_year_list_page")
	public String showInsertYearList(Model model){
		return "admin/insert_year_list";
	}

	@RequestMapping("insert_year_list")
	public String addYearList(YearList yearList, Model model){
		yearListService.addYearList(yearList);
		return "redirect:insert_year_list_page";
	}
}
