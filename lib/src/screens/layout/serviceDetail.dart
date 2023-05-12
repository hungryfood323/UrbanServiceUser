// ignore_for_file: unused_field, unrelated_type_equality_checks

import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_project/src/blocs/servicedetail_bloc.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/global/sizeconfig.dart';
import 'package:demo_project/src/models/serviceDetail_model.dart';

import 'package:demo_project/src/screens/layout/bookService.dart';
import 'package:demo_project/src/screens/layout/new_store_detail/storeDeail2.dart';
import 'package:demo_project/src/screens/layout/serviceDetailReviewList.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';

import 'package:readmore/readmore.dart';

// ignore: must_be_immutable
class ServiceDetailScreen extends StatefulWidget {
  String id;
  ServiceDetailScreen(this.id);
  @override
  State<StatefulWidget> createState() {
    return _ServiceDetailScreenState(this.id);
  }
  // @override
  // _ServiceDetailScreenState createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  String id;
  _ServiceDetailScreenState(this.id);

  // var json;

  String? vid;
  String? resid;
  String? serviceid;
  String? price;
  String? reviewCount;
  String? orientation;

  var selectImg = "";
  var rateValue = 0;
  TextEditingController _ratingcontroller = TextEditingController();

  @override
  void initState() {
    print(id);
    _pullRefresh();
    super.initState();
  }

  Future<void> _pullRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      serviceDetailBloc.serviceDetailSink(id);
    });
    // why use freshWords var? https://stackoverflow.com/a/52992836/2301224
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Service Detail",
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
                borderRadius: BorderRadius.circular(20.0)),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // print(vid);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookService(
                                    vid!, resid!, serviceid!, price!)));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Image.asset("assets/images/chat.png",
                          //     height: 20, width: 20),
                          // SizedBox(width: 8),
                          Text("Book this Service"),
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
                    ),
                  ),
                ],
              ),
            )),
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
            Restaurant? getServiceDeatil = snapshot.data!.restaurant != null
                ? snapshot.data!.restaurant
                : (null);

            List<Review>? getAllReview =
                snapshot.data!.review != null ? snapshot.data!.review : (null);

            resid = snapshot.data!.restaurant!.resId;
            serviceid = snapshot.data!.restaurant!.id;
            vid = snapshot.data!.restaurant!.vId;
            price = snapshot.data!.restaurant!.servicePrice!;
            reviewCount = snapshot.data!.review!.length.toString();

            print(">>>>>>>>>>>>>" + resid!);
            print(">>>>>>>>>>>>>" + serviceid!);
            print(">>>>>>>>>>>>>" + vid!);
            print(">>>>>>>>>>>>>" + price!);

            return bodyData(getServiceDeatil!, getAllReview!);

            // return Text(snapshot.data!.restaurant!.serviceName??'');
          }),
    );
  }

  Widget bodyData(Restaurant data, List<Review> review) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            height: SizeConfig.blockSizeVertical! * 30,
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  
                    image: NetworkImage(
                  selectImg != '' ? selectImg : data.serviceImage![0],
                  //     loadingBuilder: (context, child, loadingProgress) {
                  //   if (loadingProgress == null) return child;
                  //   return Center(child: CupertinoActivityIndicator());
                  // }
                )))),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  data.serviceName!,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text("\$" + data.servicePrice! + "/h",
                  style: TextStyle(
                    color: appColorBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
            ],
          ),
        ),
        data.serviceRatings! != ''
            ? Padding(
                padding: const EdgeInsets.only(top: 5, left: 16),
                child: Row(
                  children: [
                    RatingBar.builder(
                      initialRating: double.parse(data.serviceRatings!),
                      minRating: 0,
                      direction: Axis.horizontal,
                      itemSize: 15,
                      ignoreGestures: true,
                      allowHalfRating: true,
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
                    SizedBox(width: 1),
                    Container(
                      margin: EdgeInsets.only(left: 2.0),
                      height: 20.0,
                      width: 30.0,
                      // decoration: BoxDecoration(
                      //   color: Colors.grey.shade200,
                      //   borderRadius: BorderRadius.circular(6.0),
                      // ),
                      child: Center(
                        child: Text(
                          data.serviceRatings!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(),

        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Duration : ',style: TextStyle(color: Colors.grey),),
              Icon(
                Icons.watch_later_outlined,
                color: Colors.grey,
                size: 15,
              ),
              SizedBox(
                width: 3,
              ),
              Text(
               data.duration.toString() + " hour",
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            children: [
              Image.asset(
                'assets/images/MapPin_Outlined.png',
                height: 20,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                data.storeAddress!,
                maxLines: 2,
                // overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 40),
          child: ReadMoreText(
            data.serviceDescription!,
            trimLines: 2,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Read more',
            trimExpandedText: 'Read less',
            colorClickableText: appColorBlack,
            lessStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: appColorBlack,
              decoration: TextDecoration.underline,
            ),
            moreStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: appColorBlack,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Image.asset(
                "assets/images/storeicon.png",
                height: 20,
                width: 20,
              ),
              SizedBox(width: 10),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: data.storeName,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                    // children: [
                    //   TextSpan(
                    //     text: "\n"+json['restaurant']['store_name'],
                    //     style: TextStyle(color: Colors.black, fontSize: 15),
                    //   )
                    // ],
                  ),
                ),
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                NewStoreDetailScreen(data.resId)));
                  },
                  child: Text(
                    "View More",
                    style: TextStyle(color: Colors.blue),
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),

        Padding(
          padding: const EdgeInsets.only(right: 15, left: 15, bottom: 10),
          child: Container(
            height: SizeConfig.blockSizeVertical! * 25,
            width: SizeConfig.screenWidth,
            margin: EdgeInsets.symmetric(horizontal: 6),
            child: ClipRRect(
              child: Row(children: [
                data.serviceImage!.length > 0
                    ? Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => ViewPublicPost(
                            //           id: postModal.follower[0].postId)),
                            // );
                          },
                          child: Container(
                            child: CachedNetworkImage(
                              imageUrl: data.serviceImage![0].toString(),
                              imageBuilder: (context, imageProvider) =>
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
                                    // height: 40,
                                    // width: 40,
                                    child: CircularProgressIndicator()),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                data.serviceImage!.length > 0
                    ? SizedBox(width: 2)
                    : Container(),
                Expanded(
                    child: Column(children: [
                  data.serviceImage!.length > 1
                      ? Expanded(
                          child: InkWell(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => ViewPublicPost(
                              //           id: postModal.follower[1].postId)),
                              // );
                            },
                            child: CachedNetworkImage(
                              imageUrl: data.serviceImage![1].toString(),
                              imageBuilder: (context, imageProvider) =>
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
                                    // height: 40,
                                    // width: 40,
                                    child: CircularProgressIndicator()),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Container(),
                  data.serviceImage!.length > 1
                      ? SizedBox(height: 2)
                      : Container(),
                  data.serviceImage!.length > 2
                      ? Expanded(
                          child: InkWell(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => ViewPublicPost(
                              //           id: postModal.follower[2].postId)),
                              // );
                            },
                            child: CachedNetworkImage(
                              imageUrl: data.serviceImage![2].toString(),
                              imageBuilder: (context, imageProvider) =>
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
                                    // height: 40,
                                    // width: 40,
                                    child: CircularProgressIndicator()),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Container()
                ]))
              ]),
            ),
          ),
        ),

        // data.serviceImage!.length > 0
        //     ? SizedBox(
        //          height: 200,
        //         width: MediaQuery.of(context).size.width,
        //         child: StaggeredGridView.countBuilder(
        //             crossAxisCount: 3,
        //             itemCount: data.serviceImage!.length > 3
        //                 ? 3
        //                 : data.serviceImage!.length,
        //             shrinkWrap: true,
        //             scrollDirection: Axis.horizontal,
        //             physics: NeverScrollableScrollPhysics(),
        //             staggeredTileBuilder: (int index) =>
        //                 StaggeredTile.count(2, index.isEven ? 2 : 1),
        //             mainAxisSpacing: 4.0,
        //             crossAxisSpacing: 4.0,
        //             itemBuilder: (BuildContext context, int index) {
        //               return recentDetails(data.serviceImage![index]);
        //             }),
        //       )
        //     : Center(
        //         child: Text(
        //           "No result found!",
        //           style: TextStyle(
        //             color: Colors.black,
        //             fontStyle: FontStyle.normal,
        //           ),
        //         ),
        //       ),

        // GridView.count(
        //     crossAxisCount: 3,
        //     crossAxisSpacing: 10,
        //     mainAxisSpacing: 10,
        //     children: List.generate(5, (index) {
        //       return Container(
        //           height: SizeConfig.blockSizeVertical! * 30,
        //           width: MediaQuery.of(context).size.width,
        //           decoration: BoxDecoration(
        //               image: DecorationImage(
        //                   image: NetworkImage(
        //             selectImg != '' ? selectImg : data.serviceImage![0],
        //             //     loadingBuilder: (context, child, loadingProgress) {
        //             //   if (loadingProgress == null) return child;
        //             //   return Center(child: CupertinoActivityIndicator());
        //             // }
        //           ))));
        //     })),
        // Container(
        //     height: SizeConfig.blockSizeVertical! * 30,
        //     width: MediaQuery.of(context).size.width,
        //     decoration: BoxDecoration(
        //         image: DecorationImage(
        //             image: NetworkImage(
        //       selectImg != '' ? selectImg : data.serviceImage![0],
        //       //     loadingBuilder: (context, child, loadingProgress) {
        //       //   if (loadingProgress == null) return child;
        //       //   return Center(child: CupertinoActivityIndicator());
        //       // }
        //     )))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rating',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                  onPressed: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ServiceDetailReview(id: data.id,)));
                  }),
                  child: Text(
                    'View More',
                    style: TextStyle(color: Colors.blue),
                  )),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: reviewWidget(review),
        )

        // Column(
        //   children: [
        //     Row(
        //       children: [
        //         SizedBox(width: 15),
        //         Container(
        //           width: 50,
        //           height: 50,
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.all(Radius.circular(0)),
        //             //color: Colors.redAccent,
        //           ),
        //           child: ClipRRect(
        //             borderRadius: BorderRadius.circular(10),
        //             child: CachedNetworkImage(
        //               imageUrl: data.vId!,
        //               imageBuilder: (context, imageProvider) => Container(
        //                 decoration: BoxDecoration(
        //                   image: DecorationImage(
        //                     image: imageProvider,
        //                     fit: BoxFit.cover,
        //                   ),
        //                 ),
        //               ),
        //               placeholder: (context, url) => Center(
        //                 child: Container(
        //                   height: 20,
        //                   width: 20,
        //                   child: CircularProgressIndicator(
        //                     strokeWidth: 2.0,
        //                     valueColor: new AlwaysStoppedAnimation<Color>(
        //                         appColorBlack),
        //                   ),
        //                 ),
        //               ),
        //               errorWidget: (context, url, error) =>
        //                   Center(child: Image.asset('assets/images/unknown.png')),
        //               fit: BoxFit.cover,
        //             ),
        //           ),
        //         ),
        //         SizedBox(
        //           width: 15,
        //         ),
        //         Expanded(
        //             child: Column(
        //           children: [Text(data.vendorName!),
        //           SizedBox(height: 3,),
        //           Text(data.vendorName!,
        //           overflow: TextOverflow.ellipsis,
        //           )],
        //         )),
        //         SizedBox(width: 30),
        //         data.serviceRatings! != ''
        //     ? Padding(
        //         padding: const EdgeInsets.only(top: 5, left: 20),
        //         child: Row(
        //           children: [
        //             RatingBar.builder(
        //               minRating: 1,
        //               direction: Axis.horizontal,
        //               itemSize: 20,
        //               ignoreGestures: true,
        //               allowHalfRating: true,
        //               itemCount: 5,

        //               // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        //               itemBuilder: (context, _) => Icon(
        //                 Icons.star,
        //                 color: Colors.amber,
        //               ),
        //               onRatingUpdate: (rating) {
        //                 print(rating);
        //               },
        //             ),
        //             SizedBox(width: 1),
        //             Container(
        //               margin: EdgeInsets.only(left: 2.0),
        //               height: 20.0,
        //               width: 30.0,
        //               // decoration: BoxDecoration(
        //               //   color: Colors.grey.shade200,
        //               //   borderRadius: BorderRadius.circular(6.0),
        //               // ),
        //               child: Center(
        //                 child: Text(
        //                   data.serviceRatings!,
        //                   style: TextStyle(
        //                       fontWeight: FontWeight.bold, fontSize: 10),
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       )
        //     : Container(),

        //       ],
        //     ),
        //   ],
        // )
      ]),
    );
  }

  Widget recentDetails(data) {
    return Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(3),
          child: GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) =>
                //           ViewPublicPost(id: document.postId)),
                // );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: CachedNetworkImage(
                  placeholder: (context, url) => Container(
                    child: CupertinoActivityIndicator(),
                    width: 35.0,
                    height: 35.0,
                    padding: EdgeInsets.all(10.0),
                  ),
                  errorWidget: (context, url, error) => Material(
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.grey,
                      ),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    clipBehavior: Clip.hardEdge,
                  ),
                  imageUrl: data,
                  width: 35.0,
                  height: 35.0,
                  fit: BoxFit.cover,
                ),
              )),
        ));
  }

  Widget reviewWidget(List<Review> model) {
    return model.length > 0
        ? ListView.builder(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
            })
        : Text("No reviews found.");
  }
}
