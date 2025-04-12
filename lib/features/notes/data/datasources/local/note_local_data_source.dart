import 'package:hive/hive.dart';

import '../../../../../core/error/exceptions.dart';
import '../../models/note_model.dart';



abstract class NoteLocalDataSource {
  /// Gets all notes from local storage
  Future<List<NoteModel>> getAllNotes();
  
  /// Gets a specific note from local storage
  Future<NoteModel> getNote(String id);
  
  /// Creates a new note in local storage
  Future<NoteModel> createNote(String title, String content);
  
  /// Updates an existing note in local storage
  Future<NoteModel> updateNote(NoteModel note);
  
  /// Deletes a note from local storage
  Future<void> deleteNote(String id);
}

class NoteLocalDataSourceImpl implements NoteLocalDataSource {
  final Box<NoteModel> notesBox;
  
  NoteLocalDataSourceImpl({required this.notesBox});

  @override
  Future<List<NoteModel>> getAllNotes() async {
    try {
      final notes = notesBox.values.toList();
      // Sort by updated date, most recent first
      notes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      return notes;
    } catch (e) {
      throw CacheException('Failed to get notes from Hive: ${e.toString()}');
    }
  }

  @override
  Future<NoteModel> getNote(String id) async {
    try {
      final note = notesBox.values.firstWhere(
        (note) => note.id == id,
        orElse: () => throw CacheException('Note not found with id: $id'),
      );
      return note;
    } catch (e) {
      throw CacheException('Failed to get note from Hive: ${e.toString()}');
    }
  }

  @override
  Future<NoteModel> createNote(String title, String content) async {
    try {
      final noteModel = NoteModel.create(
        title: title,
        content: content,
      );
      
      await notesBox.put(noteModel.id, noteModel);
      return noteModel;
    } catch (e) {
      throw CacheException('Failed to create note in Hive: ${e.toString()}');
    }
  }

  @override
  Future<NoteModel> updateNote(NoteModel note) async {
    try {
      await notesBox.put(note.id, note);
      return note;
    } catch (e) {
      throw CacheException('Failed to update note in Hive: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    try {
      await notesBox.delete(id);
    } catch (e) {
      throw CacheException('Failed to delete note from Hive: ${e.toString()}');
    }
  }
}
