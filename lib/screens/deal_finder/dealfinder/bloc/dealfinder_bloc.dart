import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import 'package:roobai/features/product/data/model/deal_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:roobai/screens/deal_finder/dealfinder/repo/dealfinder_repository.dart';

part 'dealfinder_event.dart';
part 'dealfinder_state.dart';

class DealFinderBloc extends Bloc<DealFinderEvent, DealfinderState> {
  final DealRepository repo;
  DealFinderBloc(this.repo) : super(DealfinderState.initial()) {
    on<FetchDealFinderData>(_onFetchDealFinderData);
  }

  Future<void> _onFetchDealFinderData(FetchDealFinderData event,
    Emitter<DealfinderState> emit,
  ) async {
    try {
    emit(state.copyWith(status: DealfinderStatus.loading));
      // final response = await http.get(
      //   Uri.parse("https://roo.bi/api/flutter/v12.0/deal-finder/${event.dealType}/"),
      //   headers: {
      //     "Content-Type": "application/json",
      //   },
      // );

      // if (response.statusCode == 200) {
      //   final jsonData = json.decode(response.body);
      //   final model = DealModel.fromJson(jsonData);
      //   emit(DealFinderLoaded(model));
      // } else {
      //   emit(DealFinderError("Failed to load data"));
      // }
      Logger().d('DealFinderBloc::_onFetchDealFinderData::$event');
      final data=await repo.getDealData(dealType: event.dealType);
      Logger().d('_onFetchDealFinderData::data::$data');
          emit(state.copyWith(status: DealfinderStatus.loaded,dealModel: data));

    } catch (e) {
    emit(state.copyWith(status: DealfinderStatus.failure,message: 'DealFinderBloc::_onFetchDealFinderData:::error'));
    }
  }
}
