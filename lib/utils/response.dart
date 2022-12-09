import 'filter-expression.dart';

class NewResponse<T> {
  final PaginationMetaData paginationMetaData;
  final List<T> body;

  NewResponse({required this.paginationMetaData, required this.body});
}
