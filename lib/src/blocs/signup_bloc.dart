import 'package:demo_project/src/models/signup_model.dart';
import 'package:demo_project/src/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class SignupBloc {
  final _signupBlocController = PublishSubject<SignupModel>();

  Stream <SignupModel> get signupStream => _signupBlocController.stream;

  Future<SignupModel> signupSink(
    String email,
    String password,
    String username,
  ) async {
    return await Repository().signupRepository(
      email,
      password,
      username,
    );
  }

  dispose() {
    _signupBlocController.close();
  }
}

final signupBloc = SignupBloc();
