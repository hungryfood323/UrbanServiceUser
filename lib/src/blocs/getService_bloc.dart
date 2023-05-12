import 'package:demo_project/src/models/getService_model.dart';
import 'package:demo_project/src/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class GetServiceBloc {
  final _getServiceController = PublishSubject<GetServiceModel>();

  Stream<GetServiceModel> get getServiceStream => _getServiceController.stream;

  Future getServiceSink(String id) async {
    GetServiceModel getServiceModel =
        await Repository().getserviceApiRepository(id);
    _getServiceController.sink.add(getServiceModel);
  }

  dispose() {
    _getServiceController.close();
  }
}

final getServiceBloc = GetServiceBloc();
