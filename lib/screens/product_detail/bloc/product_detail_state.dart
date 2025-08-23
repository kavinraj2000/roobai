part of 'product_detail_bloc.dart';

enum ProductDetailStatus { initial, loading, loaded, failure }

class ProductDetailState extends Equatable {
  final ProductDetailStatus status;
  final String message;
  final Map<String, dynamic>? productdetail;
  final bool isFavorite;
  final bool showFullDescription;
  final bool animationsInitialized;

  const ProductDetailState({
    required this.status,
    required this.productdetail,
    required this.message,
    required this.isFavorite,
    required this.showFullDescription,
    required this.animationsInitialized,
  });

  static initial() {
    return ProductDetailState(
      status: ProductDetailStatus.initial,
      productdetail: null,
      message: '',
      animationsInitialized: false,
      isFavorite: false,
      showFullDescription: false,
    );
  }

  ProductDetailState copyWith({
    ProductDetailStatus? status,
    String? message,
    Map<String, dynamic>? productdetail,
     bool? isFavorite,
   bool? showFullDescription,
   bool? animationsInitialized,

  }) {
    return ProductDetailState(
      productdetail: productdetail ?? this.productdetail,
      message: message ?? this.message,
      status: status ?? this.status,
      animationsInitialized: animationsInitialized ?? this.animationsInitialized,
      isFavorite: isFavorite ?? this.isFavorite,
      showFullDescription: showFullDescription ?? this.showFullDescription
    );
  }

  @override
  List<Object?> get props => [status, message, productdetail,animationsInitialized,isFavorite,showFullDescription];
}
