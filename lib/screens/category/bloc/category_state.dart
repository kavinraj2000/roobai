part of 'category_bloc.dart';


enum CategoryStatus { initial, loading, loaded, failure }

class CategoryState extends Equatable {
  final CategoryStatus status;
  final String message;
  final List<ProductModel>? dealModel;
  final int? page;

  const CategoryState({
    required this.status,
    required this.dealModel,
    required this.message,
    required this.page,
    
  });

  static initial() {
    return CategoryState(
      status: CategoryStatus.initial,
      dealModel: null,
      message: '',
      page: 0,
    );
  }

  CategoryState copyWith({
    CategoryStatus? status,
    String? message,
    List<ProductModel>? dealModel,
    int? page,
    bool? isFavorite,
  }) {
    return CategoryState(
      dealModel: dealModel ?? this.dealModel,
      message: message ?? this.message,
      status: status ?? this.status,
      page: page ??this.page,
    );
  }

  @override
  List<Object?> get props => [status, message, dealModel,page];
}
