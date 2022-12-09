import 'dart:convert';

import 'package:desafio_trademaster/utils/response.dart';

import '../../containers/listagem-comunidades/models/comunidade.dart';
import '../../utils/filter-expression.dart';
import '../../utils/paginated-list.dart';
import '../../utils/request.dart';
import 'i_reddit-service.dart';

class RedditService extends Service implements IRedditService {
  RedditService() : super();

  @override
  Future<List<Comunidade>?> buscarListagemReddit(
      SearchOptions searchOptions, String tema) async {
    searchOptions.pagination.dist=3;
    searchOptions.pagination.limit=3;
    List<Comunidade> lista = [];
    try {
      String param = searchOptions.toHttpParams();
      String url = "https://www.reddit.com/r/$tema/top.json$param";

      var response = await request(url, Service.HTTP_GET);

      for (var typeElement in (json.decode(response!.body) as Map).entries) {
        if (typeElement.key == "data") {
          typeElement.value.entries.forEach((element) {
            if (element.key == "children") {
              element.value.forEach((secondElement) {
                lista.add(Comunidade(title: secondElement['data']['title']));
              });
            }
          });
        }
      }

      return lista;
    } catch (e) {
      return null;
    }
  }
}
