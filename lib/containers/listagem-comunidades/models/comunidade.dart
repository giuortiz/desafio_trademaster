class Comunidade {
  String? kind;
  List<Comunidade>? childrem;
  String? title;

  Comunidade({this.kind, this.childrem, this.title});

  static Comunidade fromJson(Map<String, dynamic> json) {
    return Comunidade(
      kind: json["kind"],
      childrem: (json["data"] as List)
              .map((x) => Comunidade.fromJson(x))
              .toList()
,
      title: json["title"],
    );
  }
}
