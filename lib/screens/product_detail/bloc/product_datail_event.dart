part of 'product_detail_bloc.dart';

abstract class Productdetailevent{}

class Initialvalueevent extends Productdetailevent{
  final Map<String,dynamic> initialvalue;
  Initialvalueevent(this.initialvalue);
}
class ToggleFavoriteEvent extends Productdetailevent {}

class ToggleDescriptionEvent extends Productdetailevent {}

class InitializeAnimationsEvent extends Productdetailevent {}