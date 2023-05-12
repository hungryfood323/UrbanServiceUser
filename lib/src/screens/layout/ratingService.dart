// ignore_for_file: unnecessary_null_comparison
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:demo_project/src/blocs/servicerating_bloc.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/global/sizeconfig.dart';
import 'package:demo_project/src/models/getBooking_model.dart';
import 'package:demo_project/src/screens/layout/multihome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class ReviewService extends StatefulWidget {
  Booking data;
  ReviewService(this.data);

  @override
  State<StatefulWidget> createState() {
    return _ReviewEzState(this.data);
  }
}

class _ReviewEzState extends State<ReviewService> {
  final _reviewController = TextEditingController();
  double? rateValue;
  bool isLoading = false;

  _ReviewEzState(Booking data);
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // profileBloc.profileSink(userID);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: _designProfile(context),
      ),
    );
  }

  Widget _designProfile(BuildContext context) {
    return Container(
      // color: Colors.black,
      child: Container(
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                _userDetailContainer(context),
                _poster2(context),
                //like(context),
                _customAppbar(),
              ],
            ),

            // _userImage(),
          ],
        ),
      ),
    );
  }

  Widget _customAppbar() {
    return Container(
      color: Colors.white.withOpacity(0.20),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(Icons.arrow_back_ios, color: Colors.black),
                )),
          ),
        ],
      ),
    );
  }

  Widget _userDetailContainer(BuildContext context) {
    return Align(
      // alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 320.0,
                left: 20.0,
                right: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  nameandlike(context),
                  widgetText(),
                  SizedBox(height: 20),
                  ratingbar(),
                  SizedBox(height: 20),
                  textReview(),
                  Container(height: 20),
                  addYourReview(),
                  Container(
                    height: 25,
                  ),
                  //reviewWidget(widget.),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textReview() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: ReviewtextField(
        controller: _reviewController,
        textInputAction: TextInputAction.done,
        maxLines: 4,
        hintText: 'Write your review...',
      ),
    );
  }

  Widget ratingbar() {
    return Center(
      child: Container(
        child: RatingBar.builder(
          initialRating: widget.data.service!.serviceRatings != null &&
                  widget.data.service!.serviceRatings!.length > 0
              ? double.parse(widget.data.service!.serviceRatings!)
              : 0.0,
          minRating: 0,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 40,
          unratedColor: Colors.grey,
          itemBuilder: (context, _) => Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: Icon(Icons.star, color: Colors.orange)),
          onRatingUpdate: (rating) {
            print(rating);
            setState(() {
              rateValue = rating;
            });
          },
        ),
      ),
    );
  }

  Widget _poster2(BuildContext context) {
    Widget carousel = widget.data.service!.serviceImage! == null
        ? Center(
            child: SpinKitCubeGrid(
              color: Colors.white,
            ),
          )
        : Stack(
            children: <Widget>[
              Carousel(
                images: widget.data.service!.serviceImage!.map((it) {
                  return ClipRRect(
                    // borderRadius: new BorderRadius.only(
                    //   bottomLeft: const Radius.circular(40.0),
                    //   bottomRight: const Radius.circular(40.0),
                    // ),
                    child: Container(
                      child: CachedNetworkImage(
                        imageUrl: it,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            // borderRadius: new BorderRadius.only(
                            //   bottomLeft: const Radius.circular(40.0),
                            //   bottomRight: const Radius.circular(40.0),
                            // ),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Center(
                          child: Container(
                            height: 100,
                            width: 100,
                            // margin: EdgeInsets.all(70.0),
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  appColorBlack),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
                showIndicator: true,
                dotBgColor: Colors.transparent,
                borderRadius: false,
                autoplay: false,
                dotSize: 5.0,
                dotSpacing: 15.0,
              ),
              // _customAppbar()
            ],
          );

    return SizedBox(
        height: 300, width: SizeConfig.screenWidth, child: carousel);
  }

  Widget widgetText() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'How was your',
                style: TextStyle(
                    letterSpacing: 1,
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'experience with this place?',
                style: TextStyle(
                    letterSpacing: 1,
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget like(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 290, right: 20),
        child: InkWell(
            onTap: () {},
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 55,
                width: 55,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.orange),
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Icon(
                        Icons.favorite,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget nameandlike(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width - 120,
                // color: Colors.red,
                child: Text(
                  widget.data.service!.serviceName!,
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget addYourReview() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          height: 55,
          width: 150,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: appColorBlack,
              onPrimary: Colors.grey,
              onSurface: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          fontSize: 17,
                          fontStyle: FontStyle.normal,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {
              if (_reviewController.text.length > 0 && rateValue != null) {
                addReviewApiCall();
              } else {
                // Toast.show("Write Review or Select Rating ", context,
                //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                Fluttertoast.showToast(
                    msg: "Write Review or Select Rating",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey.shade200,
                    textColor: Colors.black,
                    fontSize: 13.0);
              }
            },
          ),
        ),
      ),
    );
  }

  // Widget reviewWidget(List<Review> model) {
  //   return ListView.builder(
  //       shrinkWrap: true,
  //       itemCount: model.length,
  //       physics: const NeverScrollableScrollPhysics(),
  //       itemBuilder: (BuildContext context, int index) {
  //         return model[index].revUserData == null
  //             ? Container()
  //             : InkWell(
  //                 onTap: () {},
  //                 child: Center(
  //                   child: Container(
  //                     child: SizedBox(
  //                       child: Container(
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: <Widget>[
  //                             Row(
  //                               mainAxisAlignment: MainAxisAlignment.start,
  //                               children: <Widget>[
  //                                 Card(
  //                                   elevation: 4.0,
  //                                   shape: RoundedRectangleBorder(
  //                                       borderRadius:
  //                                           BorderRadius.circular(50.0)),
  //                                   child: Container(
  //                                     height: 50,
  //                                     width: 50,
  //                                     decoration: BoxDecoration(
  //                                         color: Colors.grey[200],
  //                                         borderRadius:
  //                                             BorderRadius.circular(50.0)),
  //                                     child: ClipRRect(
  //                                       borderRadius:
  //                                           BorderRadius.circular(50.0),
  //                                       child: CachedNetworkImage(
  //                                         imageUrl: model[index]
  //                                             .revUserData
  //                                             .profilePic,
  //                                         imageBuilder:
  //                                             (context, imageProvider) =>
  //                                                 Container(
  //                                           decoration: BoxDecoration(
  //                                             image: DecorationImage(
  //                                               image: imageProvider,
  //                                               fit: BoxFit.cover,
  //                                             ),
  //                                           ),
  //                                         ),
  //                                         placeholder: (context, url) => Center(
  //                                           child: Container(
  //                                             height: 20,
  //                                             width: 20,
  //                                             child: CircularProgressIndicator(
  //                                               strokeWidth: 2.0,
  //                                               valueColor:
  //                                                   new AlwaysStoppedAnimation<
  //                                                       Color>(appColorBlack),
  //                                             ),
  //                                           ),
  //                                         ),
  //                                         errorWidget: (context, url, error) =>
  //                                             Icon(Icons.error),
  //                                         fit: BoxFit.cover,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 Container(width: 10.0),
  //                                 Flexible(
  //                                   fit: FlexFit.loose,
  //                                   child: Column(
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     children: <Widget>[
  //                                       Container(height: 10.0),
  //                                       Text(
  //                                         model[index].revUserData.username,
  //                                         style: TextStyle(
  //                                           color: Colors.black,
  //                                           fontWeight: FontWeight.w700,
  //                                         ),
  //                                       ),
  //                                       Container(height: 5),
  //                                       RatingBar.builder(
  //                                         initialRating: double.parse(
  //                                             model[index].revStars),
  //                                         minRating: 0,
  //                                         direction: Axis.horizontal,
  //                                         allowHalfRating: true,
  //                                         itemCount: 5,
  //                                         itemSize: 15,
  //                                         ignoreGestures: true,
  //                                         unratedColor: Colors.grey,
  //                                         itemBuilder: (context, _) => Icon(
  //                                           Icons.star,
  //                                           color: Colors.orange,
  //                                         ),
  //                                         onRatingUpdate: (rating) {
  //                                           print(rating);
  //                                         },
  //                                       ),
  //                                       Container(height: 5),
  //                                       Text(
  //                                         model[index].revText,
  //                                         style: TextStyle(
  //                                           color: Colors.black,
  //                                           fontWeight: FontWeight.w700,
  //                                         ),
  //                                         maxLines: 3,
  //                                         overflow: TextOverflow.clip,
  //                                       ),
  //                                       // Text(
  //                                       //   dateformate,
  //                                       //   style: TextStyle(fontSize: 12),
  //                                       // ),
  //                                     ],
  //                                   ),
  //                                 )
  //                               ],
  //                             ),
  //                             Padding(
  //                               padding: const EdgeInsets.only(top: 10),
  //                               child: Container(
  //                                 height: 0.8,
  //                                 color: Colors.grey[600],
  //                               ),
  //                             )
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ));
  //       });
  // }

  addReviewApiCall() async {
    try {
      serviceRatingBloc
          .serviceRatingSink(userID, widget.data.serviceId!,
              rateValue.toString(), _reviewController.text)
          .then((value) {
        if (value.status == "1") {
          Fluttertoast.showToast(
              msg: "Your review has been added!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey.shade200,
              textColor: Colors.black,
              fontSize: 13.0);
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => MultiHome(),
            ),
            (Route<dynamic> route) => false,
          );
        } else {
          Fluttertoast.showToast(
              msg: "Something went wrong",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey.shade200,
              textColor: Colors.black,
              fontSize: 13.0);
        }
      });
    } on Exception {
      // Toast.show("No Internet connection", context,
      //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      Fluttertoast.showToast(
          msg: "No Internet connection",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade200,
          textColor: Colors.black,
          fontSize: 13.0);

      throw Exception('No Internet connection');
    }
  }
}
