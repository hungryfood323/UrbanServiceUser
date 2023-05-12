import 'package:demo_project/src/blocs/changepass_bloc.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/global/sizeconfig.dart';
import 'package:demo_project/src/strings.dart/string.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChangePass extends StatefulWidget {
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ChangePass> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;

  final TextEditingController _passController = TextEditingController();
  final TextEditingController _npassController = TextEditingController();
  final TextEditingController _cpassController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: appColorWhite,
      body: Stack(
        children: [
          Scaffold(
              backgroundColor: appColorWhite,
              appBar: AppBar(
                backgroundColor: appColorWhite,
                elevation: 2,
                title: Text(
                  "Change Password",
                  style: TextStyle(
                      fontSize: 20,
                      color: appColorBlack,
                      fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: appColorBlack,
                    )),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(height: 50.0),
                      applogo(),
                      Container(height: 30.0),
                      _passTextfield(context),
                      Container(height: 10.0),
                      _npassTextfield(context),
                      Container(height: 10.0),
                      _cpassTextfield(context),
                      Container(height: 30.0),
                      _loginButton(context),
                    ],
                  ),
                ),
              )),
          isLoading == true
              ? Center(
                  child: loader(context),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: InkWell(
        onTap: () async {
          if (_passController.text.isNotEmpty &&
              _npassController.text.isNotEmpty &&
              _cpassController.text.isNotEmpty) {
            if (_npassController.text == _cpassController.text) {
              _apiCall();
            } else {
              // Toast.show("Password do not match", context,
              //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
              Fluttertoast.showToast(
                  msg: "Password do not match",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey.shade200,
                  textColor: Colors.black,
                  fontSize: 13.0);
            }
          } else {
            // Toast.show("Missing Fields", context,
            //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            Fluttertoast.showToast(
                msg: "Missing Fields",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey.shade200,
                textColor: Colors.black,
                fontSize: 13.0);
          }
        },
        child: SizedBox(
            height: 60,
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                color: appColorBlack,
                  // gradient: new LinearGradient(
                  //     colors: [
                  //       const Color(0xFF4b6b92),
                  //       const Color(0xFF619aa5),
                  //     ],
                  //     begin: const FractionalOffset(0.0, 0.0),
                  //     end: const FractionalOffset(1.0, 0.0),
                  //     stops: [0.0, 1.0],
                  //     tileMode: TileMode.clamp),
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              height: 50.0,
              // ignore: deprecated_member_use
              child: Center(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "SUBMIT",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: appColorWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  _apiCall() async {
    setState(() {
      isLoading = true;
    });

    changePassBloc
        .changePassSink(userID, _passController.text, _npassController.text,
            _cpassController.text)
        .then((userData) {
      if (userData.responseCode == Strings.responseSuccess) {
        Fluttertoast.showToast(
            msg: userData.message!,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade200,
            textColor: Colors.black,
            fontSize: 13.0);
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
            msg: userData.message!,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade200,
            textColor: Colors.black,
            fontSize: 13.0);
      }
    });

    // if (changePassModal.responseCode == "1") {
    //   Toast.show(changePassModal.message, context,
    //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    //   Navigator.pop(context);
    // } else {
    //   Toast.show(changePassModal.message.toString(), context,
    //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    // }

    setState(() {
      isLoading = false;
    });
  }

  Widget applogo() {
    return Column(
      children: [
        Image.asset(
          'assets/images/Logo2.png',
          height: 80,
          width: 150,
        ),
        // SizedBox(
        //   height: 10,
        // ),
        // Text('EZSHIELD PRO',
        //     style: TextStyle(
        //         color: appColorBlack,
        //         fontSize: 20,
        //         fontWeight: FontWeight.bold,
        //         fontFamily: 'OpenSans',
        //         fontStyle: FontStyle.italic)),
        SizedBox(
          height: 5,
        ),
        Text('',
            style: TextStyle(
              color: appColorBlack,
              fontSize: 12,
            )),
      ],
    );
  }

  Widget _passTextfield(BuildContext context) {
    return CustomtextField(
      controller: _passController,
      maxLines: 1,
      textInputAction: TextInputAction.next,
      hintText: 'Enter Current Password',
      prefixIcon:
          Container(margin: EdgeInsets.all(10.0), child: Icon(Icons.lock)),
    );
  }

  Widget _npassTextfield(BuildContext context) {
    return CustomtextField(
      controller: _npassController,
      maxLines: 1,
      textInputAction: TextInputAction.next,
      hintText: 'Enter New Password',
      prefixIcon:
          Container(margin: EdgeInsets.all(10.0), child: Icon(Icons.lock)),
    );
  }

  Widget _cpassTextfield(BuildContext context) {
    return CustomtextField(
      controller: _cpassController,
      maxLines: 1,
      textInputAction: TextInputAction.next,
      hintText: 'Enter Confirm Password',
      prefixIcon:
          Container(margin: EdgeInsets.all(10.0), child: Icon(Icons.lock)),
    );
  }
}
