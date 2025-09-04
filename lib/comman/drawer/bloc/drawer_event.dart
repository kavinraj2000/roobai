part of 'drawe_bloc.dart';

abstract class Drawerevent {}

class Loadincategoryevent extends Drawerevent {}
class SelectCategory extends Drawerevent {
  final CategoryModel category;
  SelectCategory(this.category);
}