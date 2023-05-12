import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/global/sizeconfig.dart';
import 'package:demo_project/src/models/filter_model.dart';
import 'package:demo_project/src/screens/layout/serviceDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilterRes extends StatefulWidget {
  @override
  _DiscoverNewState createState() => _DiscoverNewState();
}

class _DiscoverNewState extends State<FilterRes> {
  var data1;

  @override
  void initState() {
    getSavedInfo();
    super.initState();
  }

  FilterModel? user;

  Future<FilterModel> getSavedInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey("filter")) {
      Map<String, dynamic> userMap =
          jsonDecode(preferences.getString("filter").toString());
      // user = FilterModel.FilterModel.fromJson(userMap);
      user = FilterModel.fromJson(userMap);
      setState(() {
        bodydata(context);
      });
    }

    return user!;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            elevation: 0,
            title: Text("Filter", style: TextStyle(color: appColorBlack)),
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: bodydata(context),
        ),
      ),
    );
  }

  Widget bodydata(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 8),
          user!.servic!.length > 0
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: user!.servic!.length,
                  itemBuilder: (context, int index) {
                    return serviceCard(user!.servic![index]);
                  },
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: Center(
                    child: Text(
                      "Not found any service",
                      style: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }

  Widget serviceCard(Servic data) {
    String? id = data.id;
    //print("id: "+id);
    return InkWell(
      onTap: () {
        // print(id);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ServiceDetailScreen(id!)),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        height: MediaQuery.of(context).size.height * 2.6 / 10,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey.shade200,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(data.serviceName ?? '',
                        style: TextStyle(fontSize: 19)),
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating:
                              double.parse(data.serviceRatings ?? ''),
                          minRating: 1,
                          direction: Axis.horizontal,
                          itemSize: 10,
                          allowHalfRating: false,
                          itemCount: 5,
                          // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        Text(
                          "\ (" + data.reviewCount.toString() + " reviews\)",
                          style: TextStyle(fontSize: 10.0),
                        )
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Price Unit: " + data.priceUnit.toString(),
                          style:
                              TextStyle(fontSize: 11.0, color: appColorBlack),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            "Duration: " + data.duration.toString() + " hour",
                            style: TextStyle(fontSize: 11.0),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      data.serviceDescription ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 17.0,
                        ),
                        Flexible(
                          child: Text(
                            data.storeAddress ?? '',
                            style:
                                TextStyle(color: appColorBlack, fontSize: 13.0),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 05,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("\$" + data.servicePrice.toString(),
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Futura',
                          color: appColorBlack)),
                  // Image.network(data['service_image'],
                  //     height: 100, width: 100),
                  Container(
                    width: 97.0,
                    height: 97.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      //color: Colors.redAccent,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: data.serviceImage!,
                        imageBuilder: (context, imageProvider) => Container(
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
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  appColorBlack),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            Center(child: Text('Image Not Found')),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
