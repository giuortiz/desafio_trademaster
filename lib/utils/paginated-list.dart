import 'dart:convert';
import 'package:desafio_trademaster/utils/response.dart';
import 'package:http/http.dart';

import 'filter-expression.dart';

class PaginatedList<T> {
  Function(Map<String, dynamic>) deserializer;
  final Response response;

  PaginatedList({ required this.response, required this.deserializer});

  NewResponse<T> mapToPaginatedList() {
    String? pagination = response.headers["x-pagination"];

    PaginationMetaData? paginationMetaData;

    if (pagination != null) {
      paginationMetaData = PaginationMetaData.fromJson(jsonDecode(pagination));
    }

    List<T> list = [];

    if (response.body.isNotEmpty) {
      list = (jsonDecode(response.body) as List)
          .map<T>((e) => deserializer(e))
          .toList();
    }

    return  NewResponse<T>(
        paginationMetaData: paginationMetaData!, body: list);
  }
}
