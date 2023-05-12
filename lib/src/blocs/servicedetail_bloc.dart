import 'package:demo_project/src/models/serviceDetail_model.dart';
import 'package:demo_project/src/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class ServiceDetailBloc {
  final _serviceDetailController = PublishSubject<ServiceDetailModel>();

  Stream<ServiceDetailModel> get serviceDetailStream =>
      _serviceDetailController.stream;

  Future serviceDetailSink(String id) async {
    ServiceDetailModel serviceDetailModal =
        await Repository().serviceDetailsApiRepository(id);
    _serviceDetailController.sink.add(serviceDetailModal);
  }

  dispose() {
    _serviceDetailController.close();
  }
}

final serviceDetailBloc = ServiceDetailBloc();
