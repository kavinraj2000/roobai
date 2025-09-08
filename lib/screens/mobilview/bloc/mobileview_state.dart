part of 'mobilview_bloc.dart';


enum Mobilviewstatus { initial, loading, loaded, error, failure }

class Mobilviewstate extends Equatable {
  final Mobilviewstatus status;
  final List<ProductModel> mobilelist;
  final int page;
  final bool hasReachedMax;
  final String? errorMessage;

  const Mobilviewstate({
    required this.status,
    required this.page,
    required this.hasReachedMax,
    required this.errorMessage,
    required this.mobilelist,
  });

  factory Mobilviewstate.initial() {
    return const Mobilviewstate(
      status: Mobilviewstatus.initial,
      page: 0,
      hasReachedMax: false,
      errorMessage: '',
      mobilelist: [],
    );
  }

  Mobilviewstate copyWith({
    Mobilviewstatus? status,
    List<ProductModel>? mobilelist,
    int? page,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return Mobilviewstate(
      status: status ?? this.status,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
      mobilelist: mobilelist ?? this.mobilelist,
    );
  }

  @override
  List<Object?> get props => [
        status,
        page,
        hasReachedMax,
        errorMessage,
        mobilelist,
      ];
}
