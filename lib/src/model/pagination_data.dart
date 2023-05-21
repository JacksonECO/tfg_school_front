import 'package:flutter/foundation.dart';

class PaginationData<T> {
  final List<T> data;
  final int rowsPerPage;
  final int totalElements;
  final String search;
  int page;

  PaginationData({
    required this.data,
    required this.rowsPerPage,
    required this.totalElements,
    required this.page,
    this.search = '',
  });

  int get totalPage => (totalElements / rowsPerPage).ceil();

  PaginationData<T> copyWith({
    List<T>? data,
    int? rowsPerPage,
    int? totalElements,
    String? search,
    int? page,
  }) {
    return PaginationData<T>(
      data: data ?? this.data,
      rowsPerPage: rowsPerPage ?? this.rowsPerPage,
      totalElements: totalElements ?? this.totalElements,
      search: search ?? this.search,
      page: page ?? this.page,
    );
  }

  factory PaginationData.fromMap(Map<String, dynamic> map) {
    return PaginationData<T>(
      data: map['data'] as List<T>,
      rowsPerPage: map['rowsPerPage'] as int,
      totalElements: map['totalElements'] as int,
      search: map['search'] as String,
      page: map['page'] as int,
    );
  }

  @override
  String toString() {
    return 'PaginationData(data: $data, rowsPerPage: $rowsPerPage, totalElements: $totalElements, search: $search, page: $page)';
  }

  @override
  bool operator ==(covariant PaginationData<T> other) {
    if (identical(this, other)) return true;

    return listEquals(other.data, data) &&
        other.rowsPerPage == rowsPerPage &&
        other.totalElements == totalElements &&
        other.search == search &&
        other.page == page;
  }

  @override
  int get hashCode {
    return data.hashCode ^
        rowsPerPage.hashCode ^
        totalElements.hashCode ^
        search.hashCode ^
        page.hashCode;
  }
}
