import 'package:app/core/di/container.dart';
import 'package:app/core/extension/list.extension.dart';
import 'package:app/core/shared/dto/pagination.dto.dart';
import 'package:app/core/types/error_state.dart';
import 'package:app/feature/playlist/data/dto/playlists_question.dto.dart';
import 'package:app/feature/playlist/data/model/playlist.model.dart';
import 'package:app/feature/playlist/data/repo/playlist.repo.dart';
import 'package:app/feature/question/data/model/question.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'playlist_save.state.dart';

class SavePlaylistCubit extends Cubit<SavePlaylistState> {
  final _playlistRepo = locator<PlaylistRepo>();
  final _query = KeywordQuery();
  final String _questionId;
  SavePlaylistCubit(QuestionModel question)
      : _questionId = question.id!,
        super(SavePlaylistState.initial());

  set keyword(String keyword) {
    _query.copyWith(keywords: keyword, page: 1);
    fetchPlaylists(toAdd: false);
  }

  void selectPlaylist(PlaylistModel playlist) =>
      emit(state._selectPlaylist(playlist));

  Future<void> fetchPlaylists({
    bool toAdd = true,
  }) async {
    final result = await _playlistRepo.getPlaylists(
      _query,
      questionId: _questionId,
    );

    result.when(
      success: (playlists) {
        if (playlists.isNotEmpty) {
          _query.copyWith(page: _query.page + 1);
          emit(state._fetchPlaylists(playlists, toAdd: toAdd));
        } else {
          emit(state
              ._errorOccured('Il n\'y a pas de playlist disponible'));
        }
      },
      error: (error) => emit(state._errorOccured(error.message)),
    );
  }

  Future<void> createPlaylist(String title) async {
    final result = await _playlistRepo.createPlaylist(title);

    result.when(
      success: (playlist) => emit(state._createPlaylist(playlist)),
      error: (error) => emit(state._errorOccured(error.message)),
    );
  }

  Future<void> submit() async {
    await _playlistRepo.addQuestionToPlaylist(
      _questionId,
      body: state._dto,
    );

    emit(state._done());
  }
}
