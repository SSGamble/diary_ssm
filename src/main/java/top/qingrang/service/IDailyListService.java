package top.qingrang.service;

import top.qingrang.pojo.DailyList;
import java.util.List;

public interface IDailyListService {

	List<DailyList> getDailyListByYear(String year);

	DailyList getDailyByID(int id);

	List<DailyList> getDailyListBySearch(String searchKey);
}
