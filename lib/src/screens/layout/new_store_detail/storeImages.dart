import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_project/src/blocs/storedetail_bloc.dart';
import 'package:demo_project/src/global/global.dart';

import 'package:demo_project/src/models/store_model.dart';
import 'package:demo_project/src/provider/storedetail_api.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// ignore: must_be_immutable
class StoreImages extends StatefulWidget {
  String? id;
  StoreImages(this.id);

  @override
  State<StoreImages> createState() {
    return _StoreImagesState(this.id);
  }
}

class _StoreImagesState extends State<StoreImages> {
  String? id;
  _StoreImagesState(String? id);

  bool isLoading = true;

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
          'Images',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: (() {
            Navigator.pop(context);
          }),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
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
                    // child: Row(
                    //   mainAxisSize: MainAxisSize.max,
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Expanded(
                    //       child: ElevatedButton(
                    //         onPressed: () {
                    //           //  print(resid);
                    //           Navigator.push(
                    //               context,
                    //               MaterialPageRoute(
                    //                   builder: (context) =>
                    //                       ServiceByStoreList(resid)));
                    //         },
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             Image.asset("assets/images/settings.png",
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
                    //             padding: EdgeInsets.symmetric(
                    //                 horizontal: 30, vertical: 15),
                    //             textStyle: TextStyle(fontSize: 15),
                    //             shape: RoundedRectangleBorder(
                    //               side: BorderSide(
                    //                   color: appColorBlack, width: 2),
                    //               borderRadius: BorderRadius.circular(8),
                    //             )),
                    //       ),
                    //     ),
                    //     SizedBox(width: 10),
                    //     Expanded(
                    //       child: ElevatedButton(
                    //         onPressed: () {
                    //           if (userID == "0") {
                    //             // Toast.show("Login to continue", context,
                    //             //     duration: Toast.LENGTH_SHORT,
                    //             //     gravity: Toast.BOTTOM);
                    //             Fluttertoast.showToast(
                    //                 msg: "Login to continue",
                    //                 toastLength: Toast.LENGTH_SHORT,
                    //                 gravity: ToastGravity.BOTTOM,
                    //                 timeInSecForIosWeb: 1,
                    //                 backgroundColor: Colors.grey.shade200,
                    //                 textColor: Colors.black,
                    //                 fontSize: 13.0);
                    //           } else {
                    //             if (vid != "")
                    //               Navigator.push(
                    //                 context,
                    //                 MaterialPageRoute(
                    //                     builder: (context) => FireChat(
                    //                           peerID: vid,
                    //                           peerUrl: vprofile,
                    //                           peerName: vname,
                    //                           currentusername: userName,
                    //                           currentuserimage: userImage,
                    //                           currentuser: userID,
                    //                           //  peerToken: widget.peerToken,
                    //                         )),
                    //               );
                    //           }
                    //         },
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             Image.asset("assets/images/chat.png",
                    //                 height: 20, width: 20),
                    //             SizedBox(width: 8),
                    //             Text("Chat",style: TextStyle(color: Colors.white),),
                    //           ],
                    //         ),
                    //         style: ElevatedButton.styleFrom(
                    //             primary: appColorBlack,
                    //             padding: EdgeInsets.symmetric(
                    //                 horizontal: 40, vertical: 15),
                    //             textStyle: TextStyle(fontSize: 15),
                    //             shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(8),
                    //             )),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  )),
            ),
      body: StreamBuilder<StoreModel>(
          stream: storeDetailBloc.storeDetailStream,
          builder: (context, AsyncSnapshot<StoreModel> snapshot) {
            if (snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                color: appColorBlack,
              ));
            }
            Restaurant? getStoreDeatil = snapshot.data!.restaurant != null
                ? snapshot.data!.restaurant
                : (null);

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
          data.allImage!.length > 0
              ? SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: StaggeredGridView.countBuilder(
                      crossAxisCount: 3,
                      scrollDirection: Axis.horizontal,
                      itemCount: data.allImage!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      staggeredTileBuilder: (int index) =>
                          StaggeredTile.count(2, index.isEven ? 2 : 1),
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      itemBuilder: (BuildContext context, int index) {
                        return recentDetails(data.allImage![index]);
                      }),
                )
              : Center(
                  child: Text(
                    "No result found!",
                    style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
        ],
      ),
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
}
