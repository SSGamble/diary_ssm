package top.qingrang.service;

import top.qingrang.pojo.Admin;

public interface IAdminService {

	Admin getAdminByName(String username);

	boolean checkAdmin(Admin admin);
}
