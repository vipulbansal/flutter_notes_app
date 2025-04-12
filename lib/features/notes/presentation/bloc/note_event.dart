part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class GetAllNotesEvent extends NoteEvent {}

class GetNoteEvent extends NoteEvent {
  final String id;

  const GetNoteEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class CreateNoteEvent extends NoteEvent {
  final String title;
  final String content;

  const CreateNoteEvent({
    required this.title,
    required this.content,
  });

  @override
  List<Object> get props => [title, content];
}

class UpdateNoteEvent extends NoteEvent {
  final Note note;

  const UpdateNoteEvent({required this.note});

  @override
  List<Object> get props => [note];
}

class DeleteNoteEvent extends NoteEvent {
  final String id;

  const DeleteNoteEvent({required this.id});

  @override
  List<Object> get props => [id];
}
