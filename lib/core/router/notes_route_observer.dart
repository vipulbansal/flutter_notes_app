import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/notes/presentation/bloc/note_bloc.dart';

class NotesRouteObserver extends NavigatorObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute?.settings.name == 'notesList') {
      debugPrint('[Observer] Returned to notes list. Refreshing notes...');
      final context = navigator?.context;
      if (context != null && context.mounted) {
        context.read<NoteBloc>().add(GetAllNotesEvent());
      }
    }
  }
}