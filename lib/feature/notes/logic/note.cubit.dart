import 'package:app/core/di/container.dart';
import 'package:app/core/types/error_state.dart';
import 'package:app/feature/notes/data/model/note.model.dart';
import 'package:app/feature/notes/data/repo/notes.repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'note.state.dart';

class NoteCubit extends Cubit<NoteState> {
  final _noteRepo = locator<NotesRepo>();
  final String questionId;
  NoteCubit(this.questionId) : super(NoteState.initial());

  void fetchNote() async {
    final result = await _noteRepo.getNote(questionId);

    result.when(
      success: (note) => emit(state._fetchNote(note)),
      error: (error) => emit(state._errorOccured(error.message)),
    );
  }

  void addNotes(String note) async {
    final result = await _noteRepo.addNotes(questionId, note: note);

    result.when(
      success: (note) => emit(state._fetchNote(note)),
      error: (error) => emit(state._errorOccured(error.message)),
    );
  }

  void updateNotes(String index, String newNote) async {
    final result = await _noteRepo.updateNotes(
      state.note!.id,
      index,
      newNote: newNote,
    );

    result.when(
      success: (note) => emit(state._fetchNote(note)),
      error: (error) => emit(state._errorOccured(error.message)),
    );
  }

  void deleteNotes(String index) async {
    final result = await _noteRepo.updateNotes(
      state.note!.id,
      index,
      deleteNote: true,
    );

    result.when(
      success: (note) => emit(state._fetchNote(note)),
      error: (error) => emit(state._errorOccured(error.message)),
    );
  }
}
