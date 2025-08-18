part of 'search_bloc.dart';

abstract class SearchEvent {}

class SearchQueryChanged extends SearchEvent {
  final String query;
  SearchQueryChanged(this.query);
}

class ToggleShowSelectedOnly extends SearchEvent {}

class SelectProduct extends SearchEvent {
  final String product;
  SelectProduct(this.product);
}
