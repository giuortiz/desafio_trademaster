

import '../../containers/listagem-comunidades/models/comunidade.dart';
import '../../utils/filter-expression.dart';
import '../../utils/response.dart';

abstract class IRedditService {
  Future<List<Comunidade>?> buscarListagemReddit(
      SearchOptions searchOptions, String tema);
}