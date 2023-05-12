import 'package:demo_project/src/models/addtocart_model.dart';
import 'package:demo_project/src/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class AddtocartBloc {
  final _addtocartBlocController = PublishSubject<AddToCartModel>();

  Stream<AddToCartModel> get addtocartStream => _addtocartBlocController.stream;

  Future<AddToCartModel> addtocartSink(
      String quantity, String userID, String productID) async {
    return await Repository().addtocartRepository(quantity, userID, productID);
  }

  dispose() {
    _addtocartBlocController.close();
  }
}

final addtoacartBloc = AddtocartBloc();
