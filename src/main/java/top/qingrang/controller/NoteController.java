package top.qingrang.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import top.qingrang.pojo.Groups;
import top.qingrang.pojo.Note;
import top.qingrang.service.IGroupsService;
import top.qingrang.service.INoteService;
import top.qingrang.util.Page;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("")
public class NoteController{

	@Autowired
	INoteService noteService;
	@Autowired
	IGroupsService groupsService;

	@RequestMapping("edit")
	public String text(){
		return "text/edit";
	}

	@RequestMapping("show")
	public String text2(Model model,String title,String content){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd-HH:mm:ss");
		String dateNow = sdf.format(new Date());
		Note note = new Note();
		note.setTitle(title);
		note.setContent(content);
		note.setDate(dateNow);
		noteService.addNote(note);
		List<Note> lst = noteService.getNoteList();
		model.addAttribute("lst",lst);
		return "text/show";
	}

	@RequestMapping("get_note_list_ajax")
	@ResponseBody   // 将返回的数据放入到响应体中
	public Object getNoteListAjax(int currentPage,String currentGroup)  {
		int size = 12;
		int start = 1 * currentPage * size;
		List<Note> noteList;
		if(!currentGroup.equals("all")){
			noteList = noteService.selectNoteListByLimitToCurrentGroup(currentGroup,start,size);
		}else {
			noteList = noteService.getNoteListByLimit(start,size);
		}
		return noteList;
	}

	@RequestMapping("search_note_list_ajax")
	@ResponseBody
	public Object getSearchNoteListAjax(String searchKey){
		List<Note> noteList;
		String[] contentArr;

		// 类型 + 内容 查询
		if(searchKey.indexOf('+') != -1){
			String[] keyArr = searchKey.split("\\+");
			String type = keyArr[0];
			contentArr = keyArr[1].split(" ");
			Map<String, Object> map = new HashMap<String, Object> ();
			map.put("groups",type);
			map.put("contentArr",contentArr);
			noteList = noteService.getNoteListBySearchToGroupAndContent(map);
		}else {	// 内容查询
			contentArr = searchKey.split(" ");
			noteList = noteService.getNoteListBySearchContent(contentArr);
		}
		return noteList;
	}

	@RequestMapping("preview_note")
	@ResponseBody
	public Object previewNote(String noteID){
		Note note = noteService.getNoteByID(Integer.parseInt(noteID));
		return note;
	}

	@RequestMapping("get_note_total")
	@ResponseBody
	public Object getNoteTotal()  {
		return noteService.getNoteTotal();
	}

	@RequestMapping(value = "save_note_draft",produces = "text/html;charset=utf-8")
	@ResponseBody
	public Object saveNoteDraft(String content,HttpServletResponse response) throws IOException {
		// 从 content 中分割出标题
		String title = content.split("\n")[0].split("#")[1].trim();
		noteService.saveNoteDraft(title, content);

		return "《" + title + "》保存成功 -- " + System.currentTimeMillis();
	}

	@RequestMapping("note_list")
	public String noteList(Model model, Page page, String groups, HttpSession session){

		if(session.getAttribute("isDaily") != null)
			session.removeAttribute("isDaily");

		int noteTotal = noteService.getNoteTotal();
		int pageTotal = noteTotal/12 + 1;
		List<Note> noteList;
		PageHelper.offsetPage(page.getStart(),page.getCount());
		if(groups != null){
			noteList = noteService.getNoteListByGroup(groups);
		}else {
			noteList = noteService.getNoteList();
		}
		List<Note> noteDefaultList = noteService.getDefaultNoteList();
		List<Note> noteStickList = noteService.getStickNoteList();
		List<Groups> rootGroupList = groupsService.getRootGroupsList();
		List<Groups> computerGroupList = groupsService.getComputerGroupsList();
		int total = (int) new PageInfo<>(noteList).getTotal();
		page.setTotal(total);
		model.addAttribute("noteList",noteList);
		model.addAttribute("noteStickList",noteStickList);
		model.addAttribute("noteDefaultList",noteDefaultList);
		model.addAttribute("rootGroupList",rootGroupList);
		model.addAttribute("computerGroupList",computerGroupList);
		model.addAttribute("noteTotal",noteTotal);
		model.addAttribute("page", page);
		model.addAttribute("pageTotal", pageTotal);
		if(groups != null) {
			model.addAttribute("currentGroup",groups);
			return "admin/noteList";
		}
		model.addAttribute("currentGroup","all");
		return "admin/noteList";
	}

	@RequestMapping("show_note")
	public String showNote(int id,Model model){
		Note note = noteService.getNoteByID(id);
		model.addAttribute("note",note);
		return "admin/show_note";
	}

	@RequestMapping("insert_note_page")
	public String showInsertNote(Model model){
		List<Groups> groupList = groupsService.getGroupsList();
		model.addAttribute("groupList",groupList);
		return "admin/insert_note";
	}

	@RequestMapping("insert_note")
	public String addNoteAndShowNote(Note note, Model model){
		// 从 Note 中分割出标题
		String title = note.getContent().split("\n")[0].split("#")[1].trim();
		note.setTitle(title);

		// 创建日期和修改日期
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String dateNow = sdf.format(new Date());
		note.setDate(dateNow);
		String dateModify = sdf.format(new Date());
		note.setGmt_modified(dateModify);

		noteService.addNote(note);
		int noteID = note.getId();

		// 添加 Note 成功，对应 group 的笔记总数 +1
		String groupName = noteService.getNoteByID(noteID).getGroups();
		Groups group = groupsService.getGroupsByGroupsName(groupName);
		int count = group.getG_count();
		group.setG_count(++count);
		groupsService.modGroupsCount(group);

		model.addAttribute("note",note);
		return "redirect:show_note?id=" + noteID;
	}

	@RequestMapping("delete_note")
	public String removeNoteByID(int id){
		// 删除 Note 成功，对应 group 的笔记总数 -1
		String groupName = noteService.getNoteByID(id).getGroups();
		Groups group = groupsService.getGroupsByGroupsName(groupName);
		int count = group.getG_count();
		group.setG_count(--count);
		noteService.removeNoteByIDAndModGroupToRecover(id,group);
		return "redirect:/note_list";
	}

	@RequestMapping("edit_note")
	public String showEditNoteByID(Model model,int id){
		Note note = noteService.getNoteByID(id);
		List<Groups> groupList = groupsService.getGroupsList();
		model.addAttribute("note",note);
		model.addAttribute("groupList",groupList);
		return "admin/edit_note";
	}

	@RequestMapping("edit_note_fun")
	public String editNoteByID(Model model,Note note){
		Note oldNote = noteService.getNoteByID(note.getId());

		// 从 Note 中分割出标题
		String title = note.getContent().split("\n")[0].split("#")[1].trim();
		note.setTitle(title);
		// 修改日期
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String dateModify = sdf.format(new Date());
		note.setGmt_modified(dateModify);
		note.setDate(oldNote.getDate());

		noteService.editNoteByID(note);

		// 修改 Note 成功，如果更改了 group ，则更改两个 group 的笔记总数
		Groups oldGroup = groupsService.getGroupsByGroupsName(oldNote.getGroups());
		Groups newGroup = groupsService.getGroupsByGroupsName(note.getGroups());
		if(!oldGroup.getGroups().equals(newGroup.getGroups())){
			int oldCount = oldGroup.getG_count();
			oldGroup.setG_count(--oldCount);

			int newCount = newGroup.getG_count();
			newGroup.setG_count(++newCount);

			groupsService.modGroupsCount(oldGroup);
			groupsService.modGroupsCount(newGroup);
		}

		model.addAttribute("note",note);
		return "redirect:show_note?id=" + note.getId();
	}
}
