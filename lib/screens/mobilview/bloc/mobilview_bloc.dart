import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:roobai/comman/model/product_model.dart';
import 'package:roobai/screens/homepage/repo/homepage_repo.dart';
import 'package:url_launcher/url_launcher.dart';

part 'mobileview_event.dart';
part 'mobileview_state.dart';

class MobilviewBloc extends Bloc<MobileviewEvent,Mobilviewstate>{
  final HomepageRepository repo;
  final log=Logger();
  MobilviewBloc(this.repo) : super(Mobilviewstate.initial()){
    on<Loadingmobilevent>(_onLoadingmobileEvent);
    on<Navigatetomobileurl>(_onNavigatetomobileurl);
    on<Refreshmobiles>(_onRefreshmobiles);

  }

  Future<void> _onLoadingmobileEvent(
    Loadingmobilevent event,
    Emitter<Mobilviewstate> emit,
  ) async {
    if (state.hasReachedMax || state.status == Mobilviewstatus.loading) {
      return;
    }

    try {
      if (state.mobilelist.isEmpty) {
        emit(state.copyWith(status: Mobilviewstatus.loading));
      }

      final nextPage = state.page + 1;
     
      final List<ProductModel> newMobileProducts =
          await repo.getMobilecategory(page: nextPage);

      log.d(
        'ProductViewBloc::_onLoadProductView::fetched $newMobileProducts',
      );

      emit(
        state.copyWith(
          status: Mobilviewstatus.loaded,
          page: nextPage,
        
          mobilelist: [
            ...(state.mobilelist ?? []),
            ...newMobileProducts,
          ],
          hasReachedMax: newMobileProducts.isEmpty || newMobileProducts.length < 20,
        ),
      );
    } catch (e, stackTrace) {
      log.e(
        "ProductViewBloc::_onLoadProductView::error: $e",
        stackTrace: stackTrace,
      );
      emit(
        state.copyWith(
          status: Mobilviewstatus.error,
          errorMessage: 'Failed to load data: $e',
        ),
      );
    }
  }

    Future<void> _onRefreshmobiles(
    Refreshmobiles event,
    Emitter<Mobilviewstate> emit,
  ) async {
    emit(state.copyWith(status: Mobilviewstatus.loading));

    try {
   
      final List<ProductModel> mobileProducts =
          await repo.getMobilecategory(page: 1);

      log.d(
        'ProductViewBloc::_onRefreshProducts::fetched ${mobileProducts.length} products',
      );

      emit(
        state.copyWith(
          status: Mobilviewstatus.loaded,
          mobilelist: mobileProducts,
          page: 1,
          hasReachedMax: mobileProducts.isEmpty || mobileProducts.length < 20,
        )
      );
    } catch (e, stackTrace) {
      log.e(
        "ProductViewBloc::_onRefreshProducts::error: $e",
        stackTrace: stackTrace,
      );
      emit(
        state.copyWith(
          status: Mobilviewstatus.error,
          errorMessage: "Failed to refresh products. Please try again.",
   
        ),
      );
    }
  }

  Future<void> _onNavigatetomobileurl(
    Navigatetomobileurl event,
    Emitter<Mobilviewstate> emit,
  ) async {
    try {
      final productUrl = event.producturl;

      if (productUrl == null || productUrl.isEmpty) {
        emit(
          state.copyWith(
            status: Mobilviewstatus.error,
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
            status: Mobilviewstatus.error,
            errorMessage: "Could not open the URL",
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: Mobilviewstatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

}