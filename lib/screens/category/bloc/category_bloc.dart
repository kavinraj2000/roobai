import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:roobai/comman/model/product_model.dart';
import 'package:roobai/screens/category/repo/category_repo.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository repo;
  final log = Logger();

  CategoryBloc(this.repo) : super(CategoryState.initial()) {
    on<Initialvalueevent>(_onInitialvalueevent);
    on<RefreshProductsEvent>(_onRefreshProductsEvent);
    on<LoadMoreProductsEvent>(_onLoadMoreProductsEvent);
  }

  Future<void> _onInitialvalueevent(
    Initialvalueevent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(
      state.copyWith(
        status: CategoryStatus.loading,
        currentCid: event.intialvalue!['cid'],
      ),
    );

    try {
      final products = await repo.getSaleDeals(
        cid: event.intialvalue!['cid'],
        page: 1,
      );

      log.d('CategoryBloc::_onInitialvalueevent:products::$products');

      emit(
        state.copyWith(
          status: CategoryStatus.loaded,
          dealModel: products,
          page: 1,
          hasReachedMax: products.isEmpty || products.length < 20,
          message: products.isEmpty ? "No products available." : null,
        ),
      );
    } catch (e, stackTrace) {
      Logger().e(
        "CategoryBloc::_onInitialvalueevent::$e",
        stackTrace: stackTrace,
      );
      emit(
        state.copyWith(
          status: CategoryStatus.failure,
          message: "Failed to load products. Please try again.",
          dealModel: [],
        ),
      );
    }
  }

  Future<void> _onRefreshProductsEvent(
    RefreshProductsEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(
      state.copyWith(
        status: CategoryStatus.loading,
        currentCid: event.cid['cid'],
      ),
    );

    try {
      final products = await repo.getSaleDeals(cid: event.cid['cid'], page: 1);

      log.d('CategoryBloc::_onRefreshProductsEvent:products::$products');

      emit(
        state.copyWith(
          status: CategoryStatus.loaded,
          dealModel: products,
          page: 1,
          hasReachedMax: products.isEmpty || products.length < 20,
          message: products.isEmpty ? "No products available." : null,
        ),
      );
    } catch (e, stackTrace) {
      Logger().e(
        "CategoryBloc::_onRefreshProductsEvent::$e",
        stackTrace: stackTrace,
      );
      emit(
        state.copyWith(
          status: CategoryStatus.failure,
          message: "Failed to refresh products. Please try again.",
          dealModel: [],
        ),
      );
    }
  }

  Future<void> _onLoadMoreProductsEvent(
    LoadMoreProductsEvent event,
    Emitter<CategoryState> emit,
  ) async {
    if (state.hasReachedMax || state.isFetching || state.currentCid == null)
      return;

    emit(state.copyWith(isFetching: true));

    try {
      final nextPage = state.page! + 1;
      final newProducts = await repo.getSaleDeals(
        cid: state.currentCid!,
        page: nextPage,
      );

      log.d('CategoryBloc::_onLoadMoreProductsEvent:newProducts::$newProducts');

      final updatedProducts = List<ProductModel>.from(state.dealModel ?? [])
        ..addAll(newProducts);

      emit(
        state.copyWith(
          status: CategoryStatus.loaded,
          dealModel: updatedProducts,
          page: nextPage,
          isFetching: false,
          hasReachedMax: newProducts.isEmpty || newProducts.length < 20,
        ),
      );
    } catch (e, stackTrace) {
      Logger().e(
        "CategoryBloc::_onLoadMoreProductsEvent::$e",
        stackTrace: stackTrace,
      );
      emit(
        state.copyWith(
          isFetching: false,
          message: "Failed to load more products.",
        ),
      );
    }
  }
}
