import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import 'package:roobai/features/product/data/model/deal_model.dart';
import 'package:http/http.dart' as http;
import 'package:roobai/screens/product/model/products.dart';
import 'dart:convert';

import 'package:roobai/screens/product/repo/products_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final DealRepository repo;
  ProductBloc(this.repo) : super(ProductState.initial()) {
    on<FetchDealFinderData>(_onFetchDealFinderData);
  }

  Future<void> _onFetchDealFinderData(FetchDealFinderData event,
    Emitter<ProductState> emit,
  ) async {
    try {
    emit(state.copyWith(status: DealfinderStatus.loading));
      
      Logger().d('ProductBloc::_onFetchDealFinderData::$event');
      final List<Product> data=await repo.getDealData();
      Logger().d('_onFetchDealFinderData::data::$data');
          emit(state.copyWith(status: DealfinderStatus.loaded,dealModel: data));

    } catch (e) {
    emit(state.copyWith(status: DealfinderStatus.failure,message: 'ProductBloc::_onFetchDealFinderData:::error'));
    }
  }
}
