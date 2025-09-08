import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:roobai/comman/model/product_model.dart';
import 'package:roobai/screens/homepage/repo/homepage_repo.dart';
import 'package:url_launcher/url_launcher.dart';

part 'product_view_event.dart';
part 'product_view_state.dart';

class ProductViewBloc extends Bloc<ProductviewEvent, ProductviewState> {
  final HomepageRepository repo;
  final log = Logger();

  ProductViewBloc(this.repo) : super(ProductviewState.initial()) {
    on<LoadProductViewData>(_onLoadProductView);
    on<RefreshProducts>(_onRefreshProducts);
    on<NavigatetoProducturl>(_onNavigateToProduct);
  }

  Future<void> _onLoadProductView(
    LoadProductViewData event,
    Emitter<ProductviewState> emit,
  ) async {
    if (state.hasReachedMax || state.status == ProductViewStatus.loading) {
      return;
    }

    try {
      if (state.justscroll.isEmpty) {
        emit(state.copyWith(status: ProductViewStatus.loading));
      }

      final nextPage = state.page + 1;
      final List<ProductModel> newProducts =
          await repo.getJustScrollProducts(page: nextPage);
      final List<ProductModel> newMobileProducts =
          await repo.getMobilecategory(page: nextPage);

      log.d(
        'ProductViewBloc::_onLoadProductView::fetched ${newProducts.length} products for page $nextPage',
      );

      emit(
        state.copyWith(
          status: ProductViewStatus.loaded,
          page: nextPage,
          justscroll: [
            ...state.justscroll,
            ...newProducts,
          ],
          mobileList: [
            ...(state.mobileList ?? []),
            ...newMobileProducts,
          ],
          hasReachedMax: newProducts.isEmpty || newProducts.length < 20,
        ),
      );
    } catch (e, stackTrace) {
      log.e(
        "ProductViewBloc::_onLoadProductView::error: $e",
        stackTrace: stackTrace,
      );
      emit(
        state.copyWith(
          status: ProductViewStatus.error,
          errorMessage: 'Failed to load data: $e',
        ),
      );
    }
  }

  Future<void> _onRefreshProducts(
    RefreshProducts event,
    Emitter<ProductviewState> emit,
  ) async {
    emit(state.copyWith(status: ProductViewStatus.loading));

    try {
      final List<ProductModel> products =
          await repo.getJustScrollProducts(page: 1);
      final List<ProductModel> mobileProducts =
          await repo.getMobilecategory(page: 1);

      log.d(
        'ProductViewBloc::_onRefreshProducts::fetched ${products.length} products',
      );

      emit(
        state.copyWith(
          status: ProductViewStatus.loaded,
          justscroll: products,
          mobileList: mobileProducts,
          page: 1,
          hasReachedMax: products.isEmpty || products.length < 20,
          // Reset filter when refreshing
          selectedCategoryId: null,
          filteredProducts: [],
        ),
      );
    } catch (e, stackTrace) {
      log.e(
        "ProductViewBloc::_onRefreshProducts::error: $e",
        stackTrace: stackTrace,
      );
      emit(
        state.copyWith(
          status: ProductViewStatus.error,
          errorMessage: "Failed to refresh products. Please try again.",
          justscroll: [],
          mobileList: [],
        ),
      );
    }
  }

  Future<void> _onNavigateToProduct(
    NavigatetoProducturl event,
    Emitter<ProductviewState> emit,
  ) async {
    try {
      final productUrl = event.productUrl;

      if (productUrl == null || productUrl.isEmpty) {
        emit(
          state.copyWith(
            status: ProductViewStatus.error,
            errorMessage: "Invalid product URL",
          ),
        );
        return;
      }

      final url = productUrl.startsWith("http")
          ? productUrl
          : "https://$productUrl";
      final uri = Uri.parse(url);
      log.i('ProductViewBloc::_onNavigateToProduct: uri=$uri');

      HapticFeedback.mediumImpact();

      final launched = await launchUrl(uri, mode: LaunchMode.inAppWebView);

      if (!launched) {
        emit(
          state.copyWith(
            status: ProductViewStatus.error,
            errorMessage: "Could not open the URL",
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: ProductViewStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  
}