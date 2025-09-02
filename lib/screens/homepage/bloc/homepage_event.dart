part of 'homepage_bloc.dart';

abstract class HomepageEvent extends Equatable {
  const HomepageEvent();

  @override
  List<Object> get props => [];
}

class LoadHomepageData extends HomepageEvent {}

class Livenowdata extends HomepageEvent {
  final List<ProductModel> product;
  const Livenowdata(this.product);
}

class LoadBanners extends HomepageEvent {}

class LoadCategories extends HomepageEvent {
  final List<HomeModel> homeModels;
  LoadCategories(this.homeModels);
}
class NavigateToProductEvent extends HomepageEvent {
  final String? productUrl;
  NavigateToProductEvent(this.productUrl);
}
// Add this new event to your existing homepage_event.dart file

class OpenWhatsAppEvent extends HomepageEvent {
  final String? whatsappUrl;

  const OpenWhatsAppEvent({
    required this.whatsappUrl,
  });

}