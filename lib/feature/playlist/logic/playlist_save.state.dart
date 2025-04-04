part of 'playlist_save.cubit.dart';

class SavePlaylistState extends ErrorState {
  SavePlaylistState({
    required this.playlists,
    this.done = false,
    AddQuestionToPlaylistsDto? dto,
    String? error,
  })  : _dto = dto ?? AddQuestionToPlaylistsDto(),
        super(error);

  final List<PlaylistModel> playlists;
  final AddQuestionToPlaylistsDto _dto;
  final bool done;

  bool isSelected(PlaylistModel playlist) {
    return _dto.playlistsToAdd.contains(playlist.id);
  }

  factory SavePlaylistState.initial() =>
      SavePlaylistState(playlists: []);

  SavePlaylistState _fetchPlaylists(List<PlaylistModel> playlists,
      {bool toAdd = true}) {
    return _copyWith(
      playlists: (toAdd ? this.playlists : [])..addAllUniq(playlists),
      dto: AddQuestionToPlaylistsDto.fromPlaylists(this.playlists),
    );
  }

  SavePlaylistState _selectPlaylist(PlaylistModel playlist) {
    _dto.playlist = playlist;

    return _copyWith();
  }

  SavePlaylistState _createPlaylist(PlaylistModel playlist) {
    return _copyWith(playlists: [playlist, ...playlists]);
  }

  SavePlaylistState _done() => _copyWith(done: true);

  SavePlaylistState _errorOccured(String error) =>
      _copyWith(error: error);

  SavePlaylistState _copyWith({
    List<PlaylistModel>? playlists,
    bool? done,
    String? error,
    AddQuestionToPlaylistsDto? dto,
  }) =>
      SavePlaylistState(
        playlists: playlists ?? this.playlists,
        error: error,
        done: done ?? this.done,
        dto: dto ?? _dto,
      );

  void onSaved(void Function() onSaved) {
    if (done) {
      onSaved();
    }
  }
}
