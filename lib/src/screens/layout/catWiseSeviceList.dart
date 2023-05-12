// ignore_for_file: must_be_immutable

import 'package:demo_project/src/blocs/catservicebloc.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/global/sizeconfig.dart';
import 'package:demo_project/src/models/catService_model.dart';

import 'package:demo_project/src/screens/layout/serviceDetail.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CategoryWiseServiceList extends StatefulWidget {
  String? id;
  CategoryWiseServiceList(this.id);
  @override
  CategoryWiseServiceListState createState() {
    return CategoryWiseServiceListState(this.id!);
  }
}

class CategoryWiseServiceListState extends State<CategoryWiseServiceList> {
  String id;
  CategoryWiseServiceListState(this.id);

  @override
  void initState() {
    catServiceBloc.catServiceSink(id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: Colors.grey.shade200,
        title: Text(
          "Services",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 8),
            Container(
              // height: MediaQuery.of(context).size.height - 200,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder<CategoryServiceModel>(
                  stream: catServiceBloc.catServiceStream,
                  builder:
                      (context, AsyncSnapshot<CategoryServiceModel> snapshot) {
                    if (!snapshot.hasData) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height / 1.5,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    List<Service>? allService = snapshot.data!.service != null
                        ? snapshot.data!.service
                        : [];
                    return allService!.length > 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: allService.length,
                            itemBuilder: (context, int index) {
                              return serviceCard(allService[index]);
                            },
                          )
                        : Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(height: 70),
                              Container(
                                width: double.infinity,
                                child: Image.asset(
                                  "assets/images/noservice.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                "Don't have any Service",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ));
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget serviceCard(Service data) {
    String? id = data.id;
    //print("id: "+id);
    return InkWell(
      onTap: () {
        // print("click");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ServiceDetailScreen(id!)),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        // height: MediaQuery.of(context).size.height * 2.6 / 10,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
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
                          color: appColorBlack)),
                  Container(
                    width: 97.0,
                    height: 97.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(data.serviceImage ?? '')),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      //color: Colors.redAccent,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
