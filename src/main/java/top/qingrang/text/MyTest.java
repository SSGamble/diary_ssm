package top.qingrang.text;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import top.qingrang.pojo.Groups;
import top.qingrang.service.IGroupsService;
import top.qingrang.service.INoteService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class MyTest {

	@Autowired
	INoteService noteService;

	@Autowired
	IGroupsService groupsService;

	@Test
	public void test() {
		String groupName = noteService.getNoteByID(264).getGroups();
		Groups group = groupsService.getGroupsByGroupsName(groupName);
		noteService.removeNoteByIDAndModGroupToRecover(264,group);
	}
}
