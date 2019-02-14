package top.qingrang.dao;

import top.qingrang.pojo.DailyList;
import java.util.List;

public interface IDailyListDao {

	List<DailyList> selectDailyListByYear(String year);
	DailyList selectDailyByID(int id);
	List<DailyList> selectDailyListBySearch(String searchKey);
}
