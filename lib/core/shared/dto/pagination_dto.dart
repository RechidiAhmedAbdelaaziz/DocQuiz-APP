import 'package:app/core/extension/map.extension.dart';
import 'package:app/core/shared/classes/editioncontollers/number_editingcontroller.dart';
import 'package:flutter/material.dart';

class PaginationDto {
  final IntEditingcontroller page;
  final IntEditingcontroller limit;
  final TextEditingController keywordController;
  final TextEditingController fields;
  final TextEditingController sort;

  PaginationDto({
    int page = 1,
    int limit = 10,
    String? keyword,
    String? fields,
    String? sort,
  })  : keywordController = TextEditingController(text: keyword),
        fields = TextEditingController(text: fields),
        sort = TextEditingController(text: sort),
        page = IntEditingcontroller(page),
        limit = IntEditingcontroller(limit);

  Map<String, dynamic> toJson() => {
        'page': page.value,
        'limit': limit.value,
        if (keywordController.text.isNotEmpty)
          'keyword': keywordController.text,
        if (fields.text.isNotEmpty) 'fields': fields.text,
        if (sort.text.isNotEmpty) 'sort': sort.text,
      }.withoutNullsOrEmpty();

  void dispose() {
    page.dispose();
    limit.dispose();
    keywordController.dispose();
    fields.dispose();
    sort.dispose();
  }

  void nextPage() => page.add(1);
  void firstPage() => page.setValue(1);
  void prevPage() => page.subtract(1);
}
