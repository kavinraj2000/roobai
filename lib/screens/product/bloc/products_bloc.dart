import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import 'package:roobai/screens/product/model/products.dart';
import 'package:roobai/screens/product/repo/products_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final DealRepository repo;

  ProductBloc(this.repo) : super(ProductState.initial()) {
    on<FetchDealFinderData>(_onFetchDealFinderData);
    on<Addlikestatusevent>(_onLikeStatusChange);
  }

  Future<void> _onFetchDealFinderData(
    FetchDealFinderData event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(state.copyWith(status: DealfinderStatus.loading));

      Logger().d('ProductBloc::_onFetchDealFinderData::${event.runtimeType}');

      final List<Product> data = await repo.getDealData();

      Logger().d('_onFetchDealFinderData::data count::$data');

      emit(
        state.copyWith(
          status: DealfinderStatus.loaded,
          dealModel: data,
          message: null,
        ),
      );
    } catch (e, stackTrace) {
      Logger().e(
        'ProductBloc::_onFetchDealFinderData::error::$e',
        stackTrace: stackTrace,
      );

      emit(
        state.copyWith(
          status: DealfinderStatus.failure,
          message: 'Failed to load products. Please try again.',
          dealModel: [],
        ),
      );
    }
  }

  Future<void> _onLikeStatusChange(
    Addlikestatusevent event,
    Emitter<ProductState> emit,
  ) async {
    try {
      if (state.dealModel == null || state.dealModel!.isEmpty) {
        Logger().w('ProductBloc::_onLikeStatusChange::No products loaded');
        return;
      }

      // Optimistic update - update UI immediately
      final currentProducts = List<Product>.from(state.dealModel!);
      final productIndex = currentProducts.indexWhere(
        (p) => p.pid == event.product.pid,
      );

      if (productIndex == -1) {
        Logger().w('ProductBloc::_onLikeStatusChange::Product not found');
        return;
      }

      // Toggle like status
      final updatedProduct = event.product.copyWith(
        likeStatus: event.product.likeStatus == "1" ? "0" : "1",
      );

      // Update the product in the list
      currentProducts[productIndex] = updatedProduct;

      // Emit optimistic update
      emit(
        state.copyWith(
          status: DealfinderStatus.loaded,
          dealModel: currentProducts,
        ),
      );

      Logger().d(
        'ProductBloc::_onLikeStatusChange::Updated product ${updatedProduct.pid} '
        'like status to ${updatedProduct.likeStatus}',
      );

      // Uncomment when backend API is ready
      /*
      try {
        // Call API to persist the like status
        await repo.updateLikeStatus(
          productId: updatedProduct.pid,
          likeStatus: updatedProduct.likeStatus,
        );
        
        Logger().d('ProductBloc::_onLikeStatusChange::Successfully synced to backend');
        
      } catch (apiError) {
        Logger().e('ProductBloc::_onLikeStatusChange::API sync failed::$apiError');
        
        // Revert the optimistic update on API failure
        final revertedProducts = List<Product>.from(state.dealModel!);
        revertedProducts[productIndex] = event.product; // Original product
        
        emit(state.copyWith(
          status: DealfinderStatus.loaded,
          dealModel: revertedProducts,
          message: 'Failed to sync favorite status',
        ));
      }
      */
    } catch (e, stackTrace) {
      Logger().e(
        'ProductBloc::_onLikeStatusChange::Unexpected error::$e',
        stackTrace: stackTrace,
      );

      // On unexpected error, try to revert to original state
      emit(
        state.copyWith(
          status: DealfinderStatus.failure,
          message: 'Error updating favorite status',
        ),
      );
    }
  }

  // Helper method to refresh data
  void refreshData() {
    add(FetchDealFinderData());
  }

  // Helper method to toggle like status
  void toggleLikeStatus(Product product) {
    add(Addlikestatusevent(product));
  }
}
