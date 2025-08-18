

part of 'dealfinder_bloc.dart';

enum DealfinderStatus  {initial,loading,loaded,failure}
 class DealfinderState extends Equatable{
final DealfinderStatus status;
final String message;
final DealModel? dealModel;

const DealfinderState({
  required this.status,required this.dealModel,required this.message
});

static initial(){
  return DealfinderState(status: DealfinderStatus.initial,dealModel:null ,message: '');
}
DealfinderState copyWith({
   DealfinderStatus? status,
 String? message,
 DealModel? dealModel,
  
}){return DealfinderState(dealModel: dealModel ?? this.dealModel,message: message ?? this.message,status: status ?? this.status);
}
  
  @override
  
  List<Object?> get props => [status,message,dealModel];

 }