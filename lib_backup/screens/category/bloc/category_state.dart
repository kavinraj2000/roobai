part of 'category_bloc.dart';

enum CategoryStatus {initial,loading,loaded,failure,error}

class Categorystate {

  final CategoryStatus status;
  final String message;
  final List<CategoryModel> category;

  const Categorystate({
    required this.status,
    required this.message,
    required this.category,

  });

  static initial(){
    return Categorystate(status: CategoryStatus.initial, message: '', category: []);
  }

  Categorystate copyWith({
  CategoryStatus? status,
   String? message,
   List<CategoryModel>? category,

  }){
    return Categorystate(status: status ?? this.status, message: message ?? this.message, category: category ?? this.category);
  }


}