import 'package:demo_project/src/models/getProdByCat_model.dart';
import 'package:demo_project/src/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class StoreBloc {
  final _storeBlocController = PublishSubject<GetProdByCatID>();

  Stream<GetProdByCatID> get storeStream => _storeBlocController.stream;

  Future storeSink(String id) async {
    GetProdByCatID storeModal = await Repository().storeApiRepository(id);
    _storeBlocController.sink.add(storeModal);
  }

  dispose() {
    _storeBlocController.close();
  }
}

final storeBloc = StoreBloc();
