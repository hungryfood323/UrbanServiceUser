import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_project/src/blocs/storedetail_bloc.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/global/sizeconfig.dart';
import 'package:demo_project/src/models/store_model.dart';
import 'package:demo_project/src/provider/storedetail_api.dart';
import 'package:demo_project/src/screens/chat/fireChat.dart';
import 'package:demo_project/src/screens/layout/new_store_detail/storeImages.dart';
import 'package:demo_project/src/screens/layout/serviceListByStore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:readmore/readmore.dart';

// ignore: must_be_immutable
class NewStoreDetailScreen extends StatefulWidget {
  String? id;
  NewStoreDetailScreen(this.id);
  @override
  State<StatefulWidget> createState() {
    return _NewStoreDetailScreenState(this.id);
  }
}

class _NewStoreDetailScreenState extends State<NewStoreDetailScreen> {
  // var json;
  bool isLoading = true;
  var selectImg = '';
  var resid;
  var vid;
  var vname;
  var vprofile;
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String? id;
  _NewStoreDetailScreenState(String? id);

  // getStoreById(id) async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   Uri url = Uri.parse(
  //     "${baseUrl()}get_res_details",
  //   );
  //   var response = await http.post(url, body: {
  //     "res_id": id,
  //   });
  //   if (response.statusCode == 200) {
  //     var output = response.body;
  //     json = jsonDecode(output);
  //     print(json);
  //     // print(json['restaurant']['service_name']);
  //     //print(json['services'][0]["id"]);
  //     setState(() {
  //       isLoading = false;
  //     });
  //     return json;
  //   }
  //   return null;
  // }

  @override
  void initState() {
    _pullRefresh();
    storeDetailBloc.storeDetailSink(widget.id!);
    StoreDetailApi().storeDetailApi(widget.id!).then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
    // getStoreById('114');
  }

  Future<void> _pullRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {});
    // why use freshWords var? https://stackoverflow.com/a/52992836/2301224
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Store Detail',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: isLoading
          ? Container()
          : BottomAppBar(
              elevation: 0,
              child: Container(
                  height: 60,
                  width: double.maxFinite, //set your width here
                  decoration: BoxDecoration(
                      // color: Colors.grey.shade200,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              //  print(resid);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ServiceByStoreList(resid)));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/wrench2.png",
                                    height: 20, width: 20),
                                SizedBox(width: 8),
                                Text(
                                  "Services",
                                  style: TextStyle(color: appColorBlack),
                                ),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 15),
                                textStyle: TextStyle(fontSize: 15),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: appColorBlack, width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                )),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (userID == "0") {
                                // Toast.show("Login to continue", context,
                                //     duration: Toast.LENGTH_SHORT,
                                //     gravity: Toast.BOTTOM);
                                Fluttertoast.showToast(
                                    msg: "Login to continue",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey.shade200,
                                    textColor: Colors.black,
                                    fontSize: 13.0);
                              } else {
                                if (vid != "")
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FireChat(
                                              peerID: vid,
                                              peerUrl: vprofile,
                                              peerName: vname,
                                              currentusername: userName,
                                              currentuserimage: userImage,
                                              currentuser: userID,
                                              //  peerToken: widget.peerToken,
                                            )),
                                  );
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/chat.png",
                                    height: 20, width: 20),
                                SizedBox(width: 8),
                                Text(
                                  "Chat",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: appColorBlack,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 15),
                                textStyle: TextStyle(fontSize: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                )),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
      body: StreamBuilder<StoreModel>(
          stream: storeDetailBloc.storeDetailStream,
          builder: (context, AsyncSnapshot<StoreModel> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                color: appColorBlack,
              ));
            }
            Restaurant? getStoreDeatil = snapshot.data!.restaurant != null
                ? snapshot.data!.restaurant
                : (null);

            List<Review>? getAllReview =
                snapshot.data!.review != null ? snapshot.data!.review : (null);

            resid = snapshot.data!.restaurant!.resId;
            vid = snapshot.data!.restaurant!.vid;
            vname = snapshot.data!.restaurant!.vUsername;
            vprofile = snapshot.data!.restaurant!.vProfile;

            return getStoreDeatil != null
                ? bodydata(getStoreDeatil, getAllReview!)
                : Center(
                    child: Text(
                    'Store not Found',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ));

            // return Text(snapshot.data!.restaurant!.serviceName??'');
          }),
    );
  }

  Widget bodydata(Restaurant data, List<Review> review) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
        Container(
            height: SizeConfig.blockSizeVertical! * 30,
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(57),
                image: DecorationImage(
                    image: NetworkImage(
                  selectImg != ''
                      ? selectImg
                      : data.resImage!.resImag0.toString(),
                  //     loadingBuilder: (context, child, loadingProgress) {
                  //   if (loadingProgress == null) return child;
                  //   return Center(child: CupertinoActivityIndicator());
                  // }
                )))),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            data.resName!,
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: data.resRatings! != ''
              ? Padding(
                  padding: const EdgeInsets.only(top: 5, left: 20),
                  child: Row(
                    children: [
                      RatingBar.builder(
                        initialRating: double.parse(data.resRatings!),
                        minRating: 0,
                       // direction: Axis.horizontal,
                        itemSize: 15,
                       // ignoreGestures: true,
                        allowHalfRating: true,
                        itemCount: 5,
                        unratedColor: Colors.grey,
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
                            data.resRatings!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ),

        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Row(
            children: [
              Container(
                child: Image.asset(
                  'assets/images/MapPin_Outlined.png',
                  height: 20,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text(
                  data.resAddress!,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Image.asset(
                'assets/images/globe_outlined.png',
                height: 20,
              ),
              SizedBox(
                width: 5,
              ),
              Text(data.resWebsite!)
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 22),
          child: Row(
            children: [
              Image.asset(
                'assets/images/Store_Phone.png',
                height: 20,
              ),
              SizedBox(
                width: 5,
              ),
              Text(data.resPhone!)
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ReadMoreText(
            data.resDesc!,
            trimLines: 4,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Read more',
            trimExpandedText: 'Read less',
            colorClickableText: appColorYellow,
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
          height: 35,
        ),

        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Container(
            height: SizeConfig.blockSizeVertical! * 25,
            width: SizeConfig.screenWidth,
            margin: EdgeInsets.symmetric(horizontal: 6),
            child: ClipRRect(
              child: Row(children: [
                data.allImage!.length > 0
                    ? InkWell(
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
                          imageUrl: data.resImage!.resImag0.toString(),
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
                data.allImage!.length > 0 ? SizedBox(width: 2) : Container(),
                Column(children: [
                  data.allImage!.length > 1
                  ? InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => ViewPublicPost(
                      //           id: postModal.follower[1].postId)),
                      // );
                    },
                    child: CachedNetworkImage(
                      imageUrl: data.allImage![1].toString(),
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
                  )
                  : Container(),
                  data.allImage!.length > 1 ? SizedBox(height: 2) : Container(),
                  data.allImage!.length > 2
                  ? Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      StoreImages(id)));
                        },
                        child: CachedNetworkImage(
                          imageUrl: data.allImage![2].toString(),
                          imageBuilder: (context, imageProvider) =>
                              Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.5),
                                      BlendMode.dstATop)),
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
                      Container(
                        child: Center(
                            child: Text(
                          "+ ${data.allImage!.length}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )),
                      )
                    ],
                  )
                  : Container()
                ])
              ]),
            ),
          ),
        ),

        // data.allImage!.length > 0
        //     ? SizedBox(
        //          height: 200,
        //         width: MediaQuery.of(context).size.width,
        //         child: StaggeredGridView.countBuilder(
        //             crossAxisCount: 3,
        //             scrollDirection: Axis.horizontal,
        //             itemCount:
        //                  data.allImage!.length,
        //             shrinkWrap: true,
        //             physics: NeverScrollableScrollPhysics(),
        //             staggeredTileBuilder: (int index) =>
        //                 StaggeredTile.count(2, index.isEven ? 2 : 1),
        //             mainAxisSpacing: 4.0,
        //             crossAxisSpacing: 4.0,
        //             itemBuilder: (BuildContext context, int index) {
        //               return recentDetails( data.allImage![index]);
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
        Container(
          // height: MediaQuery.of(context).size.height,
          // width: SizeConfig.screenWidth,
          child: Padding(
            padding: const EdgeInsets.only(left: 30, top: 20, right: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        // Image.asset(
                        //   "assets/images/days.png",
                        //   width: 25,
                        //   height: 25,
                        // ),
                      ],
                    ),
                    //   SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Store Availibility",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Sunday",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(width: 60),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  data.sundayFrom! != ''
                                      ? Container(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                            child: Text(
                                              data.sundayFrom!,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Text(
                                            data.sundayFrom!,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                  SizedBox(width: 10),
                                  Image.asset(
                                    "assets/images/line1.png",
                                    width: 20,
                                  ),
                                  SizedBox(width: 10),
                                  data.sundayTo! != ''
                                      ? Container(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                            child: Text(data.sundayTo!,
                                                style:
                                                    TextStyle(fontSize: 12)),
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Text(data.sundayTo!,
                                              style: TextStyle(fontSize: 12)),
                                        ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("Monday",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            SizedBox(width: 55),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  data.mondayFrom! != ''
                                      ? Container(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                            child: Text(
                                              data.mondayFrom!,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Text(
                                            data.mondayFrom!,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                  SizedBox(width: 10),
                                  Image.asset(
                                    "assets/images/line1.png",
                                    width: 20,
                                  ),
                                  SizedBox(width: 10),
                                  data.mondayTo! != ''
                                      ? Container(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                            child: Text(data.mondayTo!,
                                                style:
                                                    TextStyle(fontSize: 12)),
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Text(data.mondayTo!,
                                              style: TextStyle(fontSize: 12)),
                                        ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("Tuesday",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            SizedBox(width: 55),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  data.tuesdayFrom! != ''
                                      ? Container(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                            child: Text(
                                              data.tuesdayFrom!,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Text(
                                            data.tuesdayFrom!,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                  SizedBox(width: 10),
                                  Image.asset(
                                    "assets/images/line1.png",
                                    width: 20,
                                  ),
                                  SizedBox(width: 10),
                                  data.tuesdayTo! != ''
                                      ? Container(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                            child: Text(data.tuesdayTo!,
                                                style:
                                                    TextStyle(fontSize: 12)),
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Text(data.tuesdayTo!,
                                              style: TextStyle(fontSize: 12)),
                                        )
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("Wednesday",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            SizedBox(width: 35),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  data.wednesdayFrom! != ''
                                      ? Container(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                            child: Text(
                                              data.wednesdayFrom!,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Text(
                                            data.wednesdayFrom!,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                  SizedBox(width: 10),
                                  Image.asset(
                                    "assets/images/line1.png",
                                    width: 20,
                                  ),
                                  SizedBox(width: 10),
                                  data.wednesdayTo! != ''
                                      ? Container(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                            child: Text(data.wednesdayTo!,
                                                style:
                                                    TextStyle(fontSize: 12)),
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Text(data.wednesdayTo!,
                                              style: TextStyle(fontSize: 12)),
                                        ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("Thursday",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            SizedBox(width: 50),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  data.thursdayFrom! != ''
                                      ? Container(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                            child: Text(
                                              data.thursdayFrom!,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Text(
                                            data.thursdayFrom!,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                  SizedBox(width: 10),
                                  Image.asset(
                                    "assets/images/line1.png",
                                    width: 20,
                                  ),
                                  SizedBox(width: 10),
                                  data.thursdayTo! != ''
                                      ? Container(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                            child: Text(data.thursdayTo!,
                                                style:
                                                    TextStyle(fontSize: 12)),
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Text(data.thursdayTo!,
                                              style: TextStyle(fontSize: 12)),
                                        ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("Friday",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            SizedBox(width: 70),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  data.fridayFrom! != ''
                                      ? Container(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                            child: Text(
                                              data.fridayFrom!,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Text(
                                            data.fridayFrom!,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                  SizedBox(width: 10),
                                  Image.asset(
                                    "assets/images/line1.png",
                                    width: 20,
                                  ),
                                  SizedBox(width: 10),
                                  data.fridayTo! != ''
                                      ? Container(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                            child: Text(data.fridayTo!,
                                                style:
                                                    TextStyle(fontSize: 12)),
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Text(data.fridayTo!,
                                              style: TextStyle(fontSize: 12)),
                                        ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("Saturdarday",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            SizedBox(width: 35),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  data.saturdayFrom! != ''
                                      ? Container(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                            child: Text(
                                              data.saturdayFrom!,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Text(
                                            data.saturdayFrom!,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                  SizedBox(width: 10),
                                  Image.asset(
                                    "assets/images/line1.png",
                                    width: 20,
                                  ),
                                  SizedBox(width: 10),
                                  data.saturdayTo! != ''
                                      ? Container(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                            child: Text(data.saturdayTo!,
                                                style:
                                                    TextStyle(fontSize: 12)),
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: Text(data.saturdayTo!,
                                              style: TextStyle(fontSize: 12)),
                                        ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rating',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: (() {}),
                          child: Text(
                            'view More',
                            style: TextStyle(color: Colors.blue),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(),
                  child: reviewWidget(review),
                )
              ],
            ),
          ),
        ),

        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 0),
        //   child: Row(
        //    // mainAxisSize: MainAxisSize.max,
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Expanded(
        //         child: ElevatedButton(
        //           onPressed: () {
        //             //  print(resid);
        //             Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                     builder: (context) => ServiceByStoreList(resid)));
        //           },
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               Image.asset("assets/images/settings.png",
        //                   height: 20, width: 20),
        //               SizedBox(width: 8),
        //               Flexible(
        //                   child: Text(
        //                 "Services",
        //                 style: TextStyle(color: appColorBlack),
        //               )),
        //             ],
        //           ),
        //           style: ElevatedButton.styleFrom(
        //               primary: Colors.white,
        //               padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        //               textStyle: TextStyle(fontSize: 15),
        //               shape: RoundedRectangleBorder(
        //                 side: BorderSide(color: appColorBlack, width: 2),
        //                 borderRadius: BorderRadius.circular(8),
        //               )),
        //         ),
        //       ),
        //       SizedBox(width: 10),
        //       Expanded(
        //         child: ElevatedButton(
        //           onPressed: () {
        //             if (userID == "0") {
        //               // Toast.show("Login to continue", context,
        //               //     duration: Toast.LENGTH_SHORT,
        //               //     gravity: Toast.BOTTOM);
        //               Fluttertoast.showToast(
        //                   msg: "Login to continue",
        //                   toastLength: Toast.LENGTH_SHORT,
        //                   gravity: ToastGravity.BOTTOM,
        //                   timeInSecForIosWeb: 1,
        //                   backgroundColor: Colors.grey.shade200,
        //                   textColor: Colors.black,
        //                   fontSize: 13.0);
        //             } else {
        //               if (vid != "")
        //                 Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                       builder: (context) => FireChat(
        //                             peerID: vid,
        //                             peerUrl: vprofile,
        //                             peerName: vname,
        //                             currentusername: userName,
        //                             currentuserimage: userImage,
        //                             currentuser: userID,
        //                             //  peerToken: widget.peerToken,
        //                           )),
        //                 );
        //             }
        //           },
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               Image.asset("assets/images/chat.png",
        //                   height: 20, width: 20),
        //               SizedBox(width: 8),
        //               Text(
        //                 "Chat",
        //                 style: TextStyle(color: Colors.white),
        //               ),
        //             ],
        //           ),
        //           style: ElevatedButton.styleFrom(
        //               primary: appColorBlack,
        //               padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        //               textStyle: TextStyle(fontSize: 15),
        //               shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(8),
        //               )),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Expanded(
        //       child: ElevatedButton(
        //         onPressed: () {},
        //         child: Row(
        //           children: [
        //             Image.asset("assets/images/service.png",
        //                 height: 20, width: 20),
        //             SizedBox(width: 8),
        //             Flexible(
        //                 child: Text(
        //               "Services",
        //               style: TextStyle(color: appColorBlack),
        //             )),
        //           ],
        //         ),
        //         style: ElevatedButton.styleFrom(
        //             primary: Colors.white,
        //             padding: EdgeInsets.symmetric(horizontal: 30, vertical: 13),
        //             textStyle: TextStyle(fontSize: 15),
        //             shape: RoundedRectangleBorder(
        //               side: BorderSide(color: appColorBlack, width: 2),
        //               borderRadius: BorderRadius.circular(8),
        //             )),
        //       ),
        //     ),
        //     SizedBox(width: 10),
        //     Expanded(
        //       child: ElevatedButton(
        //         onPressed: () {},
        //         child: Row(
        //           children: [
        //             Image.asset("assets/images/chat.png",
        //                 height: 20, width: 20),
        //             SizedBox(width: 8),
        //             Text(
        //               "Chat",
        //               style: TextStyle(color: Colors.white),
        //             ),
        //           ],
        //         ),
        //         style: ElevatedButton.styleFrom(
        //             primary: appColorBlack,
        //             padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        //             textStyle: TextStyle(fontSize: 15),
        //             shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(8),
        //             )),
        //       ),
        //     ),
        //   ],
        // ),
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
                                                BorderRadius.circular(0.0)),
                                        child: Container(
                                          height: 45,
                                          width: 45,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(0.0)),
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
                                      Padding(
                                        padding: const EdgeInsets.only(right: 5),
                                        child: RatingBar.builder(
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

  Widget banner(Restaurant data) {
    return Container(
      height: SizeConfig.blockSizeVertical! * 30,
      color: Colors.grey.shade200,
      child: Stack(
        children: [
          SizedBox(
            child: Image.network(
              selectImg != '' ? selectImg : data.allImage![0],
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(child: CupertinoActivityIndicator());
              },
              errorBuilder: (context, error, stackTrace) {
                return Center(child: Text("Image not Found"));
              },
            ),
            height: MediaQuery.of(context).size.height * 2.5 / 10,
            width: MediaQuery.of(context).size.width,
          ),
          // Positioned(
          //   top: SizeConfig.safeBlockVertical! * 21,
          //   child: Container(
          //     width: MediaQuery.of(context).size.width,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: [
          //         InkWell(
          //           onTap: () {
          //             setState(() {
          //               selectImg = data.resImage!.resImag0!;
          //             });
          //             print('&&&&&&&&&&&');
          //             print(selectImg);
          //           },
          //           child: ClipRRect(
          //             borderRadius: BorderRadius.circular(15),
          //             child: Image.network(
          //               data.resImage!.resImag0!,
          //               height: 70,
          //               width: 70,
          //               fit: BoxFit.cover,
          //               loadingBuilder: (context, child, loadingProgress) {
          //                 if (loadingProgress == null) return child;
          //                 return Center(child: CupertinoActivityIndicator());
          //               },
          //             ),
          //           ),
          //         ),
          //         InkWell(
          //           onTap: () {
          //             setState(() {
          //               selectImg = data.resImage!.resImag0!;
          //             });
          //             print('&&&&&&&&&&&');
          //             print(selectImg);
          //           },
          //           child: ClipRRect(
          //             borderRadius: BorderRadius.circular(15),
          //             child: Image.network(
          //               data.resImage!.resImag0!,
          //               height: 70,
          //               width: 70,
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //         ),
          //         InkWell(
          //           onTap: () {
          //             setState(() {
          //               selectImg = data.resImage!.resImag0!;
          //             });
          //             print('&&&&&&&&&&&');
          //             print(selectImg);
          //           },
          //           child: ClipRRect(
          //             borderRadius: BorderRadius.circular(15),
          //             child: Image.network(
          //               data.resImage!.resImag0!,
          //               height: 70,
          //               width: 70,
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //         ),
          //         InkWell(
          //           onTap: () {
          //             setState(() {
          //               selectImg = data.resImage!.resImag0!;
          //             });
          //             print('&&&&&&&&&&&');
          //             print(selectImg);
          //           },
          //           child: ClipRRect(
          //             borderRadius: BorderRadius.circular(15),
          //             child: Image.network(
          //               data.resImage!.resImag0!,
          //               height: 70,
          //               width: 70,
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // )
          Positioned(
            top: SizeConfig.safeBlockVertical! * 20,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 100,
                    alignment: Alignment.center,
                    child: ListView.builder(
                        padding: EdgeInsets.only(bottom: 10),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: data.allImage!.length,
                        reverse: true,
                        itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                width: 70,
                                decoration: BoxDecoration(
                                  color: appColorWhite,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    print(data.allImage!);
                                    setState(() {
                                      selectImg = data.allImage![index];
                                    });
                                    print('&&&&&&&&&&&');
                                    print(selectImg);
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      data.allImage![index],
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                            child:
                                                CupertinoActivityIndicator());
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Center(
                                            child: Text("Image Not Found"));
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            )),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
