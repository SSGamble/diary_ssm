package top.qingrang.service;


import top.qingrang.pojo.YearList;

import java.util.List;

public interface IYearListService {
	List<YearList> getYearListByGroup(int group,String year);

	List<YearList> getYearListByGroupOther(int group,String year);

	YearList getYearListByGroupTop(int group,String year);

	void addYearList(YearList yearList);
}
