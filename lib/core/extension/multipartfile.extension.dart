import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

extension Multipartfile on File? {
  MultipartFile? get toMultipartFile {
    if (this == null) return null;
    return MultipartFile.fromFileSync(
      this!.path,
      filename: this!.path.split('/').last,
      contentType: MediaType('image', 'jpeg'),
    );
  }
}
