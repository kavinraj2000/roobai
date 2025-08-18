part of 'dealfinder_bloc.dart';
abstract class DealFinderEvent {}

class FetchDealFinderData extends DealFinderEvent {
  final String dealType;
  final bool navigateOnLoad;

  FetchDealFinderData({required this.dealType, this.navigateOnLoad = false});
}
