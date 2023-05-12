import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/screens/layout/newTabbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class BookingSccess extends StatefulWidget {
  String? image;
  String? name;
  String? location;
  String? date;
  String? time;

  BookingSccess({this.image, this.name, this.location, this.date, this.time});

  @override
  _OrderSuccessWidgetState createState() => _OrderSuccessWidgetState();
}

class _OrderSuccessWidgetState extends State<BookingSccess> {
  var dateFormate;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dateFormate = DateFormat("dd/MM/yyyy").format(DateTime.parse(widget.date!));
    return Scaffold(
      backgroundColor: appColorWhite,
      body: _projectInfo(),
    );
  }

  Widget _projectInfo() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Color(0xFF23a0c5),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: 100,
                        width: 100,
                        child: Image.asset('assets/images/checked.png')),
                    Container(
                      height: 20,
                    ),
                    Text(
                      "Booking Comfired",
                      style: TextStyle(color: appColorWhite, fontSize: 20),
                    ),
                    Container(
                      height: 10,
                    ),
                    Text(
                      "Thank You. See you soon.",
                      style: TextStyle(color: appColorWhite, fontSize: 12),
                    ),
                    Container(
                      height:15,
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    height: 350,
                    decoration: BoxDecoration(
                        color: appColorWhite,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 350,
                      child: Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.black45,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          child: Image.network(
                                            widget.image!,
                                            fit: BoxFit.cover,
                                          ))),
                                  Container(width: 10),
                                  Flexible(
                                    child: Text(
                                      widget.name!,
                                      style: TextStyle(
                                          color: appColorBlack,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    ),
                                  ),
                                ],
                              ),
                              Container(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: Container(
                                  height: 1,
                                  color: Colors.grey[300],
                                ),
                              ),
                              Container(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Location : ",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    //Expanded(child: Container()),
                                    Container(
                                      // width: 100,
                                      child: Flexible(
                                        child: Text(
                                          widget.location!,
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Date : ",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 25),
                                    Container(
                                      width: 100,
                                      child: Text(
                                        dateFormate,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Time : ",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 22),
                                    Container(
                                      width: 100,
                                      child: Text(
                                        widget.time!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => TabbarScreen(),
                            ),
                            (Route<dynamic> route) => false,
                          );
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
                                  border:
                                      Border.all(color: Colors.grey.shade400),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              height: 50.0,
                              // ignore: deprecated_member_use
                              child: Center(
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Done",
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
