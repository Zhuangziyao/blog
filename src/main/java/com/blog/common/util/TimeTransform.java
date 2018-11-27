package com.blog.common.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class TimeTransform {
	public static String TimeStamp2Date(Integer timestampString) {
        Long timestamp = Long.parseLong(timestampString.toString()) * 1000;
        String date = new SimpleDateFormat("yyyy-MM-dd", Locale.CHINA).format(new Date(timestamp));
        return date;
    }

    public static String TimStamp2Time(Integer timestampString){
        Long timestamp = Long.parseLong(timestampString.toString()) * 1000;
        String time = new SimpleDateFormat("yyyy-MM-dd:HH:mm:ss", Locale.CHINA).format(new Date(timestamp));
        return time;
    }
}
