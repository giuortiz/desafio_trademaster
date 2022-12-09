import 'package:desafio_trademaster/api/reddit/i_reddit-service.dart';
import 'package:desafio_trademaster/api/reddit/reddit-service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/filter-expression.dart';
import '../../../utils/response.dart';
import '../models/comunidade.dart';
import 'listagem-comunidades-model.dart';

class ListagemComunidadesCubit extends Cubit<ListagemComunidadesModel> {
  final IRedditService _redditService = RedditService();

  ListagemComunidadesCubit(super.initialState);

  Future<void> buscarListagemComunidades(
      String tema, SearchOptions searchOptions) async {
    PaginationMetaData paginationMetaData;
    List<Comunidade> lista;
    SearchOptions newSearchOptions;

    var response =
        await _redditService.buscarListagemReddit(searchOptions, tema);

    if (response != null) {
      lista = response;
      newSearchOptions = searchOptions;
      emit(state.patchState(
          listagemComunidades: lista, searchOptions: newSearchOptions));
    }
  }
}
