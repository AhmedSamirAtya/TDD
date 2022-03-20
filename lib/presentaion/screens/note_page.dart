import 'package:flutter/material.dart';
import 'package:tdd/business/cubit/cubit/notes_cubit.dart';
import 'package:tdd/data/models/note-model.dart';

class NotePage extends StatefulWidget {
  final NotesCubit notesCubit;
  final Note? note;
  const NotePage({
    Key? key,
    required this.notesCubit,
    this.note,
  }) : super(key: key);
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.note == null) return;
    _titleController.text = widget.note!.title;
    _bodyController.text = widget.note!.body;
  }

  @override
  Widget build(BuildContext context) {
    _finishEditing() {
      if (widget.note != null) {
        widget.notesCubit.updateNote(
            widget.note!.id, _titleController.text, _bodyController.text);
      } else {
        widget.notesCubit
            .createNote(_titleController.text, _bodyController.text);
      }
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: widget.note != null ? _deleteNote : null,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              key: const ValueKey('title'),
              controller: _titleController,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            Expanded(
              child: TextField(
                key: const ValueKey('body'),
                controller: _bodyController,
                keyboardType: TextInputType.multiline,
                maxLines: 500,
                decoration:
                    const InputDecoration(hintText: 'Enter your text here...'),
              ),
            ),
            ElevatedButton(
              child: const Text('Ok'),
              onPressed: () => _finishEditing(),
            )
          ],
        ),
      ),
    );
  }

  _deleteNote() {
    widget.notesCubit.deleteNote(widget.note!.id);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _bodyController.dispose();
  }
}
