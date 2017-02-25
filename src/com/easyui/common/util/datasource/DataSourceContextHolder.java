package com.easyui.common.util.datasource;

/**
 * 切换数据源的工具类
 * @author lxy
 *
 */
public class DataSourceContextHolder {

    private static final ThreadLocal<String> contextHolder = new ThreadLocal<String>(); // 线程本地环境

    // 设置数据源类型
    public static void setDataSourceType(String dataSourceType) {
        contextHolder.set(dataSourceType);

    }

    // 获取数据源类型 　　
    public static String getDataSourceType() {
        return (String) contextHolder.get();
    }

    // 清除数据源类型

    public static void clearDataSourceType() {
        contextHolder.remove();
    }
}