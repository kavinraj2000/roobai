import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:roobai/comman/drawer/repo/drawer_repo.dart';
import 'package:roobai/comman/model/category_model.dart';

part 'drawer_event.dart';
part 'drawer_state.dart';

class DraweBloc extends Bloc<Drawerevent, DrawerState> {
  final DrawerRepository repo;
  final log = Logger();
  DraweBloc(this.repo) : super(DrawerState.initial()) {
    on<Loadincategoryevent>(_onLoadingcategoryevent);
    on<SelectCategory>(_onSelectCategory);
  }
  Future<void> _onLoadingcategoryevent(
    Loadincategoryevent event,
    Emitter<DrawerState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Drawerstatus.loading));
      log.d('DraweBloc:_onLoadingcategoryevent::$event');
      final category = await repo.getcategory();
      log.d('_onLoadingcategoryevent:getcategory:category::$category');
      emit(state.copyWith(status: Drawerstatus.loaded, category: category));
    } catch (e) {
      emit(
        state.copyWith(
          status: Drawerstatus.failure,
          message: 'category not loading::$e',
        ),
      );
    }
  }

  Future<void> _onSelectCategory(SelectCategory event, Emitter<DrawerState> emit) async{
  // Set loading first
  emit(state.copyWith(status: Drawerstatus.loading));

  // Only update selectedCategory if current status is loaded
  if (state.status == Drawerstatus.loaded) {
    emit(state.copyWith(selectedCategory: event.category));
  }
}

  }

