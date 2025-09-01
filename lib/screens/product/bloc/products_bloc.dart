import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:roobai/screens/product/model/products.dart';
import 'package:roobai/screens/product/repo/products_repository.dart';
part 'products_event.dart';
part 'products_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final DealRepository repo;
final log=Logger();
  ProductBloc(this.repo) : super(ProductState.initial()) {
    on<FetchDealFinderData>(_onFetchDealFinderData);
    on<RefreshProducts>(_onRefreshProductEvent);
  }

  Future<void> _onFetchDealFinderData(
      FetchDealFinderData event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: DealfinderStatus.loading));
    try {
      final products = await repo.getDealData();
log.d('ProductBloc::_onFetchDealFinderData:products::$products');
      emit(state.copyWith(
        status: DealfinderStatus.loaded,
        dealModel: products,
        message: products.isEmpty ? "No products available." : null,
      ));
    } catch (e, stackTrace) {
      Logger().e("ProductBloc::_onFetchDealFinderData::$e", stackTrace: stackTrace);
      emit(state.copyWith(
        status: DealfinderStatus.failure,
        message: "Failed to load products. Please try again.",
        dealModel: [],
      ));
    }
  }

  Future<void> _onRefreshProductEvent(
      RefreshProducts event, Emitter<ProductState> emit) async {
    add(FetchDealFinderData());
  }
}
