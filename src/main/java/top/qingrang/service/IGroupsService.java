package top.qingrang.service;

import top.qingrang.pojo.Groups;

import java.util.List;

public interface IGroupsService {
	List<Groups> getGroupsList();
	List<Groups> getRootGroupsList();
	List<Groups> getComputerGroupsList();
	void modGroupsCount(Groups groups);
	Groups getGroupsByGroupsName(String groupName);
}
