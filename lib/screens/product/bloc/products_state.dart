

part of 'products_bloc.dart';

enum DealfinderStatus  {initial,loading,loaded,failure}
 class ProductState extends Equatable{
final DealfinderStatus status;
final String message;
final List<Product>? dealModel;
final List<Product>? likeStatus;

const ProductState({
  required this.status,required this.dealModel,required this.message,this.likeStatus
});

static initial(){
  return ProductState(status: DealfinderStatus.initial,dealModel:null ,message: '',likeStatus: null);
}
ProductState copyWith({
   DealfinderStatus? status,
 String? message,
 List<Product>? dealModel,
 List<Product>? likeStatus,
  
}){return ProductState(dealModel: dealModel ?? this.dealModel,message: message ?? this.message,status: status ?? this.status,likeStatus: likeStatus ?? this.likeStatus);
}
  
  @override
  
  List<Object?> get props => [status,message,dealModel,likeStatus];

 }