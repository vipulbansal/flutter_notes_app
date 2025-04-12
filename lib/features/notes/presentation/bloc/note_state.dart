part of 'note_bloc.dart';

abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

class NotesInitial extends NoteState {}

class NotesLoading extends NoteState {}

class NotesLoaded extends NoteState {
  final List<Note> notes;

  const NotesLoaded({required this.notes});

  @override
  List<Object> get props => [notes];
}

class NoteLoaded extends NoteState {
  final Note note;

  const NoteLoaded({required this.note});

  @override
  List<Object> get props => [note];
}

class NoteCreated extends NoteState {
  final Note note;

  const NoteCreated({required this.note});

  @override
  List<Object> get props => [note];
}

class NoteUpdated extends NoteState {
  final Note note;

  const NoteUpdated({required this.note});

  @override
  List<Object> get props => [note];
}

class NoteDeleted extends NoteState {}

class NoteError extends NoteState {
  final String message;

  const NoteError({required this.message});

  @override
  List<Object> get props => [message];
}
