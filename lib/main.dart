import 'package:demo_project/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  SharedPreferences.getInstance().then((prefs) async {
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ueban Scale',
        home: AppScreen(prefs),
      )
    );
  });
}

