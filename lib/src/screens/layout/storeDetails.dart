import 'package:demo_project/src/blocs/storedetail_bloc.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/global/sizeconfig.dart';
import 'package:demo_project/src/models/store_model.dart';
import 'package:demo_project/src/provider/storedetail_api.dart';
import 'package:demo_project/src/screens/chat/fireChat.dart';
import 'package:demo_project/src/screens/layout/serviceListByStore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class StoreDetailScreen extends StatefulWidget {
  String? id;
  StoreDetailScreen(this.id);
  @override
  State<StatefulWidget> createState() {
    return _StoreDetailScreenState(this.id);
  }
}

class _StoreDetailScreenState extends State<StoreDetailScreen> {
  // var json;
  bool isLoading = true;
  var selectImg = '';
  var resid;
  var vid;
  var vname;
  var vprofile;
  double rating = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String? id;
  _StoreDetailScreenState(String? id);

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
    storeDetailBloc.storeDetailSink(widget.id!);
    StoreDetailApi().storeDetailApi(widget.id!).then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
    // getStoreById('114');
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
          'Store Details',
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
                                Image.asset("assets/images/settings.png",
                                    height: 20, width: 20),
                                SizedBox(width: 8),
                                Flexible(
                                    child: Text(
                                  "Services",
                                  style: TextStyle(color: appColorBlack),
                                )),
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
                                Text("Chat"),
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

            resid = snapshot.data!.restaurant!.resId;
            vid = snapshot.data!.restaurant!.vid;
            vname = snapshot.data!.restaurant!.vUsername;
            vprofile = snapshot.data!.restaurant!.vProfile;

            return getStoreDeatil != null
                ? bodydata(getStoreDeatil)
                : Center(
                    child: Text(
                    'Store not Found',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ));

            // return Text(snapshot.data!.restaurant!.serviceName??'');
          }),
    );
  }

  Widget bodydata(Restaurant data) {
    return SingleChildScrollView(
      child: Column(
        children: [
          banner(data),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                storeDetailCard(data),
                SizedBox(height: 10),
                descriptionCard(data),
                SizedBox(height: 10),
                locationCard(data),
                SizedBox(height: 10),
                contactCard(data),
                SizedBox(height: 10),
                storeavailCard(data),
                //SizedBox(height: 20),
                //buttonCard(),
              ],
            ),
          ),
        ],
      ),
    );
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

  Widget storeDetailCard(Restaurant data) {
    return Container(
      // height: MediaQuery.of(context).size.height * 1.5 / 10,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/images/storeicon.png",
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(width: 6),
                    Flexible(
                        child: Text(
                      data.resName!,
                      style: TextStyle(fontSize: 17),
                      maxLines: 2,
                    )),
                  ],
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RatingBar.builder(
                        initialRating: data.resRatings == ''
                            ? 0.0
                            : double.parse(data.resRatings!),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 13,
                        //ignoreGestures: true,
                        unratedColor: Colors.grey,
                        itemBuilder: (context, rating) =>
                            Icon(Icons.star, color: Colors.amber),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      SizedBox(width: 5.0),
                      // Text(
                      //   "(" + data.resRatings! + " reviews)",
                      //   style: TextStyle(fontSize: 11.0),
                      // )
                      Container(
                        margin: EdgeInsets.only(left: 5.0),
                        height: 20.0,
                        width: 30.0,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Center(
                            child: Text(
                          data.resRatings!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 10),
                        )),
                      )
                    ],
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget descriptionCard(Restaurant data) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height * 2.8 / 10,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/images/description.png",
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(width: 5),
                  Text("Description", style: TextStyle(fontSize: 19)),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ReadMoreText(
                  data.resDesc!,
                  trimLines: 2,
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
            ],
          )),
    );
  }

  Widget locationCard(Restaurant data) {
    return data.resAddress! != ''
        ? Container(
            // height: MediaQuery.of(context).size.height * 1.2 / 10,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/location2.png",
                    height: 25,
                    width: 25,
                  ),
                  Text(" Location: ", style: TextStyle(fontSize: 17)),
                  Flexible(
                    child: InkWell(
                      onTap: () {
                        MapsLauncher.launchCoordinates(
                            double.parse(data.lat!), double.parse(data.lon!));
                      },
                      child: Text(
                        data.resAddress!,
                        style: TextStyle(fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container();
  }

  Widget contactCard(Restaurant data) {
    return Container(
      height: MediaQuery.of(context).size.height * 1.4 / 10,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            data.resWebsite != ''
                ? Row(
                    children: [
                      Image.asset("assets/images/web.png",
                          height: 20, width: 20),
                      Text(" Website : ", style: TextStyle(fontSize: 17)),
                      SizedBox(width: 5),
                      Flexible(
                        child: InkWell(
                          onTap: () async {
                            if (data.resWebsite != "") {
                              _launchURL("http://" + data.resWebsite!);
                            } else {
                              _showSnackBar(context, "Website not found!");
                            }
                          },
                          child: Text(
                            data.resWebsite!,
                            style:
                                TextStyle(fontSize: 13, color: appColorBlack),
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
            SizedBox(
              height: 15,
            ),
            data.resPhone != ''
                ? Row(
                    children: [
                      Image.asset("assets/images/call.png",
                          height: 20, width: 20),
                      Text(" Contact : ", style: TextStyle(fontSize: 17)),
                      SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          // ignore: deprecated_member_use
                          launch("tel://${data.resPhone}");
                        },
                        child: Text(data.resPhone!,
                            style:
                                TextStyle(fontSize: 13, color: appColorBlack)),
                      ),
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  // ignore: deprecated_member_use
  void _launchURL(String _url) async => await canLaunch(_url)
      // ignore: deprecated_member_use
      ? await launch(_url)
      : throw 'Could not launch $_url';

  void _showSnackBar(BuildContext context, String text) {
// ignore: deprecated_member_use
    _scaffoldKey.currentState!.showSnackBar(
      new SnackBar(
        // backgroundColor: Colors.grey,
        content: Text(text),
        duration: const Duration(seconds: 60),
        action: SnackBarAction(
          textColor: Colors.white,
          label: 'Close',
          onPressed: () {},
        ),
      ),
    );
  }

  Widget storeavailCard(Restaurant data) {
    return Container(
      height: MediaQuery.of(context).size.height * 5 / 10,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Column(
              children: [
                Image.asset(
                  "assets/images/days.png",
                  width: 25,
                  height: 25,
                ),
              ],
            ),
            SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Store Availibility",
                  style: TextStyle(fontSize: 19),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [Text("Sunday")],
                    ),
                    SizedBox(width: 35),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          data.sundayFrom! != ''
                              ? Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Text(
                                      data.sundayFrom!,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(7),
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Text(data.sundayTo!,
                                        style: TextStyle(fontSize: 12)),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(7),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [Text("Monday")],
                    ),
                    SizedBox(width: 30),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          data.mondayFrom! != ''
                              ? Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Text(
                                      data.mondayFrom!,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(7),
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Text(data.mondayTo!,
                                        style: TextStyle(fontSize: 12)),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(7),
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
                      children: [Text("Tuesday")],
                    ),
                    SizedBox(width: 30),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          data.tuesdayFrom! != ''
                              ? Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Text(
                                      data.tuesdayFrom!,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(7),
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Text(data.tuesdayTo!,
                                        style: TextStyle(fontSize: 12)),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(7),
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
                      children: [Text("Wednesday")],
                    ),
                    SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          data.wednesdayFrom! != ''
                              ? Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Text(
                                      data.wednesdayFrom!,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(7),
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Text(data.wednesdayTo!,
                                        style: TextStyle(fontSize: 12)),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(7),
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
                      children: [Text("Thursday")],
                    ),
                    SizedBox(width: 26),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          data.thursdayFrom! != ''
                              ? Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Text(
                                      data.thursdayFrom!,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(7),
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Text(data.thursdayTo!,
                                        style: TextStyle(fontSize: 12)),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(7),
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
                      children: [Text("Friday")],
                    ),
                    SizedBox(width: 45),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          data.fridayFrom! != ''
                              ? Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Text(
                                      data.fridayFrom!,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(7),
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Text(data.fridayTo!,
                                        style: TextStyle(fontSize: 12)),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(7),
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
                      children: [Text("Saturdarday")],
                    ),
                    SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          data.saturdayFrom! != ''
                              ? Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Text(
                                      data.saturdayFrom!,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(7),
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Text(data.saturdayTo!,
                                        style: TextStyle(fontSize: 12)),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(7),
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
      ),
    );
  }

  Widget buttonCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            child: Row(
              children: [
                Image.asset("assets/images/service.png", height: 20, width: 20),
                SizedBox(width: 8),
                Flexible(
                    child: Text(
                  "View More Services",
                  style: TextStyle(color: appColorBlack),
                )),
              ],
            ),
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 13),
                textStyle: TextStyle(fontSize: 15),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: appColorBlack, width: 2),
                  borderRadius: BorderRadius.circular(8),
                )),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            child: Row(
              children: [
                Image.asset("assets/images/chat.png", height: 20, width: 20),
                SizedBox(width: 8),
                Text("Chat"),
              ],
            ),
            style: ElevatedButton.styleFrom(
                primary: appColorBlack,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: TextStyle(fontSize: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )),
          ),
        ),
      ],
    );
  }
}
