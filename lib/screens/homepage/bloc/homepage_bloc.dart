import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import 'package:roobai/comman/model/home_model.dart';
import 'package:roobai/screens/homepage/repo/homepage_repo.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  final HomepageRepository homeRepository;
  final Logger log = Logger();

  HomepageBloc(this.homeRepository) : super(const HomepageState()) {
    on<LoadHomepageData>(_onLoadHomepageData);
    on<LoadCategories>(_onCategoryLoaded);
  }

  // Helper to check if a section is unwanted (e.g. "Just In")
  bool isUnwantedCategory(HomeModel hm) {
    final title = hm.title?.toLowerCase().trim();
    final slug = hm.cat_slug?.toLowerCase().trim();
    return title == 'just in' || slug == 'just_in';
  }

  Future<void> _onLoadHomepageData(
  LoadHomepageData event,
  Emitter<HomepageState> emit,
) async {
  emit(state.copyWith(status: HomepageStatus.loading));

  try {
    final  homeModels = await homeRepository.getProducts();

    log.d('HomepageBloc::_onLoadHomepageData::fetched $homeModels');

    List<dynamic> categories = [];

    if (homeModels.any((hm) =>
        hm.title?.toLowerCase() == 'categories' ||
        hm.type?.toLowerCase() == 'category')) {
      categories = homeModels
          .where((hm) =>
              (hm.title?.toLowerCase() == 'categories' ||
                  hm.type?.toLowerCase() == 'category') &&
              !isUnwantedCategory(hm))
          .expand((hm) => hm.data ?? [])
          .toList();
    }

    log.d('_onLoadHomepageData:initialFilteredCategories::$categories');

    final seenCategories = <String>{};

    for (final homeModel in homeModels) {
      if (homeModel.data != null && !isUnwantedCategory(homeModel)) {
        for (final data in homeModel.data!) {
          if (data.category != null &&
              data.category!.isNotEmpty &&
              !seenCategories.contains(data.category)) {
            categories.add(data);
            seenCategories.add(data.category!);
          }
        }
      }
    }

    log.d('_onLoadHomepageData:finalCategories::$categories');
    log.d('_onLoadHomepageData:seenCategories::$seenCategories');

    final  livedata = homeModels
        .where((hm) =>
            hm.title?.toLowerCase() == 'live now' ||
            hm.cat_slug?.toLowerCase() == 'big_cat')
        .expand((hm) => hm.data ?? [])
        .toList();

    log.d('_onLoadHomepageData::livedata: $livedata');

    emit(
      state.copyWith(
        status: HomepageStatus.loaded,
        homeModel: homeModels,
        categories: categories,
        livenow: livedata, // ✅ Add this to actually use livedata
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

  FutureOr<void> _onCategoryLoaded(
    LoadCategories event,
    Emitter<HomepageState> emit,
  ) {
    try {
      final categories = event.homeModels
          .where((hm) => hm.type == 'banner' || hm.cat_slug == 'just_in')
          .expand((hm) => hm.data ?? [])
          .toList();

      log.d('_onCategoryLoaded::categories: $categories');

      emit(state.copyWith(status: HomepageStatus.loaded, banners: categories));
    } catch (e) {
      emit(
        state.copyWith(
          status: HomepageStatus.error,
          errorMessage: 'Category loading failed: $e',
        ),
      );
    }
  }

}