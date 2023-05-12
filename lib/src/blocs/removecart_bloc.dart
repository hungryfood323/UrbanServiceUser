
import 'package:demo_project/src/models/removecart_model.dart';
import 'package:demo_project/src/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class RemovecartBloc {
  final _removecartBlocController = PublishSubject<RemoveCartModel>();

  Stream<RemoveCartModel> get removecartStream => _removecartBlocController.stream;

  Future<RemoveCartModel>removecartSink(
      String cartid) async {
    return await Repository().removeCartApiRepository(cartid);
  }

  dispose() {
    _removecartBlocController.close();
  }
}

final removecartBloc = RemovecartBloc();
