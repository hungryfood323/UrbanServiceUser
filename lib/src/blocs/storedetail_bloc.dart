import 'package:demo_project/src/models/store_model.dart';
import 'package:demo_project/src/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class StoreDetailBloc {
  final _storeDetailBlocController = PublishSubject<StoreModel>();

  Stream<StoreModel> get storeDetailStream => _storeDetailBlocController.stream;

  Future storeDetailSink(String id) async {
    StoreModel storeDetailModal = await Repository().storeDetailRepository(id);
    _storeDetailBlocController.sink.add(storeDetailModal);
  }

  dispose() {
    _storeDetailBlocController.close();
  }
}

final storeDetailBloc = StoreDetailBloc();
