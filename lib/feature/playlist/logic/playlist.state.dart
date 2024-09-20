part of 'playlist.cubit.dart';

class PlaylistState extends ErrorState {
  PlaylistState({
    required this.playlists,
    String? error,
  }) : super(error);

  final List<PlaylistModel> playlists;

  factory PlaylistState.initial() => PlaylistState(playlists: []);

  PlaylistState _fetchPlaylists(List<PlaylistModel> playlists) =>
      _copyWith(playlists: playlists);

  PlaylistState _createPlaylist(PlaylistModel playlist) =>
      _copyWith(playlists: [playlist, ...playlists]);

  PlaylistState updatePlaylist(PlaylistModel playlist) {
    playlists[playlists.indexOf(playlist)] = playlist;
    return _copyWith(playlists: playlists);
  }

  PlaylistState _deletePlaylist(PlaylistModel playlist) =>
      _copyWith(playlists: playlists..remove(playlist));

  PlaylistState _errorOccured(String error) =>
      _copyWith(error: error);

  PlaylistState _copyWith({
    List<PlaylistModel>? playlists,
    String? error,
  }) =>
      PlaylistState(
        playlists: playlists ?? this.playlists,
        error: error,
      );
}
