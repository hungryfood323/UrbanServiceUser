import 'package:demo_project/src/models/catService_model.dart';
import 'package:demo_project/src/repository/repository.dart';
import 'package:rxdart/rxdart.dart';


class CatServiceBloc {
   final _catServiceController = PublishSubject<CategoryServiceModel>();

  Stream <CategoryServiceModel> get catServiceStream => _catServiceController.stream;

  Future catServiceSink(String id) async {
    CategoryServiceModel categoryServiceModel = await Repository().catServiceRepository(id);
    _catServiceController.sink.add(categoryServiceModel);
  }

  dispose() {
    _catServiceController.close();
  }
}

final catServiceBloc = CatServiceBloc();
