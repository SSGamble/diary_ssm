package top.qingrang.dao;

import top.qingrang.pojo.Groups;

import java.util.List;

public interface IGroupsDao {
	List<Groups> selectGroupList();
	List<Groups> selectRootGroupList();
	List<Groups> selectComputerGroupList();
	Groups selectGroupByGroupName(String groupName);
	void updateGroupCount(Groups groupName);
}
