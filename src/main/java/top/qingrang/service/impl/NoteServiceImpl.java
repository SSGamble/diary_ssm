package top.qingrang.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import top.qingrang.dao.IGroupsDao;
import top.qingrang.dao.INoteDao;
import top.qingrang.pojo.Groups;
import top.qingrang.pojo.Note;
import top.qingrang.service.INoteService;

import java.util.List;
import java.util.Map;

@Service
public class NoteServiceImpl implements INoteService {

	@Autowired
	INoteDao noteDao;

	@Autowired
	IGroupsDao groupDao;

	@Override
	public int getNoteTotal() {
		return noteDao.selectNoteTotal();
	}

	@Override
	public List<Note> getNoteList() {
		return noteDao.selectNoteList();
	}

	@Override
	public List<Note> getDefaultNoteList() {
		return noteDao.selectDefaultNoteList();
	}

	@Override
	public Note getNoteByID(int id) {
		return noteDao.selectNoteByID(id);
	}

	@Override
	public void addNote(Note note) {
		noteDao.insertNote(note);
	}

	@Override
	public void removeNoteByID(int id) {
		noteDao.deleteNoteByID(id);
	}

	@Override
	public List<Note> getNoteListByGroup(String group) {
		return noteDao.selectNoteListByGroup(group);
	}

	@Override
	public void editNoteByID(Note note) {
		noteDao.updateNoteByID(note);
	}

	@Override
	public List<Note> getNoteListByLimit(int start, int size) {
		return noteDao.selectNoteListByLimit(start,size);
	}

	@Override
	public List<Note> selectNoteListByLimitToCurrentGroup(String currentGroup, int start, int size) {
		return noteDao.selectNoteListByLimitToCurrentGroup(currentGroup,start,size);
	}

	@Override
	public List<Note> getNoteListBySearchTitle(String searchKey) {
		return noteDao.selectNoteListBySearchTitle(searchKey);
	}

	@Override
	public List<Note> selectNoteListByLimitToSearch(String searchKey, int start, int size) {
		return noteDao.selectNoteListByLimitToSearch(searchKey,start,size);
	}

	@Override
	public List<Note> getNoteListBySearchTitleMoreKey(String[] keyArr) {
		return noteDao.selectNoteListBySearchTitleMoreKey(keyArr);
	}

	@Override
	public List<Note> getNoteListBySearchToGroupAndContent(Map<String, Object> map) {
		return noteDao.selectNoteListBySearchToGroupAndContent(map);
	}

	@Override
	public List<Note> getNoteListBySearchContent(String[] contentArr) {
		return noteDao.selectNoteListBySearchContent(contentArr);
	}

	@Override
	public void saveNoteDraft(String title,String content) {
		noteDao.updateNoteDraft(title,content);
	}

	@Override
	public int addNoteToRecover(Note note) {
		return noteDao.insertNoteToRecover(note);
	}

	@Override
	@Transactional(propagation= Propagation.REQUIRED,rollbackForClassName="Exception")
	public void removeNoteByIDAndModGroupToRecover(int id, Groups group){
		Note note = noteDao.selectNoteByID(id);
		noteDao.deleteNoteByID(id);
		groupDao.updateGroupCount(group);
		noteDao.insertNoteToRecover(note);
	}

	@Override
	public List<Note> getStickNoteList() {
		return noteDao.selectStickNoteList();
	}
}
