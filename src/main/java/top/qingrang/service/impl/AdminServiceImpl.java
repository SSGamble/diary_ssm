package top.qingrang.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.qingrang.dao.IAdminDao;
import top.qingrang.pojo.Admin;
import top.qingrang.service.IAdminService;
import top.qingrang.util.MD5;

@Service
public class AdminServiceImpl implements IAdminService {

	@Autowired
	IAdminDao adminDao;

	@Override
	public Admin getAdminByName(String username) {
		return adminDao.selectAdminByName(username);
	}

	@Override
	public boolean checkAdmin(Admin admin) {
		String name = admin.getUsername();
		String pwd = MD5.getMD5(admin.getPassword());
		String truePwd = getAdminByName(name).getPassword();
		if(pwd.equals(truePwd)){
			return true;
		}
		return false;
	}
}
