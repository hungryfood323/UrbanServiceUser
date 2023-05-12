// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

String appName = 'ESHIELD PRO';

const Color backgroundblack = Color(0xFF414141);
const Color backgroundgrey = Color(0xFFf4f7f8);
const Color splashColor = Color(0xFF45bfec);
const Color appColorGreen = Color(0xFF1E3C72);
const Color appColorOrange = Color(0xFFffa93b);
const Color appColorBlack = Colors.black;
const Color appGreen = Color(0XFF1ea36d);
const Color appbarColor = Color(0XFFf5f1ec);
const Color iconColor = Color(0XFF9e7e5b);
const Color ratingBgColor = Color(0XFFffefe7);
const Color appColorWhite = Colors.white;
const Color appColorBlue = Color(0xFFADD8E6);
const Color appIconColor = Color(0xFF445E76);
const Color appColorYellow = Color(0XFFE7B12D);

const Color blackcolor = Color(0xff123456);
const Color IndigoColor = Color(0xFF1A237E);
const Color WhiteColor = Color(0xFFFFFFFF);

String userID = '';
String userEmail = '';
String userMobile = '';
String userName = '';
String userImage = '';
String userCity = '';
var likedProduct = [];
var likedService = [];

String stripSecret = ' ';
String stripPublic = '';
String rozSecret = '';
String rozPublic = '';


String serverKey =
    'AAAAqh1Nstg:APA91bFxv6IjIge1pGr_2qAP9SIqUIpxZ8_0aYS998ZeBfjVux-Mg07cHAMvabyCf3AUiLXNcsLDQ7_4YdYBfRf2bljzOGWZ-ID03EKb3RWNaZNlaOK9zX7kZcngMsex6BwIqlQL9lNH';

Client client = Client();

closeKeyboard() {
  return SystemChannels.textInput.invokeMethod('TextInput.hide');
}

// String baseUrl() {
//   return 'https://primocysapp.com/eshield_multivendor/api/';
// }

String baseUrl() {
  return 'https://fypservicepro.funtashtechnologies.com/api/';
  //return 'https://theprimoapp.com/urbanservice/api/';
}

SharedPreferences? preferences;

Widget load() {
  return Center(
    child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(appColorBlack)),
              )),
        )),
  );
}

class CustomtextField extends StatefulWidget {
  final TextInputType? keyboardType;
  final Function()? onTap;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Function()? onEditingComplate;
  final Function(String)? onSubmitted;
  final dynamic controller;
  final int? maxLines;
  final dynamic onChange;
  final String? errorText;
  final String? hintText;
  final String? labelText;
  bool obscureText = false;
  bool readOnly = false;
  bool autoFocus = false;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  CustomtextField({
    this.keyboardType,
    this.onTap,
    this.focusNode,
    this.textInputAction,
    this.onEditingComplate,
    this.onSubmitted,
    this.controller,
    this.maxLines,
    this.onChange,
    this.errorText,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.readOnly = false,
    this.autoFocus = false,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  _CustomtextFieldState createState() => _CustomtextFieldState();
}

class _CustomtextFieldState extends State<CustomtextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      readOnly: widget.readOnly,
      textInputAction: widget.textInputAction,
      onTap: widget.onTap,
      autofocus: widget.autoFocus,
      maxLines: widget.maxLines,
      onEditingComplete: widget.onEditingComplate,
      onSubmitted: widget.onSubmitted,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      onChanged: widget.onChange,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        filled: true,
        fillColor: appColorWhite,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        labelText: widget.labelText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
        errorStyle: TextStyle(color: Colors.black),
        errorText: widget.errorText,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: widget.hintText,
        focusColor: Colors.black,
        labelStyle: TextStyle(color: Colors.black, fontSize: 14),
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

// class CustomButton extends StatelessWidget {
//   final Color? color;
//   final String? title;
//   final Function()? onPressed;
//   CustomButton({
//     this.color,
//     this.title,
//   this.onPressed,
//   });
//   @override
//   Widget build(BuildContext context) {
//     // ignore: deprecated_member_use
//     return ElevatedButton(
//       child: Text(
//         title!,
//         style: TextStyle(
//           color: appColorWhite,
//           fontSize: 15,
//           // fontStyle: FontStyle.italic,
//           fontWeight: FontWeight.w700,
//         ),
//       ),
//       // shape: RoundedRectangleBorder(
//       //   side: BorderSide(color: appColorGreen, width: 1.8),
//       //   borderRadius: BorderRadius.circular(10),
//       // ),
//       onPressed: onPressed,
//     );
//   }
// }

void loginerrorDialog(BuildContext context, String message, {bool? button}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(height: 10.0),
            Text(message, textAlign: TextAlign.center),
            Container(height: 30.0),
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width - 100,
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => TabbarScreen()),
                  // );
                  Navigator.pop(context);
                },
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}

bool? checkEmailFormat(String? email) {
  bool? emailFormat;
  if (email != '') {
    emailFormat = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email!);
  }
  return emailFormat;
}

class Loader {
  void showIndicator(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Center(
            child: Material(
          type: MaterialType.transparency,
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black.withOpacity(0.7),
              ),
              Center(
                child: CircularProgressIndicator(
                  color: appColorWhite,
                ),
              )
            ],
          ),
        ));
      },
    );
  }

  void hideIndicator(BuildContext context) {
    Navigator.pop(context);
  }
}

void bookDialog(BuildContext context, String message, {bool? button}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(height: 10.0),
            Text(message, textAlign: TextAlign.center),
            Container(height: 30.0),
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width - 100,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}

Widget loader(BuildContext context) {
  return Center(
    child: Container(
      height: 40,
      width: 40,
      decoration: new BoxDecoration(
        color: appColorBlack,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: 3,
        ),
      ),
    ),
  );
}

Widget ingenieriaTextfield(
    {Widget? prefixIcon,
    Function(String)? onChanged,
    List<TextInputFormatter>? inputFormatters,
    String? hintText,
    Function? onTap,
    TextEditingController? controller,
    int? maxLines,
    TextInputType? keyboardType}) {
  return TextField(
    controller: controller,
    onTap: () {},
    inputFormatters: inputFormatters,
    maxLines: maxLines,
    keyboardType: keyboardType,
    onChanged: onChanged,
    style: TextStyle(color: Colors.black, fontSize: 15),
    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey[500], fontSize: 15),
      filled: true,
      contentPadding: EdgeInsets.only(top: 30.0, left: 10.0),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(0),
      ),
      fillColor: Colors.transparent,
    ),
  );
}

class ReviewtextField extends StatefulWidget {
  final TextInputType? keyboardType;
  final Function()? onTap;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Function()? onEditingComplate;
  final Function()? onSubmitted;
  final dynamic controller;
  final int? maxLines;
  final dynamic onChange;
  final String? errorText;
  final String? hintText;
  final String? labelText;
  bool obscureText = false;
  bool readOnly = false;
  bool autoFocus = false;
  final Widget? suffixIcon;

  final Widget? prefixIcon;
  ReviewtextField({
    this.keyboardType,
    this.onTap,
    this.focusNode,
    this.textInputAction,
    this.onEditingComplate,
    this.onSubmitted,
    this.controller,
    this.maxLines,
    this.onChange,
    this.errorText,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.readOnly = false,
    this.autoFocus = false,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  _ReviewtextFieldState createState() => _ReviewtextFieldState();
}

class _ReviewtextFieldState extends State<ReviewtextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      readOnly: widget.readOnly,
      textInputAction: widget.textInputAction,
      onTap: widget.onTap,
      autofocus: widget.autoFocus,
      maxLines: widget.maxLines,
      onEditingComplete: widget.onEditingComplate,
      //onSubmitted: widget.onSubmitted!,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      onChanged: widget.onChange,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        labelText: widget.labelText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
        errorStyle: TextStyle(color: Colors.black),
        errorText: widget.errorText,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: widget.hintText,
        labelStyle: TextStyle(color: Color(0xFF106C6F)),
        hintStyle: TextStyle(color: Colors.black),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.8),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 0.5),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
