part of 'homepage_bloc.dart';

enum HomepageStatus { initial, loading, loaded, error }

class HomepageState extends Equatable {
  final HomepageStatus status;
  final List<HomeModel> homeModel;
  final List<dynamic> banners;
  final List<dynamic> categories;
  final List<dynamic> justin;
  final List<dynamic> livenow;
  final String errorMessage;

  const HomepageState({
    this.status = HomepageStatus.initial,
    this.homeModel = const [],
    this.banners = const [],
    this.livenow=const[],
    this.justin = const [],
    this.categories = const [],
    this.errorMessage = '',
  });

  HomepageState copyWith({
    HomepageStatus? status,
    List<HomeModel>? homeModel,
    List<dynamic>? livenow,
    List<dynamic>? banners,
    List<dynamic>? justin,
    List<dynamic>? categories,
    String? errorMessage,
  }) {
    return HomepageState(
      status: status ?? this.status,
      homeModel: homeModel ?? this.homeModel,
      livenow: livenow ?? this.livenow,
      banners: banners ?? this.banners,
      justin: justin ?? this.justin,
      categories: categories ?? this.categories,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [status, homeModel, banners, categories,justin, errorMessage,livenow];
}
