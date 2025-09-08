part of 'category_bloc.dart';

enum CategoryStatus { initial, loading, loaded, failure }

class CategoryState extends Equatable {
  final CategoryStatus status;
  final String message;
  final List<ProductModel>? dealModel;
  final int? page;
  final int total;
  final int perPage;
  final bool isFetching;
  final bool hasReachedMax;
  final String? currentCid;

  const CategoryState({
    required this.status,
    required this.dealModel,
    required this.message,
    required this.page,
    required this.perPage,
    required this.isFetching,
    required this.total,
    required this.hasReachedMax,
    this.currentCid,
  });

  static initial() {
    return CategoryState(
      status: CategoryStatus.initial,
      dealModel: null,
      message: '',
      page: 0,
      isFetching: false,
      perPage: 20,
      total: 0,
      hasReachedMax: false,
      currentCid: null,
    );
  }

  CategoryState copyWith({
    CategoryStatus? status,
    String? message,
    List<ProductModel>? dealModel,
    int? total,
    int? page,
    int? perPage,
    bool? isFetching,
    bool? hasReachedMax,
    String? currentCid,
  }) {
    return CategoryState(
      dealModel: dealModel ?? this.dealModel,
      message: message ?? this.message,
      status: status ?? this.status,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      isFetching: isFetching ?? this.isFetching,
      total: total ?? this.total,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentCid: currentCid ?? this.currentCid,
    );
  }

  @override
  List<Object?> get props => [
        status,
        message,
        dealModel,
        page,
        perPage,
        isFetching,
        total,
        hasReachedMax,
        currentCid,
      ];
}
