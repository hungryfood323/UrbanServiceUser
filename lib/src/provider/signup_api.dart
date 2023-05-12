import 'dart:convert';
import 'package:demo_project/src/models/signup_model.dart';
import 'package:http/http.dart' as http;
import 'package:demo_project/src/global/global.dart';

class SignupApi {
  Future<SignupModel> signupApi(
    String email,
    String password,
    String username,
  ) async {
    var responseJson;
    var uri = Uri.parse('${baseUrl()}register');
    var request = http.MultipartRequest('POST', uri)
      ..fields['email'] = email
      ..fields['password'] = password
      ..fields['username'] = username;

    // var response = await request.send();
    http.Response response =
        await http.Response.fromStream(await request.send());
    responseJson = _returnResponse(response);
    print(response.statusCode);
    return SignupModel.fromJson(responseJson);
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());

        return responseJson;
      case 400:
        throw Exception(response.body.toString());
      case 401:
        throw Exception(response.body.toString());
      case 403:
        throw Exception(response.body.toString());
      case 500:
      default:
        throw Exception(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
