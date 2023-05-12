import 'package:demo_project/src/blocs/signup_bloc.dart';
import 'package:demo_project/src/blocs/validation.dart';
import 'package:demo_project/src/elements/error_dialog.dart';
import 'package:demo_project/src/elements/ps_button_widgets.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/screens/user/login/login_container_view.dart';
import 'package:demo_project/src/strings.dart/string.dart';
import 'package:demo_project/src/utils/ps_dimens.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterView extends StatefulWidget {
  final AnimationController? animationController;
  final bool? isLoading;
  const RegisterView({
    Key? key,
    this.animationController,
    this.isLoading,
  }) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  bool? isLoading;
  static const Duration animation_duration = Duration(milliseconds: 500);

  final TextEditingController _unameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    animationController =
        AnimationController(duration: animation_duration, vsync: this);

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
                    _TextFieldWidget(
                      nameText: _unameController,
                      emailText: _emailController,
                      passwordText: _passwordController,
                    ),
                    const SizedBox(
                      height: PsDimens.space8,
                    ),
                    // _TermsAndConCheckbox(
                    //   nameTextEditingController: _unameController,
                    //   emailTextEditingController: _emailController,
                    //   passwordTextEditingController: _passwordController,
                    // ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    _SignInButtonWidget(
                      nameTextEditingController: _unameController,
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
                      height: PsDimens.space64,
                    ),
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
//     required this.nameTextEditingController,
//     required this.emailTextEditingController,
//     required this.passwordTextEditingController,
//   });

//   final TextEditingController nameTextEditingController,
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
//                     widget.passwordTextEditingController);
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
              'Already member? login',
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => LoginContainerView()));
        }
        // },
        );
  }
}

class _TextFieldWidget extends StatefulWidget {
  const _TextFieldWidget({
    required this.nameText,
    required this.emailText,
    required this.passwordText,
  });

  final TextEditingController nameText, emailText, passwordText;
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
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(
          left: PsDimens.space32, right: PsDimens.space32),
      child: Column(
        children: <Widget>[
          Container(
            margin: _marginEdgeInsetWidget,
            child: StreamBuilder<String>(
              stream: validationBloc.username,
              builder: (context, AsyncSnapshot<String?> snapshot) {
                return TextField(
                  controller: widget.nameText,
                  onChanged: validationBloc.changeUsername,
                  focusNode: _usernameFocus,
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (value) {
                    FocusScope.of(context).unfocus();
                    FocusScope.of(context).requestFocus(_emailFocus);
                  },
                  decoration: InputDecoration(
                      errorText: snapshot.error != null
                          ? snapshot.error.toString()
                          : '',
                      errorStyle: snapshot.error == null
                          ? TextStyle(height: 0)
                          : TextStyle(height: 1),
                      border: InputBorder.none,
                      hintText: 'User Name',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .button!
                          .copyWith(color: Colors.black45),
                      icon: Icon(Icons.people, color: appColorBlack)),
                );
              },
            ),
          ),
          _dividerWidget,
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
                  textInputAction: TextInputAction.next,
                  obscureText: _conpass,
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
                        icon: Icon(
                            _conpass ? Icons.visibility_off : Icons.visibility),
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
          height: PsDimens.space20,
        ),
        Text(
          'Create Account',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontWeight: FontWeight.bold,
                color: appColorBlack,
              ),
        ),
        const SizedBox(
          height: PsDimens.space52,
        ),
      ],
    );
  }
}

class _SignInButtonWidget extends StatefulWidget {
  final TextEditingController nameTextEditingController,
      emailTextEditingController,
      passwordTextEditingController;

  const _SignInButtonWidget({
    required this.nameTextEditingController,
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
              titleText: 'Register',
              onPressed: () async {
                print('object');
                if (widget.nameTextEditingController.text.isEmpty) {
                  // callWarningDialog(context, 'enter name');
                  showDialog<dynamic>(
                      context: context,
                      builder: (BuildContext context) {
                        return ErrorDialog(
                          message: 'Enter Username',
                        );
                      });
                } else if (widget.emailTextEditingController.text.isEmpty) {
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
                    _signup(context);
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
              // colorData: null,
              // gradient: null,
            ),
    );
  }

  bool isLoading = false;
  void _signup(BuildContext context) {
    closeKeyboard();

    setState(() {
      isLoading = true;
    });

    signupBloc
        .signupSink(
            widget.emailTextEditingController.text,
            widget.passwordTextEditingController.text,
            widget.nameTextEditingController.text)
        .then(
      (userResponse) {
        if (userResponse.responseCode == Strings.responseSuccess) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(
              msg: "USER REGISTER SUCCESSFULLY",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fontSize: 13.0);
          signupBloc.dispose();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginContainerView()),
          );
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
          showDialog<dynamic>(
              context: context,
              builder: (BuildContext context) {
                return ErrorDialog(
                  message: 'Email id already register',
                );
              });
        } else {
          setState(() {
            isLoading = false;
          });
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

    // if (widget.nameTextEditingController.text.isNotEmpty &&
    //     widget.emailTextEditingController.text.isNotEmpty &&
    //     widget.passwordTextEditingController.text.isNotEmpty) {
    //   Pattern pattern =
    //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    //   RegExp regex = new RegExp(pattern.toString());
    //   if (regex.hasMatch(widget.emailText.text) &&
    //       widget.passwordText.text.length > 4) {

    //   } else {
    //     loginerrorDialog(
    //         context, "Make sure you have entered right credential");
    //   }
    // } else {
    //   loginerrorDialog(context, "Please enter valid credential to sign up");
    // }
  }
}
