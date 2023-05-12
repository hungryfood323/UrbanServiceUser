import 'dart:convert';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/models/changeStatus_model.dart';
import 'package:http/http.dart' as http;

class ChangeStatusApi {
  Future<ChangeStatusModel> changeStatusApi(String id, String status) async {
    var responseJson;
    await http.post(Uri.parse('${baseUrl()}booking_cancel_by_user'),
        body: {'id': id, 'status': status}).then((response) {
      responseJson = _returnResponse(response);
    }).catchError((onError) {
      print(onError);
    });
    return ChangeStatusModel.fromJson(responseJson);
  }

  dynamic _returnResponse(http.Response response) {
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);

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
