import 'package:app/core/di/container.dart';
import 'package:app/core/network/try_call_api.dart';
import 'package:app/core/shared/dto/pagination.dto.dart';
import 'package:app/core/types/repo_functions.type.dart';
import 'package:app/feature/playlist/data/dto/playlists_question.dto.dart';
import 'package:app/feature/playlist/data/model/playlist.model.dart';
import 'package:app/feature/playlist/data/source/playlist.api.dart';

class PlaylistRepo {
  final _palylistApi = locator<PlaylistApi>();

  RepoListResult<PlaylistModel> getPlaylists(KeywordQuery query,
      {String? questionId}) async {
    apiCall() async {
      final response =
          await _palylistApi.getPlaylists({
            ...query.toJson(), if (questionId != null) 'questionId': questionId
          });
      return response.data!
          .map((e) => PlaylistModel.fromJson(e))
          .toList();
    }

    return await TryCallApi.call(apiCall);
  }

  RepoResult<PlaylistModel> createPlaylist(String title) async {
    apiCall() async {
      final response =
          await _palylistApi.createPlaylist({'title': title});
      return PlaylistModel.fromJson(response.data!);
    }

    return await TryCallApi.call(apiCall);
  }

  RepoResult<PlaylistModel> updatePlaylist(
    String id, {
    String? title,
    String? addQuestionId,
    String? removeQuestionId,
  }) async {
    apiCall() async {
      final response = await _palylistApi.updatePlaylist(id, {
        if (title != null) 'title': title,
        if (removeQuestionId != null)
          'removeQuestionId': removeQuestionId,
      });
      return PlaylistModel.fromJson(response.data!);
    }

    return await TryCallApi.call(apiCall);
  }

  RepoResult<void> addQuestionToPlaylist(
    String questionId, {
    required AddQuestionToPlaylistsDto body,
  }) async {
    apiCall() async => await _palylistApi.addQuestionToPlaylist(
        questionId, body.toJson());

    return await TryCallApi.call(apiCall);
  }

  RepoResult<void> deletePlaylist(String id) async {
    apiCall() async => await _palylistApi.deletePlaylist(id);

    return await TryCallApi.call(apiCall);
  }
}
