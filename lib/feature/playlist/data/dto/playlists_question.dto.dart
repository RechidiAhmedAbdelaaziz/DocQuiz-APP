import 'package:app/core/extension/list.extension.dart';
import 'package:app/feature/playlist/data/model/playlist.model.dart';

class AddQuestionToPlaylistsDto {
  final List<String> playlistsToAdd;
  final List<String> playlistsToRemove;
  final List<PlaylistModel> playlistsSelected;

  AddQuestionToPlaylistsDto({
    List<String>? playlistsToAdd,
    List<String>? playlistsToRemove,
    this.playlistsSelected = const [],
  })  : playlistsToAdd = playlistsToAdd ?? <String>[],
        playlistsToRemove = playlistsToRemove ?? <String>[];

  Map<String, dynamic> toJson() {
    return {
      'playlistsToAdd': playlistsToAdd,
      'playlistsToRemove': playlistsToRemove,
    };
  }

  set playlist(PlaylistModel playlist) =>
      playlistsToAdd.contains(playlist.id)
          ? _removePlaylist(playlist)
          : _addPlaylist(playlist);

  void _addPlaylist(PlaylistModel playlist) {
    playlistsToAdd.addUniq(playlist.id!);
    playlistsToRemove.remove(playlist.id!);
  }

  void _removePlaylist(PlaylistModel playlist) {
    playlistsToAdd.remove(playlist.id!);
    if (playlistsSelected.contains(playlist)) {
      playlistsToRemove.addUniq(playlist.id!);
    }
  }

  factory AddQuestionToPlaylistsDto.fromPlaylists(
      List<PlaylistModel> playlists) {
    final selected = playlists.where((e) => e.isIn == true).toList();
    return AddQuestionToPlaylistsDto(
      playlistsToAdd: selected.map((e) => e.id!).toList(),
      playlistsToRemove: [],
      playlistsSelected: selected,
    );
  }
}
