import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:roobai/comman/model/home_model.dart';
import 'package:roobai/screens/homepage/repo/homepage_repo.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  final HomepageRepository homeRepository;
  final Logger log = Logger();

  HomepageBloc(this.homeRepository) : super(const HomepageState()) {
    on<LoadHomepageData>(_onLoadHomepageData);
    // on<CategorySelectedEvent>(_onCategorySelected);
    // on<ProductSelectedEvent>(_onProductSelected);
  }

  Future<void> _onLoadHomepageData(
    LoadHomepageData event,
    Emitter<HomepageState> emit,
  ) async {
    emit(state.copyWith(status: HomepageStatus.loading));

    try {
      final products = await homeRepository.getProducts();
      log.d(
        'HomepageBloc::_onLoadHomepageData::fetched ${products.length} products',
      );
      emit(state.copyWith(status: HomepageStatus.loaded, homeModel: products));
    } catch (e) {
      log.e(
        "HomepageBloc::_onLoadHomepageData::error$e",
        
      );
      emit(
        state.copyWith(
          status: HomepageStatus.error,
          errorMessage: 'Failed to load data: $e',
        ),
      );
    }
  }

  // FutureOr<void> _onCategorySelected(
  //   CategorySelectedEvent event,
  //   Emitter<HomepageState> emit,
  // ) {
  //   emit(state.copyWith(selectedCategory: event.categorySlug));
  // }

  // FutureOr<void> _onProductSelected(
  //   ProductSelectedEvent event,
  //   Emitter<HomepageState> emit,
  // ) {
  //   emit(state.copyWith(selectedProduct: event.productId));
  // }
}
