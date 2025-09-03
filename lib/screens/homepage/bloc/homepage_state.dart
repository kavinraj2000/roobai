part of 'homepage_bloc.dart';

enum HomepageStatus { initial, loading, loaded, error }

class HomepageState extends Equatable {
  final HomepageStatus status;
  final List<BannerModel> banner;
  final List<ProductModel> justscroll;
  final List<CategoryModel> category;
  final List<ProductModel> hourdeals;
  final List<ProductModel> mobileList;
  final Map<String, DateTime> countdownEndTimes;
  final Map<String, Duration> countdownRemaining;
  final String? errorMessage;

  const HomepageState({
    required this.status,
    required this.banner,
    required this.justscroll,
    required this.mobileList,
    required this.category,
    required this.hourdeals,
    required this.countdownEndTimes,
    required this.countdownRemaining,
    this.errorMessage,
  });

  factory HomepageState.initial() {
    return HomepageState(
      status: HomepageStatus.initial,
      banner: [],
      mobileList: [],
      justscroll: [],
      category: [],
      hourdeals: [],
      countdownEndTimes: {},
      countdownRemaining: {},
      errorMessage: null,
    );
  }

  HomepageState copyWith({
    HomepageStatus? status,
    List<BannerModel>? banner,
    List<ProductModel>? justscroll,
    List<ProductModel>? mobileList,
    List<CategoryModel>? category,
    List<ProductModel>? hourdeals,
    Map<String, DateTime>? countdownEndTimes,
    Map<String, Duration>? countdownRemaining,
    String? errorMessage,
  }) {
    return HomepageState(
      status: status ?? this.status,
      banner: banner ?? this.banner,
      justscroll: justscroll ?? this.justscroll,
      mobileList: mobileList ?? this.mobileList,
      category: category ?? this.category,
      hourdeals: hourdeals ?? this.hourdeals,
      countdownEndTimes: countdownEndTimes ?? this.countdownEndTimes,
      countdownRemaining: countdownRemaining ?? this.countdownRemaining,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        banner,
        justscroll,
        category,
        hourdeals,
        countdownEndTimes,
        countdownRemaining,
        errorMessage,
      ];
}
