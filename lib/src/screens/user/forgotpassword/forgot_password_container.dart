import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/screens/user/forgotpassword/forgot_password_view.dart';
import 'package:flutter/material.dart';

class ForgotContainerView extends StatefulWidget {
  @override
  _ForgotContainerViewState createState() => _ForgotContainerViewState();
}

class _ForgotContainerViewState extends State<ForgotContainerView>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  bool? isLoading = false;

  static const Duration animation_duration = Duration(milliseconds: 500);
  @override
  void initState() {
    animationController =
        AnimationController(duration: animation_duration, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
                    title: 'Forgot Password',
                    scaffoldKey: scaffoldKey,
                  ),
                  ForgotView(
                    animationController: animationController,
                   
                  ),
                
                ]),
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
      automaticallyImplyLeading: true,
      // brightness: Utils.getBrightnessForAppBar(context),
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
      actions: <Widget>[
        // IconButton(
        //   icon: Icon(Icons.notifications_none,
        //       color: Theme.of(context).iconTheme.color),
        //   onPressed: () {
        //     // Navigator.pushNamed(
        //     //   context,
        //     //   RoutePaths.notiList,
        //     // );
        //   },
        // ),
        // IconButton(
        //   icon:
        //       Icon(Feather.book_open, color: Theme.of(context).iconTheme.color),
        //   onPressed: () {
        //     Navigator.pushNamed(
        //       context,
        //       RoutePaths.blogList,
        //     );
        //   },
        // )
      ],
      elevation: 0,
    );
  }
}
