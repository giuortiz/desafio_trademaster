import 'package:desafio_trademaster/containers/listagem-comunidades/models/comunidade.dart';
import 'package:desafio_trademaster/utils/filter-expression.dart';

class ListagemComunidadesModel {
  List<Comunidade>? listagemComunidades;
  SearchOptions? searchOptions;
  PaginationMetaData? paginationMetaData;

  ListagemComunidadesModel(
      {this.searchOptions, this.listagemComunidades, this.paginationMetaData});

  ListagemComunidadesModel patchState({List<Comunidade>? listagemComunidades,
    SearchOptions? searchOptions, PaginationMetaData? paginationMetaData}) {
    return ListagemComunidadesModel(
        listagemComunidades: listagemComunidades ?? this.listagemComunidades,
        searchOptions: searchOptions ?? this.searchOptions,
        paginationMetaData: paginationMetaData ?? this.paginationMetaData);
  }
}
