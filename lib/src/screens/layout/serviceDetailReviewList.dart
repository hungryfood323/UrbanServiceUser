// ignore: avoid_web_libraries_in_flutter

import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_project/src/blocs/servicedetail_bloc.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/models/serviceDetail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: must_be_immutable
class ServiceDetailReview extends StatefulWidget {
  String? id;
  ServiceDetailReview({Key? key, this.id}) : super(key: key);

  @override
  State<ServiceDetailReview> createState() => _ServiceDetailReviewState();
}

class _ServiceDetailReviewState extends State<ServiceDetailReview> {
  @override
  void initState() {
    serviceDetailBloc.serviceDetailSink(widget.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
         backgroundColor: Colors.white,
         automaticallyImplyLeading: true,
         iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Reviews",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<ServiceDetailModel>(
          stream: serviceDetailBloc.serviceDetailStream,
          builder: (context, AsyncSnapshot<ServiceDetailModel> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                color: appColorBlack,
              ));
            }

            List<Review>? getAllReview =
                snapshot.data!.review != null ? snapshot.data!.review : (null);

            return bodyData(getAllReview!);

            // return Text(snapshot.data!.restaurant!.serviceName??'');
          }),
    );
  }

  Widget bodyData(List<Review> review) {
      return  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: reviewWidget(review),
        );
  }

  Widget reviewWidget(List<Review> model) {
    return model.length > 0
        ? SingleChildScrollView(
            child: ListView.builder(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: model.length > 5 ? 5 : model.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return model[index].revUserData == null
                      ? Container()
                      : InkWell(
                          onTap: () {},
                          child: Center(
                            child: Container(
                              child: SizedBox(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Card(
                                            elevation: 4.0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(0)),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              // decoration: BoxDecoration(
                                              //     color: Colors.grey[200],
                                              //     borderRadius:
                                              //         BorderRadius.circular(0.0)),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(0.0),
                                                child: CachedNetworkImage(
                                                  imageUrl: model[index]
                                                      .revUserData!
                                                      .profilePic!,
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  placeholder: (context, url) =>
                                                      Center(
                                                    child: Container(
                                                      height: 20,
                                                      width: 20,
                                                      child:
                                                          CircularProgressIndicator(
                                                        strokeWidth: 2.0,
                                                        valueColor:
                                                            new AlwaysStoppedAnimation<
                                                                    Color>(
                                                                appColorBlack),
                                                      ),
                                                    ),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(width: 10.0),
                                          Flexible(
                                            fit: FlexFit.loose,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(height: 10.0),
                                                Text(
                                                  model[index]
                                                      .revUserData!
                                                      .username!,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),

                                                Container(height: 5),
                                                Text(
                                                  model[index].revText!,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    // fontWeight: FontWeight.w700,
                                                  ),
                                                  maxLines: 3,
                                                  overflow: TextOverflow.clip,
                                                ),
                                                // Text(
                                                //   dateformate,
                                                //   style: TextStyle(fontSize: 12),
                                                // ),
                                              ],
                                            ),
                                          ),
                                          RatingBar.builder(
                                            initialRating: double.parse(
                                                model[index].revStars!),
                                            minRating: 0,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 15,
                                            ignoreGestures: true,
                                            unratedColor: Colors.grey,
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                        ],
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(top: 10),
                                      //   child: Container(
                                      //     height: 0.8,
                                      //     color: Colors.grey[300],
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ));
                }),
          )
        : Text("No reviews found.");
  }
}
