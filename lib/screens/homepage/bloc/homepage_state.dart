part of 'homepage_bloc.dart';

enum HomepageStatus { initial, loading, loaded, error }

class HomepageState {
  final HomepageStatus status;
  final List<HomeModel>? homeModel;
  final String? errorMessage;
  final String? selectedCategory;
  final String? selectedProduct;

  const HomepageState({
    this.status = HomepageStatus.initial,
    this.homeModel,
    this.errorMessage,
    this.selectedCategory,
    this.selectedProduct,
  });

  HomepageState copyWith({
    HomepageStatus? status,
    List<HomeModel>? homeModel,
    String? errorMessage,
    String? selectedCategory,
    String? selectedProduct,
  }) {
    return HomepageState(
      status: status ?? this.status,
      homeModel: homeModel ?? this.homeModel,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedProduct: selectedProduct ?? this.selectedProduct,
    );
  }
}