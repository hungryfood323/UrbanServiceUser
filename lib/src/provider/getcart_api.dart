import 'dart:convert';
import 'package:demo_project/src/models/getCartItem.dart';
import 'package:http/http.dart' as http;
import 'package:demo_project/src/global/global.dart';

class GetCartApi {
  Future<GetCartModel> getCartApi(String userid) async {
    var responseJson;
    await http.post(Uri.parse('${baseUrl()}get_cart_items'), body: {
      'user_id': userid,
    }).then((response) {
      responseJson = _returnResponse(response);
    }).catchError((onError) {
      print(onError);
    });
    return GetCartModel.fromJson(responseJson);
  }

  dynamic _returnResponse(http.Response response) {
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
