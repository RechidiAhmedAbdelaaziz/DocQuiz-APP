import 'package:app/core/di/container.dart';
import 'package:app/core/network/try_call_api.dart';
import 'package:app/core/types/repo_functions.type.dart';
import 'package:app/feature/notes/data/model/note.model.dart';
import 'package:app/feature/notes/data/source/notes.api.dart';

class NotesRepo {
  final _notesApi = locator<NotesApi>();

  RepoResult<NoteModel> getNote(String questionId) async {
    apiCall() async {
      final response = await _notesApi.getNotes(questionId);
      return NoteModel.fromJson(response.data!);
    }

    return await TryCallApi.call(apiCall);
  }

  RepoResult<NoteModel> addNotes(
    String questionId, {
    required String note,
  }) async {
    apiCall() async {
      final response = await _notesApi.addNotes(
        questionId,
        {
          'note': note,
        },
      );
      return NoteModel.fromJson(response.data!);
    }

    return await TryCallApi.call(apiCall);
  }

  RepoResult<NoteModel> updateNotes(
    String noteId,
    String index, {
    String? newNote,
    bool? deleteNote,
  }) async {
    apiCall() async {
      final response = await _notesApi.updateNotes(
        noteId,
        index,
        {
          if (newNote != null) 'note': newNote,
          if (deleteNote != null) 'delete': deleteNote,
        },
      );
      return NoteModel.fromJson(response.data!);
    }

    return await TryCallApi.call(apiCall);
  }
}
