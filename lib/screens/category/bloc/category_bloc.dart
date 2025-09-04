import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:roobai/comman/model/product_model.dart';
import 'package:roobai/screens/category/repo/category_repo.dart';
import 'package:roobai/screens/product/bloc/products_bloc.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository repo;
final log=Logger();
  CategoryBloc(this.repo) : super(CategoryState.initial()) {
    on<Initialvalueevent>(_onInitialvalueevent);
    // on<RefreshProducts>(_onRefreshProductEvent);
  }

  Future<void> _onInitialvalueevent(
      Initialvalueevent event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(status: CategoryStatus.loading));
    try {
      final page=state.page;
      final products = await repo.getCategoryData(id: event.initialvalue,page: page!);
log.d('CategoryBloc::_onInitialvalueevent:products::$products');
      emit(state.copyWith(
        status: CategoryStatus.loaded,
        dealModel: products,
        message: products.isEmpty ? "No products available." : null,
      ));
    } catch (e, stackTrace) {
      Logger().e("CategoryBloc::_onInitialvalueevent::$e", stackTrace: stackTrace);
      emit(state.copyWith(
        status: CategoryStatus.failure,
        message: "Failed to load products. Please try again.",
        dealModel: [],
      ));
    }
  }
}