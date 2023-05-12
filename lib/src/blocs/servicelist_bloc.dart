import 'package:demo_project/src/models/serviceList_model.dart';
import 'package:demo_project/src/repository/repository.dart';
import 'package:rxdart/rxdart.dart';


class ServiceBloc {
   final _serviceBlocController = PublishSubject<ServiceListModel>();

  Stream <ServiceListModel> get serviceListStream => _serviceBlocController.stream;

  Future serviceSink() async {
    ServiceListModel serviceModal =
        await Repository().serviceApiRepository();
    _serviceBlocController.sink.add(serviceModal);
  }

  dispose() {
    _serviceBlocController.close();
  }
}

final serviceBloc = ServiceBloc();
