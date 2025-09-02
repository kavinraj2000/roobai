part of 'homepage_bloc.dart';

enum HomepageStatus { 
  initial, 
  loading, 
  loaded, 
  error 
}
// Add this property to your existing HomepageState class

class HomepageState extends Equatable {
  final HomepageStatus status;
  final List<BannerModel>? banner;
  final List<ProductModel>? justscroll;
  final List<CategoryModel>? category;
  final List<BannerModel>? bigCatBanners;
  final List<BannerModel>? whatsappBanners; 
  final String? errorMessage;
  final List<dynamic>? categories;

  const HomepageState({
    required this.status,
    this.banner,
    this.justscroll,
    this.category,
    this.bigCatBanners,
    this.whatsappBanners,
    this.errorMessage,
    this.categories,
  });

  factory HomepageState.initial() {
    return const HomepageState(
      status: HomepageStatus.initial,
      banner: null,
      justscroll: null,
      category: null,
      bigCatBanners: null,
      whatsappBanners: null,
      errorMessage: null,
      categories: null,
    );
  }

  HomepageState copyWith({
    HomepageStatus? status,
    List<BannerModel>? banner,
    List<ProductModel>? justscroll,
    List<CategoryModel>? category,
    List<BannerModel>? bigCatBanners,
    List<BannerModel>? whatsappBanners, // Add this line
    String? errorMessage,
    List<dynamic>? categories,
  }) {
    return HomepageState(
      status: status ?? this.status,
      banner: banner ?? this.banner,
      justscroll: justscroll ?? this.justscroll,
      category: category ?? this.category,
      bigCatBanners: bigCatBanners ?? this.bigCatBanners,
      whatsappBanners: whatsappBanners ?? this.whatsappBanners,
      errorMessage: errorMessage ?? this.errorMessage,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [
    status,
    banner,
    justscroll,
    category,
    bigCatBanners,
    whatsappBanners,
    errorMessage,
    categories,
  ];
}