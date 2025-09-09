import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:roobai/comman/model/product_model.dart';
import 'package:roobai/screens/category/repo/category_repo.dart';
import 'package:roobai/screens/homepage/repo/homepage_repo.dart';
import 'package:roobai/screens/search/repo/search_repo.dart';
import 'package:url_launcher/url_launcher.dart';

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
    on<NavigateToProductEvent>(_onNavigateToProduct);

    // Load all products when bloc is initialized
    add(LoadAllProducts());
  }

  Future<void> _onLoadAllProducts(
    LoadAllProducts event,
    Emitter<SearchState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      // Load all products from multiple pages if needed
      List<ProductModel> allProducts = [];
      int page = 1;
      bool hasMorePages = true;
      
      while (hasMorePages) {
        try {
          final pageProducts = await repo.getJustScrollProducts(page: page);
          
          if (pageProducts.isEmpty) {
            hasMorePages = false;
          } else {
            allProducts.addAll(pageProducts);
            page++;
            
            // Optional: Add a limit to prevent infinite loading
            if (page > 10) { // Adjust this limit as needed
              hasMorePages = false;
            }
          }
        } catch (e) {
          log.w('Error loading page $page: $e');
          hasMorePages = false;
        }
      }

      log.d('_onLoadAllProducts: Loaded ${allProducts.length} total products');

      emit(
        state.copyWith(
          allProducts: allProducts,
          filteredProducts: [],
          isLoading: false,
          status: Searchstatus.initial,
        ),
      );

      log.d('SearchBloc: Successfully loaded ${allProducts.length} products');
    } catch (e) {
      emit(state.copyWith(status: Searchstatus.failure, isLoading: false));
      log.e('SearchBloc::_onLoadAllProducts::error::$e');
    }
  }
  Future<void> _onNavigateToProduct(
    NavigateToProductEvent event,
    Emitter<SearchState> emit,
  ) async {
    try {
      final productUrl = event.productUrl;

      if (productUrl == null || productUrl.isEmpty) {
        emit(
          state.copyWith(
            status: Searchstatus.failure,
            // : "Invalid product URL",
          ),
        );
        return;
      }

      final url = productUrl.startsWith("http")
          ? productUrl
          : "https://$productUrl";
      final uri = Uri.parse(url);
      log.i('_onNavigateToProduct:uri:::::$uri');

      HapticFeedback.mediumImpact();

      final launched = await launchUrl(uri, mode: LaunchMode.inAppWebView);

      if (!launched) {
        emit(
          state.copyWith(
            status: Searchstatus.failure,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: Searchstatus.failure,
        ),
      );
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

      // If no products are loaded yet, load them first
      if (state.allProducts.isEmpty && query.isNotEmpty) {
        emit(state.copyWith(isLoading: true));
        add(LoadAllProducts());
        return;
      }

      if (query.isEmpty) {
        emit(
          state.copyWith(filteredProducts: [], status: Searchstatus.initial),
        );
        return;
      }

      await Future.delayed(const Duration(milliseconds: 300));
      
      if (state.searchQuery != query) return;

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

    List<ProductModel> filtered;
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

  List<ProductModel> _filterProducts(List<ProductModel> products, String query) {
    if (query.isEmpty) return [];

    final queryLower = query.toLowerCase();

    return products.where((product) {
      final productName = product.productName?.toLowerCase() ?? '';
      final productDescription = product.productDescription?.toLowerCase() ?? '';
      // final productCategory = product.productName?.toLowerCase() ?? '';
      // final productBrand = product.productBrand?.toLowerCase() ?? '';
      
      // Search in multiple fields for better results
      return productName.contains(queryLower) ||
             productDescription.contains(queryLower); 
            //  productCategory.contains(queryLower) ||
            //  productBrand.contains(queryLower);
    }).toList();
  }

  void refreshProducts() {
    add(LoadAllProducts());
  }
}