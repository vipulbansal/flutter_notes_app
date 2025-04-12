import 'package:dartz/dartz.dart';
import 'package:flutter_notes_app/core/error/failures.dart';
import '../entities/note.dart';

abstract class NoteRepository {
  /// Gets all notes
  Future<Either<Failure, List<Note>>> getAllNotes();
  
  /// Gets a specific note by id
  Future<Either<Failure, Note>> getNote(String id);
  
  /// Creates a new note
  Future<Either<Failure, Note>> createNote(String title, String content);
  
  /// Updates an existing note
  Future<Either<Failure, Note>> updateNote(Note note);
  
  /// Deletes a note by id
  Future<Either<Failure, void>> deleteNote(String id);
}
