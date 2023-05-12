import 'package:demo_project/src/blocs/signup_bloc.dart';
import 'package:demo_project/src/elements/error_dialog.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/strings.dart/string.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _unameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: appColorBlack),
      child: Scaffold(
        backgroundColor: appColorWhite,
        appBar: AppBar(
            backgroundColor: appColorWhite,
            elevation: 0,
            title: Text(
              "",
              style: TextStyle(
                  fontSize: 20,
                  color: appColorBlack,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            leading: Container()),
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _signupForm(context),
          ],
        ),
      ),
    );
  }

  Widget _signupForm(BuildContext context) {
    return Center(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              applogo(),
              Container(height: 30.0),
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Create Account",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'OpenSansBold',
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "Complete form below to continue.",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(height: 30.0),
              _userTextfield(context),
              Container(height: 10.0),
              _emailTextfield(context),
              Container(height: 10.0),
              _passwordTextfield(context),
              Container(height: 50.0),
              _loginButton(context),
              Container(height: 40.0),
              _dontHaveAnAccount(context),
              Container(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: unused_element

  Widget applogo() {
    return Padding(
      padding: const EdgeInsets.only(left: 35),
      child: Row(
        children: [
          Image.asset(
            'assets/images/Logo2.png',
            height: 40,
          ),
        ],
      ),
    );
  }

  Widget _userTextfield(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: CustomtextField(
        controller: _unameController,
        maxLines: 1,
        labelText: "User Name",
        hintText: "Enter User Name",
        textInputAction: TextInputAction.next,
        prefixIcon: Icon(Icons.person),
      ),
    );
  }

  Widget _passwordTextfield(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: CustomtextField(
        controller: _passwordController,
        maxLines: 1,
        labelText: "Password",
        hintText: "Enter Password",
        obscureText: !_obscureText,
        textInputAction: TextInputAction.next,
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }

  Widget _emailTextfield(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: CustomtextField(
        controller: _emailController,
        maxLines: 1,
        labelText: "Email",
        hintText: "Enter Email",
        textInputAction: TextInputAction.next,
        prefixIcon: Icon(Icons.email),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: InkWell(
        onTap: () {
          _signup(context);
        },
        child: SizedBox(
            height: 60,
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [
                        const Color(0xFF4b6b92),
                        const Color(0xFF619aa5),
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
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
                        "SIGN UP",
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

  // Widget _loginButton(BuildContext context) {
  //   return SizedBox(
  //     height: 55,
  //     width: MediaQuery.of(context).size.width - 105,
  //     child: CustomButtom(
  //       title: 'SIGNUP',
  //       color: Colors.white,
  //       onPressed: () {
  //         // Navigator.push(
  //         //   context,
  //         //   MaterialPageRoute(builder: (context) => SignUp()),
  //         // );
  //         _signup(context);
  //         print('Button is pressed');
  //       },
  //     ),
  //   );
  // }

  Widget _dontHaveAnAccount(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "Already have an account? ",
        style: TextStyle(
          fontSize: 15,
          color: appColorBlack,
          fontWeight: FontWeight.w700,
        ),
        children: <TextSpan>[
          TextSpan(
            recognizer: new TapGestureRecognizer(),
            // ..onTap = () => Navigator.push(
            //       context,
            //       CupertinoPageRoute(
            //         builder: (context) => Login(),
            //       ),
            //     ),
            text: ' Sign in',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  bool isLoading = false;

  void _signup(BuildContext context) {
    closeKeyboard();

    if (_unameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _emailController.text.isNotEmpty) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern.toString());
      if (regex.hasMatch(_emailController.text) &&
          _passwordController.text.length > 4) {
        setState(() {
          isLoading = true;
        });
        // Loader().showIndicator(context);

        signupBloc
            .signupSink(
          _emailController.text,
          _passwordController.text,
          _unameController.text,
        )
            .then(
          (userResponse) {
            if (userResponse.responseCode == Strings.responseSuccess) {
              // String userResponseStr = json.encode(userResponse);
              // preferences.setString(
              //     SharedPreferencesKey.LOGGED_IN_USERRDATA,
              //     userResponseStr);
              setState(() {
                isLoading = false;
              });
              // Toast.show("USER REGISTER SUCCESSFULLY", context,
              //     backgroundColor: Colors.white,
              //     textColor: Colors.black,
              //     duration: Toast.LENGTH_LONG,
              //     gravity: Toast.BOTTOM);
              Fluttertoast.showToast(
                  msg: "USER REGISTER SUCCESSFULLY",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey,
                  textColor: Colors.black,
                  fontSize: 15.0);
              signupBloc.dispose();
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => Login()),
              // );
              //
              // Navigator.of(context).pushAndRemoveUntil(
              //   MaterialPageRoute(
              //     builder: (context) => TabbarScreen(),
              //   ),
              //   (Route<dynamic> route) => false,
              // );
            } else if (userResponse.responseCode == '0') {
              setState(() {
                isLoading = false;
              });
              // loginerrorDialog(context, "Email id already registered");
              showDialog<dynamic>(
                  context: context,
                  builder: (BuildContext context) {
                    return ErrorDialog(
                      message: 'Email id already registered',
                    );
                  });
            } else {
              setState(() {
                isLoading = false;
              });
              // loginerrorDialog(
              //     context, "Make sure you have entered right credential");
              showDialog<dynamic>(
                  context: context,
                  builder: (BuildContext context) {
                    return ErrorDialog(
                      message: 'Make sure you have entered right credential',
                    );
                  });
            }
          },
        );
      } else {
        // loginerrorDialog(
        //     context, "Make sure you have entered right credential");
        showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return ErrorDialog(
                message: 'Make sure you have entered right credential',
              );
            });
      }
    } else {
      // loginerrorDialog(context, "Please enter valid credential to sign up");
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(
              message: 'Please enter valid credential to sign up',
            );
          });
    }
  }
}
