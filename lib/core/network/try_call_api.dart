
import 'package:app/core/types/api_result.type.dart';
import 'package:flutter/material.dart';

import 'api_error.handler.dart';

class TryCallApi {
  static Future<ApiResult<T>> call<T>(
      Future<T> Function() apiCall) async {
    try {
      return ApiResult.success(await apiCall());
    } catch (error) {
      debugPrint(
          '\n\n!!!\n TryCallApi error: ${error.toString()} \n!!!\n\n');
      return ApiResult.error(ApiErrorHandler.handle(error));
    }
  }
}
