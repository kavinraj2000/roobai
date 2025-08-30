part of 'products_bloc.dart';

enum DealfinderStatus { initial, loading, loaded, failure }

class ProductState extends Equatable {
  final DealfinderStatus status;
  final String message;
  final List<Product>? dealModel;
  final List<HomeModel>? homemodel;
  final int? page;
  final bool isFavorite;

  const ProductState({
    required this.status,
    required this.dealModel,
    required this.message,
    this.homemodel,
    required this.page,
    required this.isFavorite,
    
  });

  static initial() {
    return ProductState(
      status: DealfinderStatus.initial,
      dealModel: null,
      message: '',
      homemodel: null,
      page: 0,
      isFavorite: false
    );
  }

  ProductState copyWith({
    DealfinderStatus? status,
    String? message,
    List<Product>? dealModel,
    List<HomeModel>? homemodel,
    int? page,
    bool? isFavorite,
  }) {
    return ProductState(
      dealModel: dealModel ?? this.dealModel,
      message: message ?? this.message,
      status: status ?? this.status,
      homemodel: homemodel ?? this.homemodel,
      page: page ??this.page,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [status, message, dealModel, homemodel,page,isFavorite];
}
