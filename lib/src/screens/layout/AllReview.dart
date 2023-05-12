// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_project/src/blocs/servicedetail_bloc.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/global/sizeconfig.dart';
import 'package:demo_project/src/models/serviceDetail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ServiceReviewScreen extends StatefulWidget {
  String id;
  ServiceReviewScreen(this.id);

  @override
  _ServiceReviewScreenState createState() {
    return _ServiceReviewScreenState(this.id);
  }
}

class _ServiceReviewScreenState extends State<ServiceReviewScreen> {
  String id;
  _ServiceReviewScreenState(this.id);

  bool isLoading = false;
  @override
  void initState() {
    serviceDetailBloc.serviceDetailSink(id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Container(
          //  decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage('assets/images/back.jpg'),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 1,
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              title: Text(
                "Review",
                style: TextStyle(color: appColorBlack),
              ),
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<ServiceDetailModel>(
                  stream: serviceDetailBloc.serviceDetailStream,
                  builder:
                      (context, AsyncSnapshot<ServiceDetailModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    List<Review>? getAllReview = snapshot.data!.review != null
                        ? snapshot.data!.review
                        : (null);
                    return reviewWidget(getAllReview!);

                    // return Text(snapshot.data!.restaurant!.serviceName??'');
                  }),
            ),
          ),
        ));
  }

  Widget reviewWidget(List<Review> model) {
    return model.length > 0
        ? ListView.builder(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            itemCount: model.length,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Card(
                                        elevation: 4.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0)),
                                        child: Container(
                                          height: 45,
                                          width: 45,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(50.0)),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            child: CachedNetworkImage(
                                              imageUrl: model[index]
                                                  .revUserData!
                                                  .profilePic!,
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
                                            RatingBar.builder(
                                              initialRating: double.parse(
                                                  model[index].revStars!),
                                              minRating: 0,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 10,
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
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                      height: 0.8,
                                      color: Colors.grey[300],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ));
            })
        : Center(child: Text("No reviews found."));
  }
}
