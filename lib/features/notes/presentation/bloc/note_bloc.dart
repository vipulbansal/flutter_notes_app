import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/note.dart';
import '../../domain/usecases/create_note.dart';
import '../../domain/usecases/delete_note.dart';
import '../../domain/usecases/get_all_notes.dart';
import '../../domain/usecases/get_note.dart';
import '../../domain/usecases/update_note.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final GetAllNotes getAllNotes;
  final GetNote getNote;
  final CreateNote createNote;
  final UpdateNote updateNote;
  final DeleteNote deleteNote;

  NoteBloc({
    required this.getAllNotes,
    required this.getNote,
    required this.createNote,
    required this.updateNote,
    required this.deleteNote,
  }) : super(NotesInitial()) {
    on<GetAllNotesEvent>(_onGetAllNotes);
    on<GetNoteEvent>(_onGetNote);
    on<CreateNoteEvent>(_onCreateNote);
    on<UpdateNoteEvent>(_onUpdateNote);
    on<DeleteNoteEvent>(_onDeleteNote);
  }

  Future<void> _onGetAllNotes(
      GetAllNotesEvent event,
      Emitter<NoteState> emit,
      ) async {
    emit(NotesLoading());
    final result = await getAllNotes(NoParams());
    result.fold(
          (failure) => emit(NoteError(message: failure.toString())),
          (notes) => emit(NotesLoaded(notes: notes)),
    );
  }

  Future<void> _onGetNote(
      GetNoteEvent event,
      Emitter<NoteState> emit,
      ) async {
    emit(NotesLoading());
    final result = await getNote(NoteParams(id: event.id));
    result.fold(
          (failure) => emit(NoteError(message: failure.toString())),
          (note) => emit(NoteLoaded(note: note)),
    );
  }

  Future<void> _onCreateNote(
      CreateNoteEvent event,
      Emitter<NoteState> emit,
      ) async {
    emit(NotesLoading());
    final result = await createNote(
      CreateNoteParams(
        title: event.title,
        content: event.content,
      ),
    );
    result.fold(
          (failure) => emit(NoteError(message: failure.toString())),
          (note) {
        emit(NoteCreated(note: note));
        add(GetAllNotesEvent());
      },
    );
  }

  Future<void> _onUpdateNote(
      UpdateNoteEvent event,
      Emitter<NoteState> emit,
      ) async {
    emit(NotesLoading());
    final result = await updateNote(UpdateNoteParams(note: event.note));
    result.fold(
          (failure) => emit(NoteError(message: failure.toString())),
          (note) {
        emit(NoteUpdated(note: note));
        add(GetAllNotesEvent());
      },
    );
  }

  Future<void> _onDeleteNote(
      DeleteNoteEvent event,
      Emitter<NoteState> emit,
      ) async {
    emit(NotesLoading());
    final result = await deleteNote(DeleteNoteParams(id: event.id));
    result.fold(
          (failure) => emit(NoteError(message: failure.toString())),
          (_) {
        emit(NoteDeleted());
        add(GetAllNotesEvent());
      },
    );
  }
}

