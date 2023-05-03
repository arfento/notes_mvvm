import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_mvvm/core/utils/constants.dart';
import 'package:notes_mvvm/core/utils/enums.dart';
import 'package:notes_mvvm/domain/models/visual_note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final databaseProvider = Provider<DatabaseHelpers>(
  (ref) => DatabaseHelpers(),
);

class DatabaseHelpers {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), 'notes_database.db');
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return database;
  }

  Future<FutureOr<void>> _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $notesTable(
          noteId TEXT PRIMARY KEY,
          date INTEGER NOT NULL,
          title TEXT NOT NULL,
          description TEXT NOT NULL,
          image TEXT NOT NULL,
          status TEXT NOT NULL
        )
    ''');
  }

  Future<List<VisualNoteModel>> getAllNotes() async {
    Database db = await database;
    List<Map<String, dynamic>> notesMaps =
        await db.rawQuery('SELECT * FROM $notesTable');
    List<VisualNoteModel> notesList = notesMaps.isNotEmpty
        ? notesMaps.map((note) => VisualNoteModel.fromMap(note)).toList()
        : [];

    return notesList;
  }

  Future addNotes({required VisualNoteModel visualNoteModel}) async {
    Database db = await database;
    await db.insert(
      notesTable,
      visualNoteModel.toMap(),
    );
  }

  Future deleteNotes({required String noteId}) async {
    Database db = await database;
    await db.delete(
      notesTable,
      where: 'noteId = ?',
      whereArgs: [noteId],
    );
  }

  Future updateNotes({
    required String noteId,
    required VisualNoteModel visualNoteModel,
  }) async {
    Database db = await database;
    await db.update(
      notesTable,
      visualNoteModel.toMap(),
      where: 'noteId = ?',
      whereArgs: [noteId],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future deleteMultipleNotes({required List<String> noteIds}) async {
    Database db = await database;
    await db.delete(
      notesTable,
      where: 'noteId IN (${List.filled(noteIds.length, '?').join(',')})',
      whereArgs: [noteIds],
    );
  }

  Future deleteAllNotes() async {
    Database db = await database;
    await db.rawDelete(
      notesTable,
    );
  }
}
