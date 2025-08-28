import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:roobai/screens/product/model/products.dart';
import 'package:roobai/screens/search/repo/search_repo.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final Searchrepository repo;
  final log = Logger();

  SearchBloc(this.repo) : super(SearchState.initial()) {
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<LoadAllProducts>(_onLoadAllProducts);
    on<ToggleShowSelectedOnly>(_onToggleShowSelectedOnly);
    on<SelectProduct>(_onSelectProduct);

    add(LoadAllProducts());
  }

  Future<void> _onLoadAllProducts(
    LoadAllProducts event,
    Emitter<SearchState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      final allProducts = await repo.getProductdata();

      emit(
        state.copyWith(
          allProducts: allProducts,
          filteredProducts: [],
          isLoading: false,
          status: Searchstatus.initial,
        ),
      );

      log.d('SearchBloc: Loaded ${allProducts.length} products');
    } catch (e) {
      emit(state.copyWith(status: Searchstatus.failure, isLoading: false));
      log.e('SearchBloc::_onLoadAllProducts::error::$e');
    }
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    try {
      log.d('SearchBloc:_onSearchQueryChanged::query::${event.query}');

      final query = event.query.trim();

      emit(state.copyWith(searchQuery: query, isLoading: false));

      if (query.isEmpty) {
        emit(
          state.copyWith(filteredProducts: [], status: Searchstatus.initial),
        );
        return;
      }

      final filtered = _filterProducts(state.allProducts, query);

      emit(
        state.copyWith(
          filteredProducts: filtered,
          status: filtered.isEmpty
              ? Searchstatus.noResults
              : Searchstatus.loaded,
        ),
      );

      log.d(
        'SearchBloc: Found ${filtered.length} products for query: "$query"',
      );
    } catch (e) {
      emit(state.copyWith(status: Searchstatus.failure));
      log.e('SearchBloc::_onSearchQueryChanged::error::$e');
    }
  }

  void _onToggleShowSelectedOnly(
    ToggleShowSelectedOnly event,
    Emitter<SearchState> emit,
  ) {
    final updated = !state.showSelectedOnly;

    List<Product> filtered;
    if (updated && state.selectedProduct != null) {
      filtered = [state.selectedProduct!];
    } else {
      filtered = state.searchQuery.isEmpty
          ? []
          : _filterProducts(state.allProducts, state.searchQuery);
    }

    emit(state.copyWith(showSelectedOnly: updated, filteredProducts: filtered));
  }

  void _onSelectProduct(SelectProduct event, Emitter<SearchState> emit) {
    emit(state.copyWith(selectedProduct: event.product));
  }

  List<Product> _filterProducts(List<Product> products, String query) {
    if (query.isEmpty) return [];

    final queryLower = query.toLowerCase();

    return products.where((product) {
      final productName = product.productName?.toLowerCase() ?? '';

      return productName.contains(queryLower);
    }).toList();
  }
}
