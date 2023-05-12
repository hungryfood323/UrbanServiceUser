import 'dart:convert';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/models/changePass_model.dart';
import 'package:http/http.dart' as http;

class ChangePassApi {
  Future<ChangePassModal> changepassApi(
    String userid,
    String password,
    String npassword,
    String cusername,
  ) async {
    var responseJson;
    var uri = Uri.parse('${baseUrl()}change_password');
    var request = http.MultipartRequest('POST', uri)
      ..fields['user_id'] = userid
      ..fields['password'] = password
      ..fields['npassword'] = npassword
      ..fields['cpassword'] = cusername;

    // var response = await request.send();
    http.Response response =
        await http.Response.fromStream(await request.send());
    responseJson = _returnResponse(response);
    print(response.statusCode);
    return ChangePassModal.fromJson(responseJson);
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
