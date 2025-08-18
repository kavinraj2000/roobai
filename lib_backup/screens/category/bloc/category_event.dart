part of 'category_bloc.dart';

abstract class CategoryEvent{}

class LoadingCategoryevent extends CategoryEvent  {
  final String? data;
  LoadingCategoryevent(this.data);
}
