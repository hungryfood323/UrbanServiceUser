import 'dart:convert';
import 'package:demo_project/src/blocs/handleResponse.dart';
import 'package:demo_project/src/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:demo_project/src/global/global.dart';

class LoginApi {
  Future<Loginmodel> loginApi(
      String username, String password, String token) async {
    var responseJson;
    await http.post(Uri.parse('${baseUrl()}login'), body: {
      'email': username,
      'password': password,
      'device_token': token
    }).then((response) {
      print(response.body);
      responseJson = _returnResponse(response);
    }).catchError((onError) {
      print(onError);
    });
    return Loginmodel.fromJson(responseJson);
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        handleResponse.handleResponseSink(true);
        return responseJson;
      case 400:
        handleResponse.handleResponseSink(false);
        throw Exception(response.body.toString());
      case 401:
        handleResponse.handleResponseSink(false);
        throw Exception(response.body.toString());
      case 403:
        handleResponse.handleResponseSink(false);
        throw Exception(response.body.toString());
      case 500:
      default:
        handleResponse.handleResponseSink(false);
        throw Exception(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
