package top.qingrang.service;

import top.qingrang.pojo.Groups;
import top.qingrang.pojo.Note;

import java.util.List;
import java.util.Map;

public interface INoteService {
	int getNoteTotal();
	List<Note> getNoteList();
	List<Note> getDefaultNoteList();
	Note getNoteByID(int id);
	void addNote(Note note);
	void removeNoteByID(int id);
	List<Note> getNoteListByGroup(String group);
	void editNoteByID(Note note);
	List<Note> getNoteListByLimit(int start, int size);
	List<Note> selectNoteListByLimitToCurrentGroup(String currentGroup, int start, int size);
	List<Note> getNoteListBySearchTitle(String searchKey);
	List<Note> selectNoteListByLimitToSearch(String searchKey, int start, int size);
	List<Note> getNoteListBySearchTitleMoreKey(String[] keyArr);
	List<Note> getNoteListBySearchToGroupAndContent(Map<String, Object> map);
	List<Note> getNoteListBySearchContent(String[] contentArr);
	void saveNoteDraft(String title, String content);
	int addNoteToRecover(Note note);
	void removeNoteByIDAndModGroupToRecover(int id, Groups group);
	List<Note> getStickNoteList();
}
