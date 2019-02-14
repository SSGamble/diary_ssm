package top.qingrang.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.qingrang.dao.IDailyListDao;
import top.qingrang.pojo.DailyList;
import top.qingrang.service.IDailyListService;
import java.util.List;

@Service
public class DailyListServiceImpl implements IDailyListService {

	@Autowired
	IDailyListDao dailyListDao;

	@Override
	public List<DailyList> getDailyListByYear(String year) {
		return dailyListDao.selectDailyListByYear(year);
	}

	@Override
	public DailyList getDailyByID(int id) {
		return dailyListDao.selectDailyByID(id);
	}

	@Override
	public List<DailyList> getDailyListBySearch(String searchKey) {
		return dailyListDao.selectDailyListBySearch(searchKey);
	}
}
