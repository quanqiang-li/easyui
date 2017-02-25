package com.easyui.common.util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.util.StringUtils;

public class CalendarUtil {

	/**
	 * 返回当前时间，格式由用户自己自定
	 * @param pattern 格式,如果为空则使用默认格式YYYY-MM-DD
	 * @return
	 */
	public static String getCurrDateTime(String pattern) {
		if(StringUtils.isEmpty(pattern)){
			pattern = "YYYY-MM-dd";
		}
		DateFormat df = new SimpleDateFormat(pattern);
		return df.format(new Date());
	}

}
