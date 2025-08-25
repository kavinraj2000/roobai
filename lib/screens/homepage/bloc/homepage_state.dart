part of 'homepage_bloc.dart';

enum HomepageStatus { initial, loading, loaded, error }

class HomepageState extends Equatable {
  final HomepageStatus status;
  final List<HomeModel>? homeModel;
  final List<HomeModel>? repo;
  final List<dynamic>? banners;
  final String? errorMessage;

  const HomepageState({
    this.status = HomepageStatus.initial,
    this.homeModel,
    this.repo,
    this.banners,
    this.errorMessage,
  });

  /// Factory for initial/default state
  factory HomepageState.initial() {
    return const HomepageState(
      status: HomepageStatus.initial,
      homeModel: [],
      repo: [],
      banners: [],
      errorMessage: '',
    );
  }

  /// Copy method to update specific fields immutably
  HomepageState copyWith({
    HomepageStatus? status,
    List<HomeModel>? homeModel,
    List<HomeModel>? repo,
    List<dynamic>? banners,
    String? errorMessage,
  }) {
    return HomepageState(
      status: status ?? this.status,
      homeModel: homeModel ?? this.homeModel,
      repo: repo ?? this.repo,
      banners: banners ?? this.banners,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, homeModel, repo, banners, errorMessage];
}
