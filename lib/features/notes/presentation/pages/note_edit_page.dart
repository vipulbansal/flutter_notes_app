import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/note.dart';
import '../bloc/note_bloc.dart';

class NoteEditPage extends StatefulWidget {
  final String? id;

  // If id is null, it means we're creating a new note
  const NoteEditPage({Key? key, this.id}) : super(key: key);

  @override
  State<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends State<NoteEditPage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;
  late Note? _currentNote;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.id != null;
    
    if (_isEditing) {
      // Load the note for editing
      BlocProvider.of<NoteBloc>(context).add(GetNoteEvent(id: widget.id!));
    } else {
      _currentNote = null;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _populateFields(Note note) {
    _titleController.text = note.title;
    _contentController.text = note.content;
    _currentNote = note;
  }

  void _saveNote() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_isEditing && _currentNote != null) {
        // Update existing note
        final updatedNote = Note(
          id: _currentNote!.id,
          title: _titleController.text,
          content: _contentController.text,
          createdAt: _currentNote!.createdAt,
          updatedAt: DateTime.now(),
        );
        
        context.read<NoteBloc>().add(UpdateNoteEvent(note: updatedNote));

      } else {
        // Create new note
        context.read<NoteBloc>().add(
          CreateNoteEvent(
            title: _titleController.text,
            content: _contentController.text,
          ),
        );
        context.go('/');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Note' : 'Create Note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: BlocConsumer<NoteBloc, NoteState>(
        listener: (context, state) {
          if (state is NoteLoaded && _isEditing && _titleController.text.isEmpty) {
            _populateFields(state.note);
          }
          else if (state is NoteUpdated) {
            context.go('/notes/${_currentNote!.id}');
          }
        },
        builder: (context, state) {
          if (state is NotesLoading && _isEditing) {
            return const Center(child: CircularProgressIndicator());
          }
          
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _contentController,
                      decoration: const InputDecoration(
                        labelText: 'Content (Markdown supported)',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(),
                        hintText: 'Write your note here...',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some content';
                        }
                        return null;
                      },
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Markdown formatting is supported',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}