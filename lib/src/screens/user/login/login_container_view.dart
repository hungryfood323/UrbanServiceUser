import 'package:demo_project/src/elements/circular_loading.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/screens/user/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginContainerView extends StatefulWidget {
  @override
  _LoginContainerViewState createState() => _LoginContainerViewState();
}

class _LoginContainerViewState extends State<LoginContainerView>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  static const Duration animation_duration = Duration(milliseconds: 500);
  @override
  void initState() {
    request();
    animationController =
        AnimationController(duration: animation_duration, vsync: this);
    super.initState();
  }

  request() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
      Permission.notification,
      Permission.camera,
    ].request();
    print(statuses[Permission.location]);
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Future<bool> _requestPop() {
      animationController!.reverse().then<dynamic>(
        (void data) {
          if (!mounted) {
            return Future<bool>.value(false);
          }
          Navigator.pop(context, true);
          return Future<bool>.value(true);
        },
      );
      return Future<bool>.value(false);
    }

    print(
        '............................Build UI Again ............................');
    // userRepo = Provider.of<UserRepository>(context);
    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          body: Stack(children: <Widget>[
            // Container(
            //   color: appColorGreen.withOpacity(0.2),
            //   width: double.infinity,
            //   height: double.maxFinite,
            // ),
            CustomScrollView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                slivers: <Widget>[
                  _SliverAppbar(
                    title: 'Login',
                    scaffoldKey: scaffoldKey,
                  ),
                  isLoading
                      ? CircularLoadingWidget(height: 200)
                      : LoginView(
                          animationController: animationController,
                          isLoading: isLoading),
                ])
          ]),
        ));
  }
}

class _SliverAppbar extends StatefulWidget {
  const _SliverAppbar(
      {Key? key, required this.title, required this.scaffoldKey})
      : super(key: key);
  final String title;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  _SliverAppbarState createState() => _SliverAppbarState();
}

class _SliverAppbarState extends State<_SliverAppbar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: appColorBlack,
      automaticallyImplyLeading: false,
      iconTheme: Theme.of(context).iconTheme.copyWith(color: appColorWhite),
      title: Text(
        widget.title,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(fontWeight: FontWeight.bold)
            .copyWith(color: appColorWhite),
      ),
      centerTitle: true,
      elevation: 0,
    );
  }
}
