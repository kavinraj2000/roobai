part of 'product_detail_bloc.dart';
enum ProductDetailStatus  {initial,loading,loaded,failure}

 class ProductDetailState extends Equatable{
final ProductDetailStatus status;
final String message;
final List<Product>? productdetail;

const ProductDetailState({
  required this.status,required this.productdetail,required this.message,
});

static initial(){
  return ProductDetailState(status: ProductDetailStatus.initial,productdetail:null ,message: '',);
}
ProductDetailState copyWith({
   ProductDetailStatus? status,
 String? message,
 List<Product>? productdetail,
 List<Product>? likeStatus,
  
}){return ProductDetailState(productdetail: productdetail ?? this.productdetail,message: message ?? this.message,status: status ?? this.status,);
}
  
  @override
  
  List<Object?> get props => [status,message,productdetail,];

 }