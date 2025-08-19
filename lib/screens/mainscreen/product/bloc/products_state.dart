

part of 'products_bloc.dart';

enum DealfinderStatus  {initial,loading,loaded,failure}
 class ProductState extends Equatable{
final DealfinderStatus status;
final String message;
final List<Product>? dealModel;

const ProductState({
  required this.status,required this.dealModel,required this.message
});

static initial(){
  return ProductState(status: DealfinderStatus.initial,dealModel:null ,message: '');
}
ProductState copyWith({
   DealfinderStatus? status,
 String? message,
 List<Product>? dealModel,
  
}){return ProductState(dealModel: dealModel ?? this.dealModel,message: message ?? this.message,status: status ?? this.status);
}
  
  @override
  
  List<Object?> get props => [status,message,dealModel];

 }