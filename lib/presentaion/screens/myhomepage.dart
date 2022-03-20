import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd/business/cubit/cubit/notes_cubit.dart';
import 'package:tdd/data/models/note-model.dart';

import 'note_page.dart';

// lib/home_page.dart

class MyHomePage extends StatelessWidget {
  final NotesCubit notesCubit;
  final String title;

  const MyHomePage({Key? key, required this.title, required this.notesCubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _goToNotePage(BuildContext context) => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotePage(
              notesCubit: notesCubit,
            ),
          ),
        );
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocBuilder<NotesCubit, NotesState>(
        bloc: notesCubit,
        builder: (context, state) => ListView.builder(
          itemCount: state.notes.length,
          itemBuilder: (context, index) {
            Note? note = state.notes[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotePage(
                      notesCubit: notesCubit,
                      note: note,
                    ),
                  ),
                );
              },
              child: ListTile(
                title: Text(note.title),
                subtitle: Text(note.body),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _goToNotePage(context),
        tooltip: 'Add note',
        child: const Icon(Icons.add),
      ),
    );
  }
}
