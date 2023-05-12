import 'dart:convert';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/global/sizeconfig.dart';
import 'package:demo_project/src/models/bookingNotification_modal.dart';
import 'package:demo_project/src/models/notification_modal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeago/timeago.dart';

// ignore: must_be_immutable
class NotificationList extends StatefulWidget {
  @override
  _NotificationListState createState() => new _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  NotificationModal? modal;
  BookingNotificationModal? bookingNotificationModal;

  @override
  void initState() {
    _getData();
    _getData2();
    super.initState();
  }

  _getData() async {
    var uri = Uri.parse('${baseUrl()}order_notification_listing');
    var request = new http.MultipartRequest("Post", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    request.fields.addAll({'user_id': userID});
    request.fields['user_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    if (mounted) {
      setState(() {
        modal = NotificationModal.fromJson(userData);
      });
    }
  }

  _getData2() async {
    var uri = Uri.parse('${baseUrl()}booking_notification_listing');
    var request = new http.MultipartRequest("Post", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    request.fields.addAll({'user_id': userID});
    request.fields['user_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    if (mounted) {
      setState(() {
        bookingNotificationModal = BookingNotificationModal.fromJson(userData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      decoration: new BoxDecoration(),
      child: Scaffold(
        backgroundColor: appColorWhite,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          title: Text(
            'Notification',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Container(height: 15),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: DefaultTabController(
                  length: 2,
                  initialIndex: 0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 250,
                        height: 40,
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[300]),
                        child: Center(
                          child: TabBar(
                            labelColor: appColorWhite,
                            unselectedLabelColor: appColorBlack,
                            labelStyle: TextStyle(
                                fontSize: 13.0,
                                color: appColorWhite,
                                fontWeight: FontWeight.bold),
                            unselectedLabelStyle: TextStyle(
                                fontSize: 13.0,
                                color: appColorBlack,
                                fontWeight: FontWeight.bold),
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: appColorBlack),
                            tabs: <Widget>[
                              Tab(
                                text: 'Booking',
                              ),
                              Tab(
                                text: 'Product',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: <Widget>[bookingWidget(),orderWidget()],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget orderWidget() {
    return modal == null
        ? Align(
            alignment: Alignment.center,
            child: Container(
                height: 20,
                width: 20,
                child: Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
                ))),
          )
        : modal!.responseCode == '1'
            ? Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: ListView.builder(
                    shrinkWrap: true,
                    //physics: NeverScrollableScrollPhysics(),
                    itemCount: modal!.notifications!.length,
                    itemBuilder: (context, index) => dataWidget(index)),
              )
            : Container(
                height: SizeConfig.screenHeight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        child: Image.asset(
                          "assets/images/emptyNotification.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        'Notification list is empty',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
                ),
              );
  }

  Widget dataWidget(int index) {
    return Column(
      children: [
        Container(
          child: Material(
            elevation: 0,
            borderRadius: BorderRadius.circular(5.0),
            child: InkWell(
              splashColor: Colors.grey[200],
              focusColor: Colors.grey[200],
              highlightColor: Colors.grey[200],
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => ViewNotification(
                //           products: modal.notifications[index].products)),
                // );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: index % 3 == 0
                              ? Color(0xFFE9E4B2)
                              : index % 3 == 1
                                  ? Color(0xFFEBBFA1)
                                  : Color(0xFFC6D3EF),
                          shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: modal!.notifications![index].title ==
                                "Order Placed"
                            ? Image.asset(
                                "assets/images/orderPlaced.png",
                              )
                            : modal!.notifications![index].title ==
                                    "Order Dispatch"
                                ? Image.asset(
                                    "assets/images/order Dispatch.png",
                                    height: 20)
                                : modal!.notifications![index].title ==
                                        "Order Deliver"
                                    ? Image.asset(
                                        "assets/images/orderDeliver.png",
                                        height: 20)
                                    : modal!.notifications![index].title ==
                                            "Order Cancel"
                                        ? Image.asset(
                                            "assets/images/orderCancel.png",
                                            height: 20)
                                        : Icon(
                                            FontAwesomeIcons.truckMonster,
                                            size: 20,
                                            color:
                                                Colors.black.withOpacity(0.2),
                                          ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Flexible(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(modal!.notifications![index].message!,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: appColorBlack,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'OderId: ${modal!.notifications![index].dataId}',
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  format(DateTime.parse(
                                      modal!.notifications![index].date!)),
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Divider(color: Colors.black45, thickness: 0.3)
      ],
    );
  }

  Widget bookingWidget() {
    return bookingNotificationModal == null
        ? Align(
            alignment: Alignment.center,
            child: Container(
                height: 20,
                width: 20,
                child: Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
                ))),
          )
        : bookingNotificationModal!.responseCode == '1'
            ? Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: ListView.builder(
                    shrinkWrap: true,
                    //physics: NeverScrollableScrollPhysics(),
                    itemCount: bookingNotificationModal!.notifications!.length,
                    itemBuilder: (context, index) => bookingItemWidget(index)),
              )
            : Container(
                height: SizeConfig.screenHeight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        child: Image.asset(
                          "assets/images/emptyNotification.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        'Notification list is empty',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
                ),
              );
  }

  Widget bookingItemWidget(int index) {
    return Column(
      children: [
        Container(
          child: Material(
            elevation: 0,
            borderRadius: BorderRadius.circular(5.0),
            child: InkWell(
              splashColor: Colors.grey[200],
              focusColor: Colors.grey[200],
              highlightColor: Colors.grey[200],
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => ViewBookingNotification(
                //           booking: bookingNotificationModal!.notifications![index].booking!)),
                // );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: index % 3 == 0
                              ? Color(0xFFE9E4B2)
                              : index % 3 == 1
                                  ? Color(0xFFEBBFA1)
                                  : Color(0xFFC6D3EF),
                          shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: bookingNotificationModal!
                                    .notifications![index].title ==
                                "Booking Confirm"
                            ? Image.asset(
                                "assets/images/orderPlaced.png",
                              )
                            : bookingNotificationModal!
                                        .notifications![index].title ==
                                    "Booking On Way"
                                ? Image.asset(
                                    "assets/images/order Dispatch.png",
                                    height: 20)
                                : bookingNotificationModal!
                                            .notifications![index].title ==
                                        "Booking Completed"
                                    ? Image.asset(
                                        "assets/images/orderDeliver.png",
                                        height: 20)
                                    : bookingNotificationModal!
                                                .notifications![index].title ==
                                            "Booking Cancel"
                                        ? Image.asset(
                                            "assets/images/orderCancel.png",
                                            height: 20)
                                        : Icon(
                                            FontAwesomeIcons.truckMonster,
                                            size: 20,
                                            color:
                                                Colors.black.withOpacity(0.2),
                                          ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Flexible(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                    bookingNotificationModal!
                                        .notifications![index].message!,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: appColorBlack,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  bookingNotificationModal!.notifications![index].booking![0].serviceName!,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  format(DateTime.parse(
                                      bookingNotificationModal!
                                          .notifications![index].date!)),
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Divider(color: Colors.black45, thickness: 0.3)
      ],
    );
  }
}
