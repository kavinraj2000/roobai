part of 'best_products_bloc.dart';

enum BestProductStatus { initial, loading, loaded, failure }

class BestProductState extends Equatable {
  final BestProductStatus status;
  final String message;
  final List<Product>? dealModel;
  final List<HomeModel>? homemodel;
  final int? page;
  final bool hasMore;

  const BestProductState({
    required this.status,
    required this.dealModel,
    required this.message,
    this.homemodel,
    required this.page,
    required this.hasMore,
    
  });

  static initial() {
    return BestProductState(
      status: BestProductStatus.initial,
      dealModel: null,
      message: '',
      homemodel: null,
      page: 0,
      hasMore: false
    );
  }

  BestProductState copyWith({
    BestProductStatus? status,
    String? message,
    List<Product>? dealModel,
    List<HomeModel>? homemodel,
    int? page,
    bool? hasMore,
  }) {
    return BestProductState(
      dealModel: dealModel ?? this.dealModel,
      message: message ?? this.message,
      status: status ?? this.status,
      homemodel: homemodel ?? this.homemodel,
      page: page ??this.page,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [status, message, dealModel, homemodel,page,hasMore];
}
