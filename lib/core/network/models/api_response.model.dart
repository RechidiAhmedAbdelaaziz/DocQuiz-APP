import 'package:json_annotation/json_annotation.dart';

part 'tokens.model.dart';
part 'pagination.model.dart';

part 'api_response.model.g.dart';

abstract class _ApiResponseModel {
  final bool? success;
  final int? statusCode;

  _ApiResponseModel({
    this.success,
    this.statusCode,
  });
}

@JsonSerializable(createToJson: false)
class TokensResponse extends _ApiResponseModel {
  final AuthTokens? tokens;

  TokensResponse({
    super.success,
    super.statusCode,
    this.tokens,
  });

  factory TokensResponse.fromJson(Map<String, dynamic>? json) =>
      _$TokensResponseFromJson(json ?? {});
}

@JsonSerializable(createToJson: false)
class MessageResponse extends _ApiResponseModel {
  final String? message;

  MessageResponse({
    super.success,
    super.statusCode,
    this.message,
  });

  factory MessageResponse.fromJson(Map<String, dynamic>? json) =>
      _$MessageResponseFromJson(json ?? {});
}

@JsonSerializable(createToJson: false)
class DataResponse extends _ApiResponseModel {
  final Map<String, dynamic>? data;

  DataResponse({
    super.success,
    super.statusCode,
    this.data,
  });

  factory DataResponse.fromJson(Map<String, dynamic>? json) =>
      _$DataResponseFromJson(json ?? {});
}

@JsonSerializable(createToJson: false)
class PaginatedDataResponse extends _ApiResponseModel {
  final List<Map<String, dynamic>>? data;
  final _Paginations? pagination;

  PaginatedDataResponse({
    super.success,
    super.statusCode,
    this.data = const [],
    this.pagination,
  });

  factory PaginatedDataResponse.fromJson(
          Map<String, dynamic>? json) =>
      _$PaginatedDataResponseFromJson(json ?? {});
}

@JsonSerializable(createToJson: false)
class PaginatedObjectDataResponse extends _ApiResponseModel {
  final Map<String, dynamic>? data;
  final _Paginations? pagination;

  PaginatedObjectDataResponse({
    super.success,
    super.statusCode,
    this.data,
    this.pagination,
  });

  factory PaginatedObjectDataResponse.fromJson(
          Map<String, dynamic>? json) =>
      _$PaginatedObjectDataResponseFromJson(json ?? {});
}
