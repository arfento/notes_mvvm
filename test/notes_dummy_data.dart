import 'package:notes_mvvm/domain/models/visual_note_model.dart';

final dummyNotes = [
  VisualNoteModel(
    noteId: 'noteId1',
    date: DateTime.now().millisecondsSinceEpoch,
    title: 'title',
    description: 'description',
    image: 'image',
    status: 'status',
  ),
  VisualNoteModel(
    noteId: 'noteId2',
    date: DateTime.now().millisecondsSinceEpoch,
    title: 'title',
    description: 'description',
    image: 'image',
    status: 'status',
  ),
];
