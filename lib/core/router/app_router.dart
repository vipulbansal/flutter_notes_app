import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


import '../../features/notes/presentation/pages/note_detail_page.dart';
import '../../features/notes/presentation/pages/note_edit_page.dart';
import '../../features/notes/presentation/pages/notes_list_page.dart';
import 'notes_route_observer.dart';


/// AppRouter handles the navigation configuration for the app using go_router
class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    observers: [NotesRouteObserver()],
    routes: [
      // Main notes list page
      GoRoute(
        path: '/',
        name: 'notesList',
        builder: (context, state) {
          return  NotesListPage();},
        routes: [
          // Note detail page
          GoRoute(
            path: 'notes/:id',
            name: 'noteDetail',
            builder: (context, state) {
              final id = state.pathParameters['id'] ?? '';
              final timestamp = DateTime.now().millisecondsSinceEpoch;
              return NoteDetailPage(key: ValueKey('$id-$timestamp'),id: id);
            },
            routes: [
              // Edit note page
              GoRoute(
                path: 'edit',
                name: 'noteEdit',
                builder: (context, state) {
                  final id = state.pathParameters['id'] ?? '';
                  return NoteEditPage(id: id);
                },
              ),
            ],
          ),
          // Create note page
          GoRoute(
            path: 'create',
            name: 'noteCreate',
            builder: (context, state) => const NoteEditPage(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'The page ${state.uri.path} does not exist',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    ),
  );
}