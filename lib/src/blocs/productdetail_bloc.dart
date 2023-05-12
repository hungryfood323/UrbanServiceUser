import 'package:demo_project/src/models/productDetail_model.dart';
import 'package:demo_project/src/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class ProductDetailBloc {
  final _productDetailBlocController = PublishSubject<ProductDetailModel>();

  Stream<ProductDetailModel> get productDetailStream =>
      _productDetailBlocController.stream;

  Future productDetailSink(String id) async {
    ProductDetailModel productDetailModal =
        await Repository().productDeatilApiRepository(id);
    _productDetailBlocController.sink.add(productDetailModal);
  }

  dispose() {
    _productDetailBlocController.close();
  }
}

final productDetailBloc = ProductDetailBloc();
