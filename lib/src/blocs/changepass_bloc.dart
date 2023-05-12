
import 'package:demo_project/src/models/changePass_model.dart';
import 'package:demo_project/src/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class ChangePassBloc {
  final _changePassBlocController = PublishSubject<ChangePassModal>();

  Stream <ChangePassModal> get changePassStream => _changePassBlocController.stream;

  Future<ChangePassModal> changePassSink(
    String userid,
    String password,
    String npassword,
    String cusername,
  ) async {
    return await Repository().changePassRepository(userid, password, npassword, cusername);
  }

  dispose() {
    _changePassBlocController.close();
  }
}

final changePassBloc = ChangePassBloc();