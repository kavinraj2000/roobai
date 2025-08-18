import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';


class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState.initial()) {
    on<SearchQueryChanged>((event, emit) {
      final filtered = state.allProducts
          .where((product) => product.toLowerCase().contains(event.query.toLowerCase()))
          .toList();

      emit(state.copyWith(
        searchQuery: event.query,
        filteredProducts: filtered,
        isLoading: false,
      ));
    });

    on<ToggleShowSelectedOnly>((event, emit) {
      final updated = !state.showSelectedOnly;
      final filtered = updated
          ? state.allProducts.where((p) => p == state.selectedProduct).toList()
          : state.allProducts;

      emit(state.copyWith(
        showSelectedOnly: updated,
        filteredProducts: filtered,
      ));
    });

    on<SelectProduct>((event, emit) {
      emit(state.copyWith(selectedProduct: event.product));
    });
  }
}
