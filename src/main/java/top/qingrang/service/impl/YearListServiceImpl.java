package top.qingrang.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.qingrang.dao.IYearListDao;
import top.qingrang.pojo.YearList;
import top.qingrang.service.IYearListService;

import java.util.List;

@Service
public class YearListServiceImpl implements IYearListService{

	@Autowired
	IYearListDao yearListDao;

	@Override
	public List<YearList> getYearListByGroup(int group,String year) {
		return yearListDao.selectYearByGroup(group,year);
	}

	@Override
	public List<YearList> getYearListByGroupOther(int group,String year) {
		return yearListDao.selectYearByGroupOther(group,year);
	}

	@Override
	public YearList getYearListByGroupTop(int group,String year) {
		return yearListDao.selectYearByGroupTop(group,year);
	}

	@Override
	public void addYearList(YearList yearList) {
		yearListDao.insertYearList(yearList);
	}
}
