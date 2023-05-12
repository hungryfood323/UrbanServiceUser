import 'package:demo_project/src/models/changeStatus_model.dart';
import 'package:demo_project/src/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class ChangeStatusBloc {
  final _changeStatusBlocController = PublishSubject<ChangeStatusModel>();

  Stream<ChangeStatusModel> get changeStatusStream =>
      _changeStatusBlocController.stream;

  Future<ChangeStatusModel> changeStatusSink(
    String id,
    String status,
  ) async {
    return await Repository().changeStatusApiRepository(id, status);
  }

  dispose() {
    _changeStatusBlocController.close();
  }
}

final changeStatusBloc = ChangeStatusBloc();
