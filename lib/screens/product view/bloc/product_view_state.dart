part of 'protuct_view_bloc.dart';

enum ProductViewStatus { initial, loading, loaded, error }

class ProductviewState extends Equatable {
  final ProductViewStatus status;
  final List<ProductModel> justscroll;

  final List<ProductModel>? hourdeals;
  final List<ProductModel> mobileList;
  final List<ProductModel>? currentViewProducts;
  final int page;
  final bool hasReachedMax;
  final String? errorMessage;
  final List<ProductModel>? filteredProducts;
  final String? selectedCategoryId;

  const ProductviewState({
    required this.status,
    required this.justscroll,
    this.filteredProducts,
    this.selectedCategoryId,
    this.hourdeals,
   required this.mobileList,
    this.currentViewProducts,
    required this.page,
    required this.hasReachedMax,
    this.errorMessage,
  });

  factory ProductviewState.initial() {
    return const ProductviewState(
      status: ProductViewStatus.initial,
      selectedCategoryId: '',
      errorMessage: '',
      filteredProducts: [],
      hourdeals: [],
      mobileList: [],
      justscroll: [],
      page: 0,
      hasReachedMax: false,
      currentViewProducts: null, // NEW FIELD
    );
  }

  ProductviewState copyWith({
    ProductViewStatus? status,
    List<ProductModel>? justscroll,
    List<ProductModel>? hourdeals,
    List<ProductModel>? mobileList,
    List<ProductModel>? currentViewProducts,
    int? page,
    bool? hasReachedMax,
    String? errorMessage,
    List<ProductModel>? filteredProducts,
    String? selectedCategoryId,
  }) {
    return ProductviewState(
      status: status ?? this.status,
      justscroll: justscroll ?? this.justscroll,
      hourdeals: hourdeals ?? this.hourdeals,
      mobileList: mobileList ?? this.mobileList,
      currentViewProducts: currentViewProducts ?? this.currentViewProducts,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
    );
  }

  @override
  List<Object?> get props => [
    status,
    justscroll,
    filteredProducts,
    selectedCategoryId,
    hourdeals,
    mobileList,
    currentViewProducts,
    page,
    hasReachedMax,
    errorMessage,
  ];
}
