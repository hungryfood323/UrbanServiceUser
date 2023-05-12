// ignore_for_file: unused_field

import 'dart:convert';
import 'package:demo_project/src/blocs/login_bloc.dart';
import 'package:demo_project/src/blocs/validation.dart';
import 'package:demo_project/src/elements/error_dialog.dart';
import 'package:demo_project/src/elements/ps_button_widgets.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/screens/layout/google%20signin/google_sign_in.dart';
import 'package:demo_project/src/screens/layout/newTabbar.dart';
import 'package:demo_project/src/screens/user/forgotpassword/forgot_password_container.dart';
import 'package:demo_project/src/screens/user/register/register_container_view.dart';
import 'package:demo_project/src/share_preference/preferencesKey.dart';
import 'package:demo_project/src/strings.dart/string.dart';
import 'package:demo_project/src/utils/ps_dimens.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  final AnimationController? animationController;
  final bool? isLoading;
  const LoginView({
    Key? key,
    this.animationController,
    this.isLoading,
  }) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  AnimationController?  animationController;
  bool? isLoading;
  static const Duration animation_duration = Duration(milliseconds: 500);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _token = '';

  // getToken() {
  //   // FirebaseMessaging.instance.getToken().then((token) async {
  //   //   _token = token!;

  //   // });
  // }

  @override
  void initState() {
    animationController =
        AnimationController(duration: animation_duration, vsync: this);
    // getToken();
    print('>>>>>>>>>>>>>>????????????????????????????????????????' + _token);
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    // nameController.dispose();
    // emailController.dispose();
    // passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(
            parent: animationController!,
            curve: const Interval(0.5 * 1, 1.0, curve: Curves.fastOutSlowIn)));

    animationController!.forward();

    return SliverToBoxAdapter(
        child: Stack(
      children: <Widget>[
        SingleChildScrollView(
            child: AnimatedBuilder(
                animation: animationController!,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _HeaderIconAndTextWidget(),
                    SizedBox(height: PsDimens.space2),
                    _TextFieldWidget(
                      emailText: _emailController,
                      passwordText: _passwordController,
                    ),
                    const SizedBox(
                      height: PsDimens.space8,
                    ),
                    // _TermsAndConCheckbox(
                    //   emailTextEditingController: _emailController,
                    //   passwordTextEditingController: _passwordController,
                    // ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    _SignInButtonWidget(
                      emailTextEditingController: _emailController,
                      passwordTextEditingController: _passwordController,
                    ),
                    const SizedBox(
                      height: PsDimens.space16,
                    ),
                    _TextWidget(
                        // goToLoginSelected: widget.goToLoginSelected,
                        ),
                    const SizedBox(
                      height: PsDimens.space20,
                    ),
                    // _LoginWithFbWidget(),
                    // const SizedBox(
                    //   height: PsDimens.space8,
                    // ),
                    _LoginWithGoogleWidget(),
                    const SizedBox(
                      height: PsDimens.space12,
                    ),
                    _guestlogin(context),
                    // _LoginWithAppleWidget(),
                  ],
                ),
                builder: (BuildContext? context, Widget? child) {
                  return FadeTransition(
                      opacity: animation,
                      child: Transform(
                          transform: Matrix4.translationValues(
                              0.0, 100 * (1.0 - animation.value), 0.0),
                          child: child));
                }))
      ],
    ));
  }
}

// class _TermsAndConCheckbox extends StatefulWidget {
//   const _TermsAndConCheckbox({
//     required this.emailTextEditingController,
//     required this.passwordTextEditingController,
//   });

//   final TextEditingController
//       emailTextEditingController,
//       passwordTextEditingController;
//   @override
//   __TermsAndConCheckboxState createState() => __TermsAndConCheckboxState();
// }

// class __TermsAndConCheckboxState extends State<_TermsAndConCheckbox> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: <Widget>[
//         const SizedBox(
//           width: PsDimens.space20,
//         ),
//         Checkbox(
//           value: this.showvalue,
//           onChanged: () {

//           },
//         ),
//         Expanded(
//           child: InkWell(
//             child: Text(
//               Utils.getString(context, 'login__agree_privacy'),
//               style: Theme.of(context).textTheme.bodyText1,
//             ),
//             onTap: () {
//               setState(() {
//                 updateCheckBox(
//                     widget.provider.isCheckBoxSelect,
//                     context,
//                     widget.provider,
//                     widget.nameTextEditingController,
//                     widget.emailTextEditingController,
//                     widget.passwordTextEditingController
//                     );
//               });
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// void updateCheckBox(
//     bool isCheckBoxSelect,
//     BuildContext context,
//     TextEditingController nameTextEditingController,
//     TextEditingController emailTextEditingController,
//     TextEditingController passwordTextEditingController) {
//   if (isCheckBoxSelect) {
//     provider.isCheckBoxSelect = false;
//   } else {
//     provider.isCheckBoxSelect = true;
//     //it is for holder
//     provider.psValueHolder.userNameToVerify = nameTextEditingController.text;
//     provider.psValueHolder.userEmailToVerify = emailTextEditingController.text;
//     provider.psValueHolder.userPasswordToVerify =
//         passwordTextEditingController.text;
//     Navigator.pushNamed(context, RoutePaths.privacyPolicy, arguments: 1);
//   }
// }

class _TextWidget extends StatefulWidget {
  // ignore: unused_element
  const _TextWidget({this.goToLoginSelected});
  final Function? goToLoginSelected;
  @override
  __TextWidgetState createState() => __TextWidgetState();
}

class __TextWidgetState extends State<_TextWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          child: Ink(
            // color: appColorBlack,
            child: Text(
              'Don\'t have an account? SignUp',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: appColorBlack),
            ),
          ),
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RegisterContainerView()));
        });
  }
}

class _TextFieldWidget extends StatefulWidget {
  const _TextFieldWidget({
    required this.emailText,
    required this.passwordText,
  });

  final TextEditingController emailText, passwordText;
  @override
  __TextFieldWidgetState createState() => __TextFieldWidgetState();
}

class __TextFieldWidgetState extends State<_TextFieldWidget> {
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  bool _conpass = true;

  @override
  Widget build(BuildContext context) {
    const EdgeInsets _marginEdgeInsetWidget = EdgeInsets.only(
        left: PsDimens.space16,
        right: PsDimens.space16,
        top: PsDimens.space4,
        bottom: PsDimens.space4);

    const Widget _dividerWidget = Divider(
      height: PsDimens.space1,
    );
    return Column(
      children: [
        Card(
          elevation: 5,
          margin: const EdgeInsets.only(
              left: PsDimens.space32, right: PsDimens.space32),
          child: Column(
            children: <Widget>[
              Container(
                margin: _marginEdgeInsetWidget,
                child: StreamBuilder<String>(
                  stream: validationBloc.email,
                  builder: (context, AsyncSnapshot<String> snapshot) {
                    return TextField(
                      controller: widget.emailText,
                      onChanged: validationBloc.changeEmail,
                      focusNode: _emailFocus,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (value) {
                        FocusScope.of(context).unfocus();
                        FocusScope.of(context).requestFocus(_passwordFocus);
                      },
                      decoration: InputDecoration(
                          errorText: snapshot.error != null
                              ? snapshot.error.toString()
                              : '',
                          errorStyle: snapshot.error == null
                              ? TextStyle(height: 0)
                              : TextStyle(height: 1),
                          border: InputBorder.none,
                          hintText: 'Email',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .button!
                              .copyWith(color: Colors.black45),
                          icon: Icon(Icons.email, color: appColorBlack)),
                    );
                  },
                ),
              ),
              _dividerWidget,
              Container(
                margin: _marginEdgeInsetWidget,
                child: StreamBuilder<String>(
                  stream: validationBloc.password,
                  builder: (context, AsyncSnapshot<String> snapshot) {
                    return TextField(
                      controller: widget.passwordText,
                      onChanged: validationBloc.changePassword,
                      focusNode: _passwordFocus,
                      obscureText: _conpass,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (value) {
                        FocusScope.of(context).unfocus();
                        // FocusScope.of(context).requestFocus(_passwordFocus);
                      },
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _conpass = !_conpass;
                              });
                            },
                            color: Theme.of(context).focusColor,
                            icon: Icon(_conpass
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          errorText: snapshot.error != null
                              ? snapshot.error.toString()
                              : '',
                          errorStyle: snapshot.error == null
                              ? TextStyle(height: 0)
                              : TextStyle(height: 1),
                          border: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .button!
                              .copyWith(color: Colors.black45),
                          icon: Icon(Icons.lock, color: appColorBlack)),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 180.0),
          child: InkWell(
              child: Container(
                child: Ink(
                  // color: appColorBlack,
                  child: Text(
                    'Forgot Password ?',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: appColorBlack),
                  ),
                ),
              ),
              onTap: () {
                // if (widget.goToLoginSelected != null) {
                //   widget.goToLoginSelected!();
                // } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotContainerView()));
              }
              // },
              ),
        )
      ],
    );
  }
}

class _HeaderIconAndTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: PsDimens.space32,
        ),
        Container(
          width: 150,
          height: 90,
          child: Image.asset(
            'assets/images/Logo2.png',
          ),
        ),
        const SizedBox(
          height: PsDimens.space8,
        ),
        // Text(
        //   'Login Account',
        //   style: Theme.of(context).textTheme.headline6!.copyWith(
        //         fontWeight: FontWeight.bold,
        //         color: appColorBlack,
        //       ),
        // ),
        const SizedBox(
          height: PsDimens.space52,
        ),
      ],
    );
  }
}

class _SignInButtonWidget extends StatefulWidget {
  final TextEditingController emailTextEditingController,
      passwordTextEditingController;

  const _SignInButtonWidget({
    required this.emailTextEditingController,
    required this.passwordTextEditingController,
  });

  @override
  __SignInButtonWidgetState createState() => __SignInButtonWidgetState();
}

dynamic callWarningDialog(BuildContext context, String text) {
  showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        return ErrorDialog(
          message: text,
        );
      });
}

class _LoginWithFbWidget extends StatefulWidget {
  // ignore: unused_element
  const _LoginWithFbWidget({this.onFbSignInSelected});
  final Function? onFbSignInSelected;

  @override
  __LoginWithFbWidgetState createState() => __LoginWithFbWidgetState();
}

class __LoginWithFbWidgetState extends State<_LoginWithFbWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: PsDimens.space32,
          top: PsDimens.space8,
          right: PsDimens.space32),
      child: PSButtonWithIconWidget(
          titleText: 'Login with Facebook',
          icon: Icons.facebook,
          colorData: appColorBlack,
          onPressed: () async {}),
    );
  }
}

class _LoginWithGoogleWidget extends StatefulWidget {
  // ignore: unused_element
  const _LoginWithGoogleWidget({this.onGoogleSignInSelected});
  final Function? onGoogleSignInSelected;

  @override
  __LoginWithGoogleWidgetState createState() => __LoginWithGoogleWidgetState();
}

class __LoginWithGoogleWidgetState extends State<_LoginWithGoogleWidget> {
  @override
  Widget build(BuildContext context) {
    return googleButton();
  }

  bool isLoading = false;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Widget googleButton() {
    return isLoading
        ? loader(context)
        : Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: InkWell(
              onTap: () {
                firebaseMessaging.getToken().then((token) {
                  setState(() {
                    isLoading = true;
                  });
                  signInWithGoogle(context, token!).whenComplete(() {
                    setState(() {
                      isLoading = false;
                    });
                  });
                });
              },
              child: SizedBox(
                  height: 45,
                  //width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                        color: appColorWhite,
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    height: 50.0,
                    // ignore: deprecated_member_use
                    child: Center(
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Image.asset(
                                "assets/images/google.png",
                                 
                                height: 25,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Login With Google",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: appColorBlack,
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
}

Widget _guestlogin(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 30, right: 30),
    child: InkWell(
      onTap: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('guest user', '0');
        // setState(() {
        //   userID = "0";
        // });

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => TabbarScreen(),
          ),
          (Route<dynamic> route) => false,
        );
      },
      child: SizedBox(
          height: 45,
          //width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
                color: appColorWhite,
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            height: 50.0,
            // ignore: deprecated_member_use
            child: Center(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        "assets/images/user.png",
                        height: 25,
                        color: appColorBlack,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Login as a Guest",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: appColorBlack,
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

// Widget _guestlogin(BuildContext context) {
//   return InkWell(
//     onTap: () async {
//       SharedPreferences preferences = await SharedPreferences.getInstance();
//       preferences.setString('guest user', '0');
//       // setState(() {
//       //   userID = "0";
//       // });

//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(
//           builder: (context) => TabbarScreen(),
//         ),
//         (Route<dynamic> route) => false,
//       );
//     },
//     child: Container(
//       child: Padding(
//           padding: EdgeInsets.all(5.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Icon(CupertinoIcons.person),
//               SizedBox(
//                 width: 5,
//               ),
//               Text(
//                 'Login as a Guest',
//                 style: TextStyle(
//                   fontSize: 15,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           )),
//     ),
//   );
// }

class _LoginWithAppleWidget extends StatefulWidget {
  // ignore: unused_element
  const _LoginWithAppleWidget({this.onAppleSignInSelected});
  final Function? onAppleSignInSelected;

  @override
  __LoginWithAppleWidgetState createState() => __LoginWithAppleWidgetState();
}

class __LoginWithAppleWidgetState extends State<_LoginWithAppleWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: PsDimens.space32,
          top: PsDimens.space8,
          right: PsDimens.space32),
      child: PSButtonWithIconWidget(
        titleText: 'Login with Apple',
        icon: Icons.ac_unit_outlined,
        // colorData:Color,
        onPressed: () async {},
      ),
    );
  }
}

class __SignInButtonWidgetState extends State<_SignInButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: PsDimens.space32, right: PsDimens.space32),
      child: isLoading
          ? loader(context)
          : PSButtonWidget(
              hasShadow: true,
              width: double.infinity,
              titleText: 'Login',
              onPressed: () {
                print(
                    '............................Button Pressed ............................');

                if (widget.emailTextEditingController.text.isEmpty) {
                  showDialog<dynamic>(
                      context: context,
                      builder: (BuildContext context) {
                        return ErrorDialog(
                          message: 'Enter Email',
                        );
                      });
                } else if (widget.passwordTextEditingController.text.isEmpty) {
                  showDialog<dynamic>(
                      context: context,
                      builder: (BuildContext context) {
                        return ErrorDialog(
                          message: 'Enter Password',
                        );
                      });
                } else {
                  if (RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(
                          widget.emailTextEditingController.text.trim())) {
                    _apiCall(context);
                    // await widget.provider.signUpWithEmailId(
                    //     context,
                    //     widget.onRegisterSelected,
                    //     widget.nameTextEditingController.text,
                    //     widget.emailTextEditingController.text.trim(),
                    //     widget.passwordTextEditingController.text);
                  } else {
                    showDialog<dynamic>(
                        context: context,
                        builder: (BuildContext context) {
                          return ErrorDialog(
                            message: 'enter valid email',
                          );
                        });
                  }
                }
              },
              colorData: null,
              gradient: null,
            ),
    );
  }

  bool isLoading = false;
  void _apiCall(BuildContext context) {
    closeKeyboard();

    FirebaseMessaging.instance.getToken().then((token) async {
      print('TOKEN : $token');
      setState(() {
        isLoading = true;
      });

      setState(() {
        isLoading = true;
      });

      loginBloc
          .loginSink(widget.emailTextEditingController.text,
              widget.passwordTextEditingController.text, token!)
          .then(
        (userResponse) async {
          if (userResponse.responseCode == Strings.responseSuccess) {
            String userResponseStr = json.encode(userResponse);
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.remove('guest user');
            preferences.setString(
                SharedPreferencesKey.LOGGED_IN_USERRDATA, userResponseStr);
            // Loader().hideIndicator(context);
            loginBloc.dispose();
            setState(() {
              isLoading = false;
            });
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => TabbarScreen(),
              ),
              (Route<dynamic> route) => false,
            );
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
            setState(() {
              isLoading = false;
            });
          }
        },
      );
    });
  }
}
