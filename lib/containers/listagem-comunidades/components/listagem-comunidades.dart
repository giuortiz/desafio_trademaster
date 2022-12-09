import 'package:desafio_trademaster/containers/listagem-comunidades/bloc/listagem-comunidades-model.dart';
import 'package:desafio_trademaster/utils/filter-expression.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import '../bloc/listagem-comunidades-cubit.dart';

class ListagemComunidades extends StatefulWidget {
  const ListagemComunidades({Key? key}) : super(key: key);

  @override
  State<ListagemComunidades> createState() => _ListagemComunidadesState();
}

class _ListagemComunidadesState extends State<ListagemComunidades> {
  final ListagemComunidadesCubit _bloc = ListagemComunidadesCubit(
      ListagemComunidadesModel(
          searchOptions: SearchOptions(),
          paginationMetaData: PaginationMetaData(),
          listagemComunidades: []));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocProvider(
      create: (contextProvider) {
        return _bloc;
      },
      child: BlocBuilder<ListagemComunidadesCubit, ListagemComunidadesModel>(
        builder: (context, state) {
          return Scaffold(
            body: _buildBody(context, state),
          );
        },
      ),
    ));
  }

  Widget _buildBody(BuildContext context, state) {
    return Column(
      children: [_buildSearchBar(), _buildList(state)],
    );
  }

  Widget _buildSearchBar() {
    return SearchBarAnimation(
      textEditingController: TextEditingController(),
      isOriginalAnimation: false,
      buttonBorderColour: Colors.black45,
      buttonWidget: const Icon(Icons.search),
      secondaryButtonWidget: const Icon(Icons.search),
      trailingWidget: const Icon(Icons.search),
      onFieldSubmitted: (String value) {
        SearchOptions searchOptions = _bloc.state.searchOptions!;
        _bloc.buscarListagemComunidades(value, searchOptions);
      },
    );
  }

  Widget _buildList(state) {
    if (state.listagemComunidades!.isNotEmpty) {
      return Expanded(
          child: ListView.builder(
              itemCount: state.listagemComunidades.length,
              itemBuilder: (context, index) => Container(
                    margin:
                        const EdgeInsets.only(bottom: 16, right: 16, left: 16),
                    child: Material(
                      color: Colors.white,
                      elevation: 4,
                      borderRadius: BorderRadius.circular(6),
                      child: ListTile(
                        leading: Text(state.listagemComunidades[index].title!),
                      ),
                    ),
                  )));
    } else {
      return Container(
        margin: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
        child: Material(
            elevation: 4,
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Text(
                "Nenhum item a ser apresentado",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            )),
      );
    }
  }
}
