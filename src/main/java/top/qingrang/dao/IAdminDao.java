package top.qingrang.dao;

import top.qingrang.pojo.Admin;

public interface IAdminDao {
	Admin selectAdminByName(String username);
}
