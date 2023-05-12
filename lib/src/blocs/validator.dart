import 'dart:async';

class Validator {
  final emailValidate = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern.toString());
      if (regex.hasMatch(email)) {
        sink.add(email);
      } else {
        sink.addError('Enter a valid email');
      }
    },
  );

  final passwordValidate = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 4) {
      sink.add(password);
    } else {
      sink.addError('Password must be 4 charachters long');
    }
  });

  final usernameValidation = StreamTransformer<String, String>.fromHandlers(
      handleData: (username, sink) {
    if (username.isNotEmpty) {
      sink.add(username);
    } else {
      sink.addError('You must have to write your name');
    }
  });
}
