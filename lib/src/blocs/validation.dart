import 'package:demo_project/src/blocs/validator.dart';
import 'package:rxdart/rxdart.dart';

class ValidationBloc extends Object with Validator {
  final _email = PublishSubject<String>();
  final _password = PublishSubject<String>();
  final _username = PublishSubject<String>();

  Stream <String> get email => _email.stream.transform(emailValidate);
  Stream <String> get password =>_password.stream.transform(passwordValidate);
  Stream <String> get username => _username.stream.transform(usernameValidation);

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changeUsername => _username.sink.add;

  dispose() {
    _email.close();
    _password.close();
    _username.close();
  }
}

final validationBloc = ValidationBloc();
