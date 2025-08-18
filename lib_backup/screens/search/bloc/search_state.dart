part of 'search_bloc.dart';
enum Searchstatus{initial,loading,loaded,failure}
class SearchState {
  final Searchstatus status;
  final List<String> allProducts;
  final List<String> filteredProducts;
  final String selectedProduct;
  final String searchQuery;
  final bool isLoading;
  final bool showSelectedOnly;

  const SearchState({
    required this.status,
    required this.allProducts,
    required this.filteredProducts,
    required this.selectedProduct,
    required this.searchQuery,
    this.isLoading = false,
    this.showSelectedOnly = false,
  });

  SearchState copyWith({
    Searchstatus? status,
    List<String>? allProducts,
    List<String>? filteredProducts,
    String? selectedProduct,
    String? searchQuery,
    bool? isLoading,
    bool? showSelectedOnly,
  }) {
    return SearchState(
      status: status ?? this.status,
      allProducts: allProducts ?? this.allProducts,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      selectedProduct: selectedProduct ?? this.selectedProduct,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
      showSelectedOnly: showSelectedOnly ?? this.showSelectedOnly,
    );
  }

  factory SearchState.initial() {
    const products = [
      'iPhone 14',
      'Samsung Galaxy S21',
      'MacBook Pro',
      'Dell XPS 13',
      'Sony Headphones',
      'Apple Watch',
      'LG OLED TV',
      'Google Pixel 6',
      'Asus ROG Laptop',
    ];

    return const SearchState(
      status: Searchstatus.initial,
      allProducts: products,
      filteredProducts: products,
      selectedProduct: '',
      searchQuery: '',
      isLoading: false,
      showSelectedOnly: false,
    );
  }


}