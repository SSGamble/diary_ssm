package top.qingrang.dao;

import org.apache.ibatis.annotations.Param;
import top.qingrang.pojo.YearList;

import java.util.List;

public interface IYearListDao {
	List<YearList> selectYearByGroup(@Param("group")int group,@Param("year")String year);

	List<YearList> selectYearByGroupOther(@Param("group")int group,@Param("year")String year);

	YearList selectYearByGroupTop(@Param("group")int group, @Param("year")String year);

	void insertYearList(YearList yearList);
}
