import 'dart:convert';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/models/addtocart_model.dart';

import 'package:http/http.dart' as http;

class AddtocartApi {
  Future<AddToCartModel> addtocartApi(
      String quanity, String userID, String productID) async {
    var responseJson;
    await http.post(Uri.parse('${baseUrl()}add_to_cart'), body: {
      'quantity': quanity,
      'user_id': userID,
      'product_id': productID
    }).then((response) {
      responseJson = _returnResponse(response);
    }).catchError((onError) {
      print(onError);
    });
    return AddToCartModel.fromJson(responseJson);
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
