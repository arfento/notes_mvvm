import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_mvvm/core/services/image_selector.dart';
import 'package:notes_mvvm/core/utils/dialogs.dart';
import 'package:notes_mvvm/data/datasources/db/database_helpers.dart';
import 'package:notes_mvvm/domain/models/visual_note_model.dart';

final homeViewModel =
    ChangeNotifierProvider<HomeViewModel>((ref) => HomeViewModel(ref));

class HomeViewModel extends ChangeNotifier {
  Ref ref;
  bool isLoading = false;
  late DatabaseHelpers database;

  HomeViewModel(this.ref) {
    database = ref.read(databaseProvider);
    getNotes();
  }

  List<VisualNoteModel> notesList = [];
  List<String> selectedNotesIds = [];

  getNotes() async {
    isLoading = true;
    notifyListeners();
    try {
      notesList = await database.getAllNotes();
    } catch (e) {
      AppDialogs.showDefaultErrorDialog();
    }
    isLoading = false;
    notifyListeners();
  }

  deleteNote({required VisualNoteModel visualNoteModel}) async {
    isLoading = true;
    notifyListeners();
    try {
      notesList.removeWhere((note) => note.noteId == visualNoteModel.noteId);
      database.deleteNotes(noteId: visualNoteModel.noteId);
      ImageSelector.instance
          .deleteImageLocally(imageFile: File(visualNoteModel.image));
    } catch (e) {
      AppDialogs.showDefaultErrorDialog();
    }
    isLoading = false;
    notifyListeners();
  }

  deleteSelectedNotes() {
    isLoading = true;
    notifyListeners();
    try {
      deleteSelectedNotesLocalImage();
      notesList.removeWhere((note) => isSelectedNote(noteId: note.noteId));
      database.deleteMultipleNotes(noteIds: selectedNotesIds);
      clearNoteSelection();
    } catch (e) {
      AppDialogs.showDefaultErrorDialog();
    }
    isLoading = false;
    notifyListeners();
  }

  deleteSelectedNotesLocalImage() {
    final selectedNotesImage = notesList
        .where((note) => isSelectedNote(noteId: note.noteId))
        .map((e) => e.image)
        .toList();
    for (var image in selectedNotesImage) {
      ImageSelector.instance.deleteImageLocally(imageFile: File(image));
    }
  }

  isSelectedNote({required String noteId}) {
    if (selectedNotesIds.contains(noteId)) {
      return true;
    } else {
      return false;
    }
  }

  toggleNoteSelection({required String noteId}) {
    if (selectedNotesIds.contains(noteId)) {
      selectedNotesIds.remove(noteId);
    } else {
      selectedNotesIds.add(noteId);
    }
    notifyListeners();
  }

  void clearNoteSelection() {
    selectedNotesIds.clear();
    notifyListeners();
  }
}
