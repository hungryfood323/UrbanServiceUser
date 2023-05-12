import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_project/src/blocs/getbooking_bloc.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/models/getBooking_model.dart';
import 'package:demo_project/src/screens/layout/BookingDeatil.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingList extends StatefulWidget {
  @override
  BookingListState createState() => BookingListState();
}

class BookingListState extends State<BookingList> {
  // BookingProvider provider;
  String activeValue = "Confirm";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getBookingBloc.getBookingSink(userID, activeValue.toString());
  }

  Future<void> _pullRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      getBookingBloc.getBookingSink(userID, activeValue.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text("Bookings",
            style:
                TextStyle(color: appColorBlack, fontWeight: FontWeight.w600)),
        elevation: 0,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        color: appColorBlack,
        child: Column(
          children: [
            Container(
              height: 60,
              color: Colors.grey.shade200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                children: [
                  InkWell(
                    onTap: () {
                      print("Confirm");
                      // provider.GetBookings(orderstatus: "Confirm");
                      getBookingBloc.getBookingSink(userID, "Confirm");
                      setState(() {
                        activeValue = "Confirm";
                      });
                    },
                    child: Container(
                      width: 100,
                      alignment: Alignment.center,
                      child: Text("Confirm",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: activeValue == "Confirm"
                                  ? Colors.white
                                  : Colors.black)),
                      margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                      decoration: BoxDecoration(
                        color: activeValue == "Confirm"
                            ? appColorBlack
                            : Colors.white,
                        border: Border.all(
                            color: activeValue == "Confirm"
                                ? Colors.white
                                : Colors.black),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("On Way");
                      // provider.GetBookings(orderstatus: "Completed");
                      getBookingBloc.getBookingSink(userID, "On Way");
                      setState(() {
                        activeValue = "On Way";
                      });
                    },
                    child: Container(
                      width: 100,
                      alignment: Alignment.center,
                      child: Text("On Way",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: activeValue == "On Way"
                                  ? Colors.white
                                  : appColorBlack)),
                      margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                      decoration: BoxDecoration(
                          color: activeValue == "On Way"
                              ? appColorBlack
                              : Colors.white,
                          border: Border.all(
                              color: activeValue == "On Way"
                                  ? Colors.white
                                  : Colors.black),
                          borderRadius: BorderRadius.circular(6)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("Cancel");
                      // provider.GetBookings(orderstatus: "Cancel");
                      getBookingBloc.getBookingSink(userID, "Cancel");
                      setState(() {
                        activeValue = "Cancel";
                      });
                    },
                    child: Container(
                      width: 100,
                      alignment: Alignment.center,
                      child: Text("Cancelled",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: activeValue == "Cancel"
                                  ? Colors.white
                                  : appColorBlack)),
                      margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                      decoration: BoxDecoration(
                          color: activeValue == "Cancel"
                              ? appColorBlack
                              : Colors.white,
                          border: Border.all(
                              color: activeValue == "Cancel"
                                  ? Colors.white
                                  : Colors.black),
                          borderRadius: BorderRadius.circular(6)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("Completed");
                      // provider.GetBookings(orderstatus: "Completed");
                      getBookingBloc.getBookingSink(userID, "Completed");
                      setState(() {
                        activeValue = "Completed";
                      });
                    },
                    child: Container(
                      width: 100,
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      alignment: Alignment.center,
                      child: Text("Completed",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: activeValue == "Completed"
                                  ? Colors.white
                                  : appColorBlack)),
                      decoration: BoxDecoration(
                          color: activeValue == "Completed"
                              ? appColorBlack
                              : Colors.white,
                          border: Border.all(
                              color: activeValue == "Completed"
                                  ? Colors.white
                                  : Colors.black),
                          borderRadius: BorderRadius.circular(6)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<GetBookingModel>(
                  stream: getBookingBloc.getBookingStream,
                  builder: (context, AsyncSnapshot<GetBookingModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: appColorBlack,
                        ),
                      );
                    }
                    List<Booking>? allBooking = snapshot.data!.booking != null
                        ? snapshot.data!.booking
                        : [];
                    return allBooking!.length > 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            // physics: NeverScrollableScrollPhysics(),
                            itemCount: allBooking.length,
                            itemBuilder: (context, int index) {
                              return bookCard(allBooking[index]);
                            },
                          )
                        : Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 200,
                                width: 200,
                                child: Image.asset(
                                  "assets/images/nobooking.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Text(
                                "Don't have any bookings",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ));
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget bookCard(Booking data) {
    var dateFormate =
        DateFormat("dd/MM/yyyy").format(DateTime.parse(data.date!));
    return Container(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Card(
          elevation: 1.0,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.service!.serviceName!,
                          style: TextStyle(
                              color: blackcolor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined),
                          SizedBox(width: 6),
                          Flexible(
                            child: Text(data.address!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: blackcolor,
                                    fontWeight: FontWeight.normal)),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.date_range_outlined),
                          SizedBox(width: 4),
                          Text(dateFormate + " , " + data.slot!,
                              style: TextStyle(
                                  color: blackcolor,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Row(
                          children: [
                            Text("Pending Amount : " + "\$ " + data.amount!,
                                style: TextStyle(
                                    color: appColorBlack,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14)),
                          ],
                        ),
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
                                // color: Colors.redAccent,
                              ),
                              child: data.service!.serviceImage != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            data.service!.serviceImage![0],
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) => Center(
                                          child: Container(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.0,
                                              valueColor:
                                                  new AlwaysStoppedAnimation<
                                                      Color>(appColorBlack),
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Center(
                                                child: Text('Image Not Found')),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Container()),
                          SizedBox(height: 5),
                          InkWell(
                            onTap: () {
                              // print(data);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BookingDetailScreen(data)));
                            },
                            child: Container(
                              width: 80.0,
                              height: MediaQuery.of(context).size.height / 25,
                              alignment: Alignment.center,
                              child: Center(
                                  child: Text("More Info",
                                      style: TextStyle(
                                          color: WhiteColor, fontSize: 10))),
                              margin: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: appColorBlack,
                                border: Border.all(color: appColorBlack),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
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
}
