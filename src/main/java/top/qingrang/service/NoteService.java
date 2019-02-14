package top.qingrang.service;

import top.qingrang.pojo.Note;

import java.util.List;

public interface NoteService {
	List<Note> list();
	List<Note> defaultList();
	Note getNoteByID(int id);
	void insertNote();
}
