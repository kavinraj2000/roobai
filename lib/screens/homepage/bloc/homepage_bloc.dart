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
    on<LoadMoreJustScroll>(_onLoadMoreJustScroll);
    on<SetCurrentViewProducts>(_onSetCurrentViewProducts);
    on<NavigateToMobileProducts>(_onNavigateToMobileProducts);
    on<NavigateToJustScrollProducts>(_onNavigateToJustScrollProducts);
  }

  Future<void> _onLoadHomepageData(
    LoadHomepageData event,
    Emitter<HomepageState> emit,
  ) async {
    log.i('HomepageBloc::_onLoadHomepageData:event::$event');
    try {
      emit(state.copyWith(status: HomepageStatus.loading));
   final banner =
          await homeRepository.getBanners();
      log.d('HomepageBloc::getJustScrollProducts::fetched $banner');
      final justscroll =
          await homeRepository.getJustScrollProducts(page: state.page + 1);
      log.d('HomepageBloc:justscroll:fetched $justscroll');

      final category = await homeRepository.getcategories();
      log.d('HomepageBloc::getcategories::fetched $category');

      final hourdeal = await homeRepository.gethorsdeal();
      log.d('HomepageBloc::gethorsdeal::hourdeal $hourdeal');

      final mobilelist = await homeRepository.getMobilecategory();
      log.d('HomepageBloc::getMobilecategory::mobilelist $mobilelist');

      emit(
        state.copyWith(
          status: HomepageStatus.loaded,
          justscroll: justscroll,
          page: 1,
          hasReachedMax: false,
          category: category,
          hourdeals: hourdeal,
          mobileList: mobilelist,
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

  void _onCategoryLoaded(
    LoadCategories event,
    Emitter<HomepageState> emit,
  ) {
    try {
      final categories = event.homeModels
          .where((hm) => hm.type == 'banner' || hm.cat_slug == 'just_in')
          .expand((hm) => hm.data ?? [])
          .toList();

      log.d('_onCategoryLoaded::categories: $categories');
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
      final productUrl = event.productUrl;

      if (productUrl == null || productUrl.isEmpty) {
        emit(state.copyWith(
          status: HomepageStatus.error,
          errorMessage: "Invalid product URL",
        ));
        return;
      }

      final url = productUrl.startsWith("http")
          ? productUrl
          : "https://$productUrl";
      final uri = Uri.parse(url);
      log.i('_onNavigateToProduct:uri:::::$uri');

      HapticFeedback.mediumImpact();

      final launched = await launchUrl(uri, mode: LaunchMode.inAppWebView);

      if (!launched) {
        emit(state.copyWith(
          status: HomepageStatus.error,
          errorMessage: "Could not open the URL",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: HomepageStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadMoreJustScroll(
    LoadMoreJustScroll event,
    Emitter<HomepageState> emit,
  ) async {
    if (state.hasReachedMax) return;

    emit(state.copyWith(status: HomepageStatus.loading));

    try {
      final nextPage = state.page + 1;
      final products = await homeRepository.getJustScrollProducts(page: nextPage);

      final allProducts = List<ProductModel>.from(state.justscroll!)
        ..addAll(products);

      emit(
        state.copyWith(
          status: HomepageStatus.loaded,
          justscroll: allProducts,
          page: nextPage,
          hasReachedMax: products.isEmpty || products.length < 20,
        ),
      );
    } catch (e, stackTrace) {
      log.e("HomepageBloc::_onLoadMoreJustScroll::$e", stackTrace: stackTrace);
      emit(
        state.copyWith(
          status: HomepageStatus.error,
          errorMessage: "Failed to load more products",
        ),
      );
    }
  }

  void _onSetCurrentViewProducts(
    SetCurrentViewProducts event,
    Emitter<HomepageState> emit,
  ) {
    emit(state.copyWith(currentViewProducts: event.products));
    log.d(
      'HomepageBloc::_onSetCurrentViewProducts::${event.products.length} products set',
    );
  }

  void _onNavigateToMobileProducts(
    NavigateToMobileProducts event,
    Emitter<HomepageState> emit,
  ) {
    final mobileProducts = state.mobileList ?? [];
    emit(state.copyWith(currentViewProducts: mobileProducts));
    log.d(
      'HomepageBloc::_onNavigateToMobileProducts::${mobileProducts.length} mobile products set',
    );
  }

  void _onNavigateToJustScrollProducts(
    NavigateToJustScrollProducts event,
    Emitter<HomepageState> emit,
  ) {
    final justScrollProducts = state.justscroll ?? [];
    emit(state.copyWith(currentViewProducts: justScrollProducts));
    log.d(
      'HomepageBloc::_onNavigateToJustScrollProducts::${justScrollProducts.length} just scroll products set',
    );
  }
}
