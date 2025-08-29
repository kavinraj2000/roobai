import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:roobai/screens/best/repo/best_products_repository.dart';

import 'package:roobai/screens/product/model/products.dart';
import 'package:roobai/screens/product/repo/products_repository.dart';

part 'best_products_event.dart';
part 'best_products_state.dart';

class BestProductBloc extends Bloc<BestProductEvent, BestProductState> {
  final BestproductRepository repo;

  BestProductBloc(this.repo) : super(BestProductState.initial()) {
    on<FetchproductrData>(_onFetchproductrData);
    // on<Addlikestatusevent>(_onLikeStatusChange);
  }

  Future<void> _onFetchproductrData(
    FetchproductrData event,
    Emitter<BestProductState> emit,
  ) async {
    try {
      emit(state.copyWith(status: BestProductStatus.loading));

      Logger().d('BestProductBloc::_onFetchproductrData::${event.runtimeType}');

      final List<Product> data = await repo.getDealData( );

      Logger().d('_onFetchproductrData::data count::$data');



      emit(
        state.copyWith(
          status: BestProductStatus.loaded,
          dealModel: data,
          message: null,
        ),
      );
    } catch (e, stackTrace) {
      Logger().e(
        'BestProductBloc::_onFetchproductrData::error::$e',
        stackTrace: stackTrace,
      );

      emit(
        state.copyWith(
          status: BestProductStatus.failure,
          message: 'Failed to load products. Please try again.',
          dealModel: [],
        ),
      );
    }
  }

// Future<void> _onLikeStatusChange(
//   Addlikestatusevent event,
//   Emitter<BestProductState> emit,
// ) async {
//   try {
//     if (state.dealModel == null || state.dealModel!.isEmpty) {
//       Logger().w('BestProductBloc::_onLikeStatusChange::No products loaded');
//       return;
//     }

//     final currentProducts = List<Product>.from(state.dealModel!);
//     final productIndex = currentProducts.indexWhere(
//       (p) => p.pid == event.product.pid,
//     );

//     if (productIndex == -1) {
//       Logger().w('BestProductBloc::_onLikeStatusChange::Product not found');
//       return;
//     }

//     // Toggle like status
//     final updatedProduct = event.product.copyWith(
//       likeStatus: event.product.likeStatus == "1" ? "0" : "1",
//     );

//     // Optimistic update
//     currentProducts[productIndex] = updatedProduct;

//     emit(
//       state.copyWith(
//         status: BestProductStatus.loaded,
//         dealModel: currentProducts,
//       ),
//     );

//     Logger().d(
//       'BestProductBloc::_onLikeStatusChange::Updated product ${updatedProduct.pid} '
//       'like status to ${updatedProduct.likeStatus}',
//     );

//     await repo.addlikestatus(
//       productId: updatedProduct.pid!,
//       likeStatus: updatedProduct.likeStatus!,
//     );

//   } catch (e, stackTrace) {
//     Logger().e(
//       'BestProductBloc::_onLikeStatusChange::Unexpected error::$e',
//       stackTrace: stackTrace,
//     );

//     emit(
//       state.copyWith(
//         status: BestProductStatus.failure,
//         message: 'Error updating favorite status',
//       ),
//     );
//   }



      // Uncomment when backend API is ready
      /*
      try {
        // Call API to persist the like status
        await repo.updateLikeStatus(
          productId: updatedProduct.pid,
          likeStatus: updatedProduct.likeStatus,
        );
        
        Logger().d('BestProductBloc::_onLikeStatusChange::Successfully synced to backend');
        
      } catch (apiError) {
        Logger().e('BestProductBloc::_onLikeStatusChange::API sync failed::$apiError');
        
        // Revert the optimistic update on API failure
        final revertedProducts = List<Product>.from(state.dealModel!);
        revertedProducts[productIndex] = event.product; // Original product
        
        emit(state.copyWith(
          status: BestProductStatus.loaded,
          dealModel: revertedProducts,
          message: 'Failed to sync favorite status',
        ));
      }
      */
  //   } catch (e, stackTrace) {
  //     Logger().e(
  //       'BestProductBloc::_onLikeStatusChange::Unexpected error::$e',
  //       stackTrace: stackTrace,
  //     );

  //     // On unexpected error, try to revert to original state
  //     emit(
  //       state.copyWith(
  //         status: BestProductStatus.failure,
  //         message: 'Error updating favorite status',
  //       ),
  //     );
  //   }
  // }

  // // Helper method to refresh data
  // void refreshData() {
  //   add(FetchproductrData());
  // }

  // // Helper method to toggle like status
  // void toggleLikeStatus(Product product) {
  //   add(Addlikestatusevent(product));
  // }

}