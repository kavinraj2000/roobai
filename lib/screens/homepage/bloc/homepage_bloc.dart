import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:roobai/comman/model/bannar_model.dart';
import 'package:roobai/comman/model/category_model.dart';
import 'package:roobai/comman/model/home_model.dart';
import 'package:roobai/comman/model/product_model.dart';
import 'package:roobai/screens/homepage/repo/homepage_repo.dart';
import 'package:url_launcher/url_launcher.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  final HomepageRepository homeRepository;
  final Logger log = Logger();

  HomepageBloc(this.homeRepository) : super(HomepageState.initial()) {
    on<LoadHomepageData>(_onLoadHomepageData);
    on<LoadCategories>(_onCategoryLoaded);
    on<NavigateToProductEvent>(_onNavigateToProduct);
  }

  Future<void> _onLoadHomepageData(
    LoadHomepageData event,
    Emitter<HomepageState> emit,
  ) async {
    log.i('HomepageBloc::_onLoadHomepageData:event::$event');
    try {
      emit(state.copyWith(status: HomepageStatus.loading));
      final bannerlist = await homeRepository.getBanners();

      log.d('HomepageBloc::_onLoadHomepageData::fetched $bannerlist');
      final justscroll = await homeRepository.getJustScrollProducts();
      log.d('HomepageBloc::getJustScrollProducts::fetched $justscroll');
      final category = await homeRepository.getcategories();
      log.d('HomepageBloc::getcategories::fetched $category');
      
      emit(
        state.copyWith(
          status: HomepageStatus.loaded,
          banner: bannerlist,
          justscroll: justscroll,
        category: category  
          // categories: categories,
          // livenow: livedata, // ✅ Add this to actually use livedata
        ),
      );
    } catch (e) {
      log.e("HomepageBloc::_onLoadHomepageData::error: $e");
      emit(
        state.copyWith(
          status: HomepageStatus.error,
          errorMessage: 'Failed to load data: $e',
        ),
      );
    }
  }

  FutureOr<void> _onCategoryLoaded(
    LoadCategories event,
    Emitter<HomepageState> emit,
  ) {
    try {
      final categories = event.homeModels
          .where((hm) => hm.type == 'banner' || hm.cat_slug == 'just_in')
          .expand((hm) => hm.data ?? [])
          .toList();

      log.d('_onCategoryLoaded::categories: $categories');

      // emit(state.copyWith(status: HomepageStatus.loaded, : categories));
    } catch (e) {
      emit(
        state.copyWith(
          status: HomepageStatus.error,
          errorMessage: 'Category loading failed: $e',
        ),
      );
    }
  }

  Future<void> _onNavigateToProduct(
    NavigateToProductEvent event,
    Emitter<HomepageState> emit,
  ) async {
    try {
      emit(state.copyWith(status: HomepageStatus.loading));

      final productUrl = event.productUrl;

      if (productUrl == null || productUrl.isEmpty) {
        emit(state.copyWith(status: HomepageStatus.error));
        return;
      }

      final url = productUrl.startsWith("http")
          ? productUrl
          : "https://$productUrl";
      final uri = Uri.parse(url);

      HapticFeedback.mediumImpact();

      final launched = await launchUrl(uri, mode: LaunchMode.inAppWebView);

      if (!launched) {
        emit(state.copyWith(status: HomepageStatus.loading));
      } else {
        emit(state.copyWith(status: HomepageStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(status: HomepageStatus.error, errorMessage: '$e'));
    }
  }
}
