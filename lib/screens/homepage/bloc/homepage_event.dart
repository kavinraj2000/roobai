part of 'homepage_bloc.dart';

abstract class HomepageEvent extends Equatable {
  const HomepageEvent();

  @override
  List<Object> get props => [];
}

class LoadHomepageData extends HomepageEvent {}

class Livenowdata extends HomepageEvent {
  final List<HomeModel> homemodel;
  const Livenowdata(this.homemodel);
}

class LoadBanners extends HomepageEvent {}

class LoadCategories extends HomepageEvent {
  final List<HomeModel> homeModels;
  LoadCategories(this.homeModels);
}
