import 'dart:convert';
import 'package:demo_project/src/global/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

class ApplyCharges {
  Future applyCharges(String custID, BuildContext context, String price) async {
    // print("Original" + price.toString());
    //  var long2 = double.parse(price);
    //print("Original" + long2.toString());
    // var t = int.parse(price);

    // print("t" + t.toString());

    var newString = price.replaceAll(",", "");

    var totalAmount = double.parse(newString) * 100;

    var finalAmount = totalAmount.toStringAsFixed(0);

    print(finalAmount + "<><><><><><");
    // print(totalAmount.toString() + ">>><<<");

    // String amount = "${price.toStringAsFixed(0)}";

    // print(amount.toString() + "<><><><><><");
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // final myString = preferences.getString('price') ?? '';

    try {
      final response = await http.Client().post(
        Uri.parse("https://api.stripe.com/v1/charges"),
        body: {
          "amount": finalAmount.toString(),
          "currency": "usd",
          "customer": custID,
          "description": "Testing"
        },
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
          'Authorization': 'Bearer $stripSecret'
        },
      );
      print(response.body);
      // ignore: unused_local_variable
      var responseJson;
      return responseJson = _returnResponse(response);
    } on Exception {
      throw Exception('No Internet connection');
    }
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
      case 403:
        throw Exception(response.body.toString());
      case 500:
      default:
        throw Exception(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

final applyCharges = ApplyCharges();
