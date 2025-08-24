part of 'homepage_bloc.dart';

// States
enum HomepageStatus { initial, loading, loaded, error }

class HomepageState extends Equatable {
  final HomepageStatus status;
  final List<HomeModel>? homeModel;
  final List<Data>? banners;
  final String? errorMessage;

  const HomepageState({
    this.status = HomepageStatus.initial,
    this.homeModel,
    this.banners,
    this.errorMessage,
  });

  HomepageState copyWith({
    HomepageStatus? status,
    List<HomeModel>? homeModel,
    List<Data>? banners,
    String? errorMessage,
  }) {
    return HomepageState(
      status: status ?? this.status,
      homeModel: homeModel ?? this.homeModel,
      banners: banners ?? this.banners,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, homeModel, banners, errorMessage];
}
