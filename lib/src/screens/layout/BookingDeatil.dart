// ignore_for_file: unused_field

import 'package:demo_project/src/blocs/changestatus_bloc.dart';
import 'package:demo_project/src/blocs/getbooking_bloc.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/models/getBooking_model.dart';
import 'package:demo_project/src/screens/layout/bookings.dart';
import 'package:demo_project/src/screens/layout/ratingService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class BookingDetailScreen extends StatefulWidget {
  Booking data;
  BookingDetailScreen(this.data);

  @override
  State<StatefulWidget> createState() {
    return _BookingDetailScreenState(this.data);
  }
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  bool isLoading = false;
  var rateValue;
  TextEditingController _ratingcontroller = TextEditingController();

  _BookingDetailScreenState(Booking data);

  @override
  void initState() {
    _pullRefresh();
    super.initState();
  }

   Future<void> _pullRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
    });
    // why use freshWords var? https://stackoverflow.com/a/52992836/2301224
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade200,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Booking Detail",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Container(
            // height: //set your height here
            width: double.maxFinite, //set your width here
            decoration: BoxDecoration(
                // color: Colors.grey.shade200,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(20.0))),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: widget.data.status == "Confirm" ||
                              widget.data.status == "Completed" ||
                              widget.data.status == "On Way"
                          ? ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isLoading = true;
                                });

                                widget.data.status == "Completed"
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ReviewService(widget.data)))
                                    : changeStatusBloc
                                        .changeStatusSink(
                                            widget.data.id!, "Cancel")
                                        .then((value) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        if (value.responseCode == "1") {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Booking cancel successfully",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor:
                                                  Colors.grey.shade200,
                                              textColor: Colors.black,
                                              fontSize: 13.0);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BookingList()));
                                          getBookingBloc.getBookingSink(
                                              userID, "Confirm");
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: "Something went wrong",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor:
                                                  Colors.grey.shade200,
                                              textColor: Colors.black,
                                              fontSize: 13.0);
                                          setState(() {
                                            isLoading = false;
                                          });
                                        }
                                      });
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => BookService(
                                //             vid!, resid!, serviceid!, price!)));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Image.asset("assets/images/chat.png",
                                  //     height: 20, width: 20),
                                  // SizedBox(width: 8),
                                  widget.data.status == "Completed"
                                      ? Text("Leave Review")
                                      : Text("Cancel Service"),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: appColorBlack,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 15),
                                  textStyle: TextStyle(fontSize: 17),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )),
                            )
                          : Text('')),
                ],
              ),
            )),
      ),
      body: isLoading ? loader(context) : bodyData(),
    );
  }

  Widget bodyData() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: [
                bookDetailCard(),
                bookcard(),
                datetimecard(),
                pricingcard()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget bookDetailCard() {
    var dateFormate =
        DateFormat("dd/MM/yyyy").format(DateTime.parse(widget.data.date!));
    return Container(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.service!.serviceName!,
                        style: TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.grey.shade600,
                          ),
                          Flexible(
                              child: Text(
                            widget.data.address!,
                            maxLines: 3,
                            style: TextStyle(fontSize: 11.0),
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              color: appColorBlack,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  widget.data.slot!,
                                  style: TextStyle(
                                      color: appColorBlack,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  dateFormate,
                                  style: TextStyle(
                                      color: appColorBlack,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget bookcard() {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Booking Detail',
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Divider(),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Status',
                    ),
                    Container(
                      height: 30,
                      width: 80,
                      child: Center(
                        child: Text(
                          widget.data.status!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Divider(),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Payment Status',
                    ),
                    Container(
                      height: 30,
                      width: 80,
                      child: Center(
                        child: Text(
                          widget.data.paymentStatus!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Divider(),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hint',
                    ),
                    Text(
                      widget.data.notes!,
                    ),
                  ],
                )
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget datetimecard() {
    var dateFormate =
        DateFormat("dd, MMMM yyyy").format(DateTime.parse(widget.data.date!));
    return Container(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Booking Date & Time',
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Divider(),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Booking At',
                    ),
                    Text(
                      dateFormate + "\n" + widget.data.slot!,
                    ),
                  ],
                ),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget pricingcard() {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Booking Date & Time',
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Divider(),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Amount',
                    ),
                    Text(
                      "\$ " + widget.data.amount!,
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
