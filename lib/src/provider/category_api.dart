import 'dart:convert';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/models/getAllProdCat.dart';
import 'package:http/http.dart' as http;

class CategoryApi {
  Future<GetAllProdCategory> categoryApi() async {
    var responseJson;
    await http
        .get(Uri.parse('${baseUrl()}get_all_product_category'))
        .then((response) {
      responseJson = _returnResponse(response);
    }).catchError((onError) {
      print(onError);
    });
    return GetAllProdCategory.fromJson(responseJson);
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
