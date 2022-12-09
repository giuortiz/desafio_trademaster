class FilterExpression {
  String? propertyName;
  dynamic value;
  String? operator;
  String? operatorBetween;

  FilterExpression(
      {this.value, this.propertyName, this.operator, this.operatorBetween});
}

class OrderByExpression {
  String? propertyName;
  String? orientation;

  OrderByExpression({this.propertyName, this.orientation});
}

class SearchOptions {
  late Pagination pagination;
  late List<FilterExpression> filters;
  late List<OrderByExpression> orders;

  SearchOptions() {
    filters = [];
    orders = [];
    pagination = new Pagination();
  }

  String toHttpParams() {
    Map<String, String> params = {};

    for (var i = 0; i < filters.length; i++) {
      var filter = filters[i];

      params["Filters[$i].propertyName"] = filter.propertyName!;
      params["Filters[$i].value"] = filter.value;
      params["Filters[$i].operator"] = filter.operator!;
      params["Filters[$i].operatorBetween"] = filter.operatorBetween!;
    }

    for (var i = 0; i < orders.length; i++) {
      var order = orders[i];

      params["Orders[$i].propertyName"] = order.propertyName!;
      params["Orders[$i].orientation"] = order.orientation!;
    }

    params["dist"] = pagination.dist.toString();
    params["limit"] = pagination.limit.toString();


    return Uri.https("", "", params).toString().replaceAll("https:", "");
  }
}

class Pagination {
  late int dist;
  late int limit;

  Pagination() {
    dist = 1;
    limit = 20;
  }
}

class PaginationMetaData {
  int? currentPage;
  int? totalPages;
  int? pageSize;
  int? totalCount;
  bool? hasPrevious;
  bool? hasNext;
  int? start;
  int? limit;

  PaginationMetaData(
      {this.currentPage,
      this.totalPages,
      this.pageSize,
      this.totalCount,
      this.hasPrevious,
      this.hasNext,
      this.start,
      this.limit});

  factory PaginationMetaData.fromJson(Map<String, dynamic> json) {
    return PaginationMetaData(
        currentPage: json["currentPage"],
        totalPages: json["totalPages"],
        pageSize: json["pageSize"],
        totalCount: json["totalCount"],
        hasPrevious: json["hasPrevious"],
        hasNext: json["hasNext"],
        limit: json["limit"],
        start: json["start"]);
  }
}
