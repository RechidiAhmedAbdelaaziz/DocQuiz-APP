import 'package:app/core/di/container.dart';
import 'package:app/core/shared/dto/pagination.dto.dart';
import 'package:app/core/types/error_state.dart';
import 'package:app/feature/playlist/data/model/playlist.model.dart';
import 'package:app/feature/playlist/data/repo/playlist.repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'playlist.state.dart';

class PlaylistCubit extends Cubit<PlaylistState> {
  final _playlistRepo = locator<PlaylistRepo>();
  final _query = KeywordQuery();

  PlaylistCubit() : super(PlaylistState.initial());

  set keyword(String keyword) {
    _query.copyWith(keywords: keyword, page: 1);
    fetchPlaylists();
  }

  int get page => _query.page - 1;
  void nextPage() => fetchPlaylists();
  void prevPage() {
    if (_query.page > 1) {
      _query.copyWith(page: _query.page - 1);
      fetchPlaylists();
    }
  }

  Future<void> fetchPlaylists() async {
    final result = await _playlistRepo.getPlaylists(_query);

    result.when(
      success: (playlists) {
        if (playlists.isNotEmpty) {
          _query.copyWith(page: _query.page + 1);
          emit(state._fetchPlaylists(playlists));
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

  Future<void> updatePlaylist(
    PlaylistModel playlist, {
    required String title,
  }) async {
    final result = await _playlistRepo.updatePlaylist(
      playlist.id!,
      title: title,
    );

    result.when(
      success: (playlist) => emit(state.updatePlaylist(playlist)),
      error: (error) => emit(state._errorOccured(error.message)),
    );
  }

  Future<void> deletePlaylist(PlaylistModel playlist) async {
    final result = await _playlistRepo.deletePlaylist(playlist.id!);

    result.when(
      success: (_) => emit(state._deletePlaylist(playlist)),
      error: (error) => emit(state._errorOccured(error.message)),
    );
  }
}
