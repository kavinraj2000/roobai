import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roobai/screens/search/bloc/search_bloc.dart';
import 'package:roobai/screens/search/repo/search_repo.dart';
import 'package:roobai/screens/search/view/mobile/search.dart';


class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (context) {
        final bloc = SearchBloc(Searchrepository())
        ..add(SearchQueryChanged(''));
        return bloc;
      },
      child: const SearchScreen(),
    );
  }
}
