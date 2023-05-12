// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/models/social_model.dart';
import 'package:demo_project/src/screens/layout/newTabbar.dart';
import 'package:demo_project/src/share_preference/preferencesKey.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

String? name;
String? email;
String? imageUrl;
String? userId;
String? data = "";
Future<String> signInWithGoogle(BuildContext context, String _fcmtoken) async {
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final User? user = authResult.user;

  // Checking if email and name is null
  assert(user!.email != null);
  assert(user!.displayName != null);
  assert(user!.photoURL != null);

  name = user!.displayName;
  email = user.email;
  imageUrl = user.photoURL;
  userId = user.uid;

  print(name);
  print(email);
  print(imageUrl);

  // Only taking the first part of the name, i.e., First Name
  // if (name.contains(" ")) {
  //   name = name.substring(0, name.indexOf(" "));
  // }

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final User? currentUser = _auth.currentUser;
  assert(user.uid == currentUser!.uid);

  if (user.uid != null) {
    _userDataPost(context, _fcmtoken);
  }

  return 'signInWithGoogle succeeded: $user';
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Sign Out");
}

_userDataPost(BuildContext context, String _fcmtoken) async {
  SocialModel? socialModel;

  var uri = Uri.parse('${baseUrl()}social_login');
  var request = new http.MultipartRequest("Post", uri);
  Map<String, String> headers = {
    "Accept": "application/json",
  };
  request.headers.addAll(headers);
  request.fields.addAll({
    'username': name!,
    'email': email!,
    'type': 'google',
    'facebook_id': userId!,
    'image_url': imageUrl!,
    'device_token': _fcmtoken
  });
  // request.fields['user_id'] = userID;
  var response = await request.send();
  print('REQUESTED FIELDS : ${request.fields}');
  print(response.statusCode);
  String responseData = await response.stream.transform(utf8.decoder).join();
  var userData = json.decode(responseData);
  socialModel = SocialModel.fromJson(userData);

  if (socialModel.responseCode == "1") {
    String userResponseStr = json.encode(userData);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('guest user');
    preferences.setString(
        SharedPreferencesKey.LOGGED_IN_USERRDATA, userResponseStr);
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => TabbarScreen(),
      ),
      (Route<dynamic> route) => false,
    );
  } else {
    Fluttertoast.showToast(
        msg: "Google login fail!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  print(responseData);
}
