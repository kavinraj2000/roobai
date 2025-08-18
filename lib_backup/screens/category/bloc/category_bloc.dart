import 'package:logger/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roobai/features/product/data/model/category_model.dart';
import 'package:roobai/screens/category/repo/category_repository.dart';


part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent,Categorystate>{

  final CategoryRepository repo;
  CategoryBloc(this.repo) :super(Categorystate.initial()){
    on<LoadingCategoryevent>(_oncategoryloadingevent);
  }

  Future<void>_oncategoryloadingevent(LoadingCategoryevent event,Emitter <Categorystate> emit)async{
    try{
      Logger().d('CategoryBloc::_oncategoryloadingevent::$event');
            emit(state.copyWith(status: CategoryStatus.loading));

      final data=await repo.getCategories();
            Logger().d('_oncategoryloadingevent:data::$data');


    }
    catch(e){
      emit(state.copyWith(status: CategoryStatus.failure,message: 'data not loading'));
    }
  }
}