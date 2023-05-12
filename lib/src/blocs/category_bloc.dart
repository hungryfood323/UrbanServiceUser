import 'package:demo_project/src/models/getAllProdCat.dart';
import 'package:demo_project/src/repository/repository.dart';
import 'package:rxdart/rxdart.dart';


class CategoryBloc {
   final _categoryBlocController = PublishSubject<GetAllProdCategory>();

  Stream <GetAllProdCategory> get categoryStream => _categoryBlocController.stream;

  Future categorySink() async {
    GetAllProdCategory categoryModal =
        await Repository().categoryApiRepository();
    _categoryBlocController.sink.add(categoryModal);
    print('ID:${categoryModal.category![0].id}');    
  }

  dispose() {
    _categoryBlocController.close();
  }
}

final categoryBloc = CategoryBloc();


