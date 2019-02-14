package top.qingrang.dao;

import org.apache.ibatis.annotations.Param;
import top.qingrang.pojo.Note;

import java.util.List;
import java.util.Map;

public interface INoteDao {
	List<Note> selectNoteList();
	List<Note> selectDefaultNoteList();
	Note selectNoteByID(int id);
	int selectNoteTotal();
	void insertNote(Note note);
	void deleteNoteByID(int id);
	List<Note> selectNoteListByGroup(String group);
	void updateNoteByID(Note note);

	List<Note> selectNoteListByLimit(@Param("start")int start, @Param("size")int size);

	List<Note> selectNoteListByLimitToCurrentGroup(@Param("currentGroup")String currentGroup, @Param("start")int start, @Param("size")int size);

	List<Note> selectNoteListBySearchTitle(String searchKey);

	List<Note> selectNoteListByLimitToSearch(String searchKey, int start, int size);

	List<Note> selectNoteListBySearchTitleMoreKey(String[] keyArr);

	List<Note> selectNoteListBySearchToGroupAndContent(Map<String, Object> map);

	List<Note> selectNoteListBySearchContent(String[] contentArr);

	void updateNoteDraft(@Param("title")String title,@Param("content")String content);

	int insertNoteToRecover(Note note);

	List<Note> selectStickNoteList();
}
