import 'dart:convert';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/models/serviceRating_model.dart';
import 'package:http/http.dart' as http;

class ServiceRatingApi {
  Future<ServiceRatingModel> serviceRatingApi(
    String userid,
    String serviceid,
    String ratings,
    String text,
  ) async {
    var responseJson;
    var uri = Uri.parse('${baseUrl()}reviews_service');
    var request = http.MultipartRequest('POST', uri)
      ..fields['user_id'] = userid
      ..fields['service_id'] = serviceid
      ..fields['ratings'] = ratings
      ..fields['text'] = text;

    // var response = await request.send();
    http.Response response =
        await http.Response.fromStream(await request.send());
    responseJson = _returnResponse(response);
    print(response.statusCode);
    return ServiceRatingModel.fromJson(responseJson);
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
