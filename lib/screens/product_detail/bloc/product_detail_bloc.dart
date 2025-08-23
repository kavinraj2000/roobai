import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';

part 'product_datail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<Productdetailevent, ProductDetailState> {
  final log = Logger();

  ProductDetailBloc() : super(ProductDetailState.initial()) {
    on<Initialvalueevent>(_onInitialvalueevent);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<ToggleDescriptionEvent>(_onToggleDescription);
    on<InitializeAnimationsEvent>(_onInitializeAnimations);
  }

  Future<void> _onInitialvalueevent(
    Initialvalueevent event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(state.copyWith(status: ProductDetailStatus.loading));

    try {
      final productId = event.initialvalue;
      log.d('ProductDetailBloc::Loading product ID: $productId');

     

     
      emit(state.copyWith(
        status: ProductDetailStatus.loaded,
        productdetail: event.initialvalue,
        message: "Product loaded successfully",
      ));
    } catch (e) {
      log.e('ProductDetailBloc::Error: $e');
      emit(state.copyWith(
        status: ProductDetailStatus.failure,
        message: "Failed to load product details",
      ));
    }
  }
  void _onToggleFavorite(ToggleFavoriteEvent event, Emitter<ProductDetailState> emit) {
    HapticFeedback.mediumImpact();
    emit(state.copyWith(isFavorite: !state.isFavorite));
  }

  void _onToggleDescription(ToggleDescriptionEvent event, Emitter<ProductDetailState> emit) {
    emit(state.copyWith(showFullDescription: !state.showFullDescription));
  }

  void _onInitializeAnimations(InitializeAnimationsEvent event, Emitter<ProductDetailState> emit) {
    emit(state.copyWith(animationsInitialized: true));
  }
}
