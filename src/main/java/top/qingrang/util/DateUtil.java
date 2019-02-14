package top.qingrang.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {

	public static String getDateNow(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String dateNow = sdf.format(new Date());
		return dateNow;
	}

	public static String getYearNow(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		String year = sdf.format(new Date());
		return year;
	}
}
