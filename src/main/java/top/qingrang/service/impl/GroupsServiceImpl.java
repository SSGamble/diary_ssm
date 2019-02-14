package top.qingrang.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.qingrang.dao.IGroupsDao;
import top.qingrang.pojo.Groups;
import top.qingrang.service.IGroupsService;

import java.util.List;

@Service
public class GroupsServiceImpl implements IGroupsService {

	@Autowired
	IGroupsDao groupDao;

	@Override
	public List<Groups> getGroupsList() {
		return groupDao.selectGroupList();
	}

	@Override
	public List<Groups> getRootGroupsList() {
		return groupDao.selectRootGroupList();
	}

	@Override
	public List<Groups> getComputerGroupsList() {
		return groupDao.selectComputerGroupList();
	}

	@Override
	public void modGroupsCount(Groups groups) {
		groupDao.updateGroupCount(groups);
	}

	@Override
	public Groups getGroupsByGroupsName(String groupName) {
		return groupDao.selectGroupByGroupName(groupName);
	}
}
