part of 'homepage_bloc.dart';

enum HomepageStatus { initial, loading, loaded, error }

class HomepageState extends Equatable {
  final HomepageStatus status;
  final List<ProductModel>? justscroll;
  final List<CategoryModel>? category;
  final List<BannerModel>? banner;
  final List<ProductModel>? hourdeals;
  final List<ProductModel>? mobileList;
  final List<ProductModel>? currentViewProducts; // NEW FIELD
  final int page;
  final bool hasReachedMax;
  final String? errorMessage;

  const HomepageState({
    required this.status,
    this.justscroll,
    this.category,
    this.banner,
    this.hourdeals,
    this.mobileList,
    this.currentViewProducts, // NEW FIELD
    required this.page,
    required this.hasReachedMax,
    this.errorMessage,
  });

  factory HomepageState.initial() {
    return const HomepageState(
      status: HomepageStatus.initial,
      page: 0,
      hasReachedMax: false,
      currentViewProducts: null, // NEW FIELD
    );
  }

  HomepageState copyWith({
    HomepageStatus? status,
    List<ProductModel>? justscroll,
    List<CategoryModel>? category,
    List<BannerModel>? banner,
    List<ProductModel>? hourdeals,
    List<ProductModel>? mobileList,
    List<ProductModel>? currentViewProducts, // NEW FIELD
    int? page,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return HomepageState(
      status: status ?? this.status,
      justscroll: justscroll ?? this.justscroll,
      category: category ?? this.category,
      banner: banner ?? this.banner,
      hourdeals: hourdeals ?? this.hourdeals,
      mobileList: mobileList ?? this.mobileList,
      currentViewProducts: currentViewProducts ?? this.currentViewProducts, // NEW FIELD
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        justscroll,
        category,
        banner,
        hourdeals,
        mobileList,
        currentViewProducts, // NEW FIELD
        page,
        hasReachedMax,
        errorMessage,
      ];
}