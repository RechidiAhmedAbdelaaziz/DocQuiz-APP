import 'package:app/core/network/models/api_response.model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'notes.api.g.dart';

@RestApi()
abstract class NotesApi {
  factory NotesApi(Dio dio, {String baseUrl}) = _NotesApi;

  @GET('/notes/{questionId}')
  Future<DataResponse> getNotes(
      @Path('questionId') String questionId);

  @POST('notes/{questionId}')
  Future<DataResponse> addNotes(@Path('questionId') String questionId,
      @Body() Map<String, dynamic> body);

  @PATCH('notes/{noteId}/{index}')
  Future<DataResponse> updateNotes(
    @Path('noteId') String noteId,
    @Path('index') String index,
    @Body() Map<String, dynamic> body,
  );
}
