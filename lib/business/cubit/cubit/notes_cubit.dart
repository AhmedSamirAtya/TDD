import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd/data/models/note-model.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  List<Note> _notes = [];
  int increament = 0;
  NotesCubit() : super(NotesState([]));

  void createNote(String title, String body) {
    Note note = Note(++increament, title, body);
    _notes.add(note);
    emit(NotesState(_notes));
  }

  void deleteNote(int id) {
    //_notes = _notes.where((element) => element.id != id).toList();
    _notes.removeWhere((item) => item.id == id);
    emit(NotesState(_notes));
  }

  void updateNote(int id, String title, String body) {
    var noteIndex = _notes.indexWhere((element) => element.id == id);
    _notes.replaceRange(
      noteIndex,
      noteIndex + 1,
      [Note(id, title, body)],
    );
    emit(NotesState(_notes));
  }
}
