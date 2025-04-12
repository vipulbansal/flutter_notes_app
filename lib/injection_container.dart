import 'package:flutter_notes_app/features/notes/data/datasources/local/note_local_data_source.dart';
import 'package:flutter_notes_app/features/notes/data/models/note_model.dart';
import 'package:flutter_notes_app/features/notes/data/repositories/note_repository_impl.dart';
import 'package:flutter_notes_app/features/notes/domain/repositories/note_repository.dart';
import 'package:flutter_notes_app/features/notes/domain/usecases/create_note.dart';
import 'package:flutter_notes_app/features/notes/domain/usecases/delete_note.dart';
import 'package:flutter_notes_app/features/notes/domain/usecases/get_all_notes.dart';
import 'package:flutter_notes_app/features/notes/domain/usecases/get_note.dart';
import 'package:flutter_notes_app/features/notes/domain/usecases/update_note.dart';
import 'package:flutter_notes_app/features/notes/presentation/bloc/note_bloc.dart';
import 'package:flutter_notes_app/features/notes/presentation/bloc/theme_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl=GetIt.instance;


Future<void> init()async{
  final notesBox=await Hive.openBox<NoteModel>('notes');
  sl.registerLazySingleton(()=>notesBox);
  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  sl.registerLazySingleton(()=>sharedPreferences);
  sl.registerLazySingleton<NoteLocalDataSource>(()=>NoteLocalDataSourceImpl(notesBox: notesBox));
  sl.registerLazySingleton<NoteRepository>(()=>NoteRepositoryImpl(localDataSource: sl()));
  sl.registerLazySingleton(()=>CreateNote(sl()));
  sl.registerLazySingleton(()=>DeleteNote(sl()));
  sl.registerLazySingleton(()=>GetAllNotes(sl()));
  sl.registerLazySingleton(()=>GetNote(sl()));
  sl.registerLazySingleton(()=>UpdateNote(sl()));
  sl.registerFactory(()=>ThemeCubit(sharedPreferences: sl()));
  sl.registerFactory(()=>NoteBloc(getAllNotes: sl(), getNote: sl(),
      createNote: sl(), updateNote: sl(), deleteNote: sl()));

}