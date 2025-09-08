part of 'mobilview_bloc.dart';

abstract class MobileviewEvent {}

class Loadingmobilevent extends MobileviewEvent {}

class Navigatetomobileurl extends MobileviewEvent {
  final String? producturl;

  Navigatetomobileurl(this.producturl);

  @override
  List<Object?> get props => [producturl];
}


class Refreshmobiles extends MobileviewEvent {
  final List<ProductModel> mobiles;

  Refreshmobiles(this.mobiles);

  @override
  List<Object> get props => [mobiles];
}
