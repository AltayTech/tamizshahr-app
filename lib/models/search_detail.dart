class SearchDetail {
  final int total;
  final int max_page;

  SearchDetail({
    this.total = -1,
    this.max_page = 10,
  });

  factory SearchDetail.fromJson(Map<String, dynamic> parsedJson) {
    return SearchDetail(
      total: parsedJson['total'],
      max_page: parsedJson['max_pages'],
    );
  }
}
