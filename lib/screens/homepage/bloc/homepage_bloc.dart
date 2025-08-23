import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:roobai/features/data/model/home_model.dart';
import 'package:roobai/screens/homepage/repo/homepage_repo.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  final HomepageRepository homeRepository;

  HomepageBloc( this.homeRepository) : super(const HomepageState()) {
    on<LoadHomepageDataEvent>(_onLoadHomepageData);
    // on<RefreshHomepageDataEvent>(_onRefreshHomepageData);
    on<CategorySelectedEvent>(_onCategorySelected);
    on<ProductSelectedEvent>(_onProductSelected);
  }

  Future<void> _onLoadHomepageData(
      LoadHomepageDataEvent event, Emitter<HomepageState> emit) async {
    emit(state.copyWith(status: HomepageStatus.loading));
    
    try {
      final homeModel = await homeRepository.getProducts();
      Logger().d('HomepageBloc:_onLoadHomepageData::$homeModel');
      emit(state.copyWith(
        status: HomepageStatus.loaded,
        homeModel: homeModel,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HomepageStatus.error,
        errorMessage: 'Failed to load data: ${e.toString()}',
      ));
    }
  }

  // FutureOr<void> _onRefreshHomepageData(
  //     RefreshHomepageDataEvent event, Emitter<HomepageState> emit) async {
  //   try {
  //     final homeModel = await homeRepository.getHomeData();
  //     emit(state.copyWith(
  //       status: HomepageStatus.loaded,
  //       homeModel: homeModel,
  //     ));
  //   } catch (e) {
  //     emit(state.copyWith(
  //       status: HomepageStatus.error,
  //       errorMessage: 'Failed to refresh data: ${e.toString()}',
  //     ));
  //   }
  // }

  FutureOr<void> _onCategorySelected(
      CategorySelectedEvent event, Emitter<HomepageState> emit) {
    emit(state.copyWith(selectedCategory: event.categorySlug));
    // You can add navigation logic here or handle it in the UI
  }

  FutureOr<void> _onProductSelected(
      ProductSelectedEvent event, Emitter<HomepageState> emit) {
    emit(state.copyWith(selectedProduct: event.productId));
    // You can add navigation logic here or handle it in the UI
  }
}