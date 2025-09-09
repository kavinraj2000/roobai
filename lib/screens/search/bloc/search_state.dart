part of 'search_bloc.dart';

enum Searchstatus { initial, loading, loaded, noResults, failure }

class SearchState {
  final List<ProductModel> allProducts;
  final List<ProductModel> filteredProducts;
  final String searchQuery;
  final bool isLoading;
  final bool showSelectedOnly;
  final ProductModel? selectedProduct;
  final Searchstatus status;

  const SearchState({
    required this.allProducts,
    required this.filteredProducts,
    required this.searchQuery,
    required this.isLoading,
    required this.showSelectedOnly,
    this.selectedProduct,
    required this.status,
  });

  factory SearchState.initial() {
    return const SearchState(
      allProducts: [],
      filteredProducts: [],
      searchQuery: '',
      isLoading: false,
      showSelectedOnly: false,
      selectedProduct: null,
      status: Searchstatus.initial,
    );
  }

  SearchState copyWith({
    List<ProductModel>? allProducts,
    List<ProductModel>? filteredProducts,
    String? searchQuery,
    bool? isLoading,
    bool? showSelectedOnly,
    ProductModel? selectedProduct,
    Searchstatus? status,
  }) {
    return SearchState(
      allProducts: allProducts ?? this.allProducts,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
      showSelectedOnly: showSelectedOnly ?? this.showSelectedOnly,
      selectedProduct: selectedProduct ?? this.selectedProduct,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'SearchState(allProducts: ${allProducts.length}, filteredProducts: ${filteredProducts.length}, searchQuery: $searchQuery, isLoading: $isLoading, showSelectedOnly: $showSelectedOnly, status: $status)';
  }
}
