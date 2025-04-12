import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class GetNote implements UseCase<Note, NoteParams> {
  final NoteRepository repository;

  GetNote(this.repository);

  @override
  Future<Either<Failure, Note>> call(NoteParams params) async {
    return await repository.getNote(params.id);
  }
}

class NoteParams extends Equatable {
  final String id;

  const NoteParams({required this.id});

  @override
  List<Object> get props => [id];
}
