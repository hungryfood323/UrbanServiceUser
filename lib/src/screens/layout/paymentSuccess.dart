import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/screens/layout/newTabbar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PaymentSuccess extends StatefulWidget {
  String? price, txn;
  PaymentSuccess({this.price, this.txn});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<PaymentSuccess> {
  final GlobalKey<ScaffoldState> _scaffoldsKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffoldsKey, body: mainBody());
  }

  Widget mainBody() {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: appColorWhite,
          body: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(child: Image.asset("assets/images/success.png")),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.txn == ''
                              ? 'Order Confirmed'
                              : "Payment Successful!",
                          style: TextStyle(
                              color: appColorBlack,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Container(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Text(
                        widget.txn == ''
                            ? "Thank you! Your Order has been received."
                            : "Thank you! Your payment of \$${widget.price} has been received.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black45,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              bottom()
            ],
          ),
        ),
      ],
    );
  }

  Widget top(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
          height: 90,
          child: Padding(
            padding: const EdgeInsets.only(right: 20, top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration:
                        BoxDecoration(color: appGreen, shape: BoxShape.circle),
                    child: Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget bottom() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TabbarScreen()),
              );
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
                            "Continue",
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
        ),
      ),
    );
  }
}
