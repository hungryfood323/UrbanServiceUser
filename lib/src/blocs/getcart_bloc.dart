import 'package:demo_project/src/models/getCartItem.dart';

import 'package:demo_project/src/repository/repository.dart';
import 'package:rxdart/rxdart.dart';


class GetCartBloc {
   final _getCartController = PublishSubject<GetCartModel>();

  Stream <GetCartModel> get getCartStream => _getCartController.stream;

  Future getCartSink(String id) async {
    GetCartModel getCartModal = await Repository().getCartApiRepository(id);
    _getCartController.sink.add(getCartModal);
  }

  dispose() {
    _getCartController.close();
  }
}

final getCartBloc = GetCartBloc();