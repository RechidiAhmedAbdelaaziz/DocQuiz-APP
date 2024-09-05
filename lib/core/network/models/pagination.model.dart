part of 'api_response.model.dart';


class _Paginations {
  final int? page;
  final int? length;
  final int? next;
  final int? prev;

  _Paginations({
    this.page,
    this.length,
    this.next,
    this.prev,
  });

  factory _Paginations.fromJson(Map<String, dynamic>? json) {
    return _Paginations(
      page: json?['page'],
      length: json?['length'],
      next: json?['next'],
      prev: json?['prev'],
    );
  }
}