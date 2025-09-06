part of 'drawe_bloc.dart';

enum Drawerstatus{initial,loading,loaded,error,failure}

class DrawerState extends Equatable{
  final Drawerstatus status;
  final List<CategoryModel> category;
  final String message;
  final     CategoryModel? selectedCategory;


  const DrawerState({
    required this.status,
    required this.category,
    required this.message,
    required this.selectedCategory,
  });

  static initial(){
    return DrawerState(
      category: [],
      status: Drawerstatus.initial,
      message: '',
      selectedCategory: null,

    );
  }

  DrawerState copyWith({
      Drawerstatus? status,
   List<CategoryModel>? category,
       CategoryModel? selectedCategory,

   String? message,
  }){
    return DrawerState(category: category ?? this.category,message: message ??this.message,status: status ?? this.status,selectedCategory: selectedCategory ?? this.selectedCategory,);
  }
  @override
  List<Object?> get props => [status,category,message,selectedCategory];

}