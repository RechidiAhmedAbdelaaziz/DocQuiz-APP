// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokensResponse _$TokensResponseFromJson(Map<String, dynamic> json) =>
    TokensResponse(
      success: json['success'] as bool?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
      tokens: json['tokens'] == null
          ? null
          : _Tokens.fromJson(json['tokens'] as Map<String, dynamic>?),
    );

MessageResponse _$MessageResponseFromJson(Map<String, dynamic> json) =>
    MessageResponse(
      success: json['success'] as bool?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

DataResponse _$DataResponseFromJson(Map<String, dynamic> json) => DataResponse(
      success: json['success'] as bool?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
      data: json['data'] as Map<String, dynamic>?,
    );

PaginatedDataResponse _$PaginatedDataResponseFromJson(
        Map<String, dynamic> json) =>
    PaginatedDataResponse(
      success: json['success'] as bool?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          const [],
      pagination: json['pagination'] == null
          ? null
          : _Paginations.fromJson(json['pagination'] as Map<String, dynamic>?),
    );

PaginatedObjectDataResponse _$PaginatedObjectDataResponseFromJson(
        Map<String, dynamic> json) =>
    PaginatedObjectDataResponse(
      success: json['success'] as bool?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
      data: json['data'] as Map<String, dynamic>?,
      pagination: json['pagination'] == null
          ? null
          : _Paginations.fromJson(json['pagination'] as Map<String, dynamic>?),
    );
