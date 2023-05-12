import 'dart:convert';
import 'dart:io';
import 'package:demo_project/src/models/uProfile_model.dart';
import 'package:http/http.dart' as http;
import 'package:demo_project/src/global/global.dart';

class UprofileApi {
  Future<UprofileModel> uProfileApi(
      String email,
      String username,
      String userID,
      String mobile,
      String address,
      String city,
      String country,
      File? image) async {
    var responseJson;
    var uri = Uri.parse('${baseUrl()}user_edit');
    var request = http.MultipartRequest('POST', uri);
    request.fields['email'] = email;
    request.fields['username'] = username;
    request.fields['id'] = userID;
    request.fields['mobile'] = mobile;
    request.fields['address'] = address;
    request.fields['city'] = city;
    request.fields['country'] = country;
    if (image != (null))
      request.files.add(await http.MultipartFile.fromPath(
        'profile_pic',
        image.path,
        // contentType: MediaType('application', 'x-tar'),
      ));
    // ..fields['email'] = email
    // ..fields['username'] = username
    // ..fields['id'] = userID
    // ..fields['mobile'] = mobile
    // ..fields['address'] = address
    // ..fields['city'] = city
    // ..fields['country'] = country
    // image !=(null)
    //  ..files.add(
    //   await http.MultipartFile.fromPath(
    //     'profile_pic',
    //     image.path,
    //     // contentType: MediaType('application', 'x-tar'),
    //   ),
    // var response = await request.send();
    http.Response response =
        await http.Response.fromStream(await request.send());
    responseJson = _returnResponse(response);
    return UprofileModel.fromJson(responseJson);

    // var responseJson;
    // await http.post('${baseUrl()}/register', body: {
    //   'email': email,
    //   'password': password,
    //   'username': username,
    //   'profile_pic': image,
    // }).then((response) {
    //   responseJson = _returnResponse(response);
    // }).catchError((onError) {
    //   print(onError);
    // });
    // return SignUpModel.fromJson(responseJson);
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(response.request);
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
