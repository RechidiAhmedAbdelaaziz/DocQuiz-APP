class PaginationQuery {
  int page;
  int limit;

  PaginationQuery({
    this.page = 1,
    this.limit = 10,
  });

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'limit': limit,
    };
  }

  void nextPage() => copyWith(page: page + 1);

  void copyWith({
    int? page,
    int? limit,
  }) {
    this.page = page ?? this.page;
    this.limit = limit ?? this.limit;
  }
}

class KeywordQuery extends PaginationQuery {
  String? keywords;

  KeywordQuery({
    this.keywords,
    super.page,
    super.limit,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'keywords': keywords,
      ...super.toJson(),
    };
  }

  @override
  void copyWith({
    String? keywords,
    int? page,
    int? limit,
  }) {
    this.keywords = keywords ?? this.keywords;
    super.copyWith(page: page, limit: limit);
  }
}
