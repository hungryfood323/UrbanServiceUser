
import 'package:demo_project/src/models/login_model.dart';
import 'package:demo_project/src/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  final _loginBlocController = PublishSubject<Loginmodel>();

  Stream<Loginmodel> get loginStream => _loginBlocController.stream;

  Future<Loginmodel> loginSink(String username, String password,String token) async {
    return await Repository().loginApiRepository(username, password,token);
  }

  dispose() {
    _loginBlocController.close();
  }
}

final loginBloc = LoginBloc();
