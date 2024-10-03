import 'package:app/core/network/api.constants.dart';
import 'package:app/core/network/models/api_response.model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'playlist.api.g.dart';

@RestApi()
abstract class PlaylistApi {
  factory PlaylistApi(Dio dio, {String baseUrl}) = _PlaylistApi;

  @GET(ApiConstants.PLAYLIST)
  Future<PaginatedDataResponse> getPlaylists(
      @Queries() Map<String, dynamic> query);

  @POST(ApiConstants.PLAYLIST)
  Future<DataResponse> createPlaylist(
      @Body() Map<String, dynamic> body);

  @PATCH(ApiConstants.PLAYLIST_ID)
  Future<DataResponse> updatePlaylist(
      @Path('id') String id, @Body() Map<String, dynamic> body);

  @PATCH(ApiConstants.PLAYLIST_QUESTION_QID)
  Future<MessageResponse> addQuestionToPlaylist(
    @Path('questionId') String questionId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE(ApiConstants.PLAYLIST_ID)
  Future<MessageResponse> deletePlaylist(@Path('id') String id);
}
