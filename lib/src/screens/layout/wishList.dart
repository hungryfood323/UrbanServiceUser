import 'dart:convert';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/global/sizeconfig.dart';
import 'package:demo_project/src/models/wishlist_model.dart';
import 'package:demo_project/src/screens/layout/new_layouts_product/productDetails.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WishListScreen extends StatefulWidget {
  bool? back;
  WishListScreen({this.back});
  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  bool explorScreen = false;
  bool mapScreen = true;

  GetWishListModal? getWishListModal;

  @override
  void initState() {
    // _getServiceWishList();
    _getWishList();
    super.initState();
  }

  _getWishList() async {
    var uri = Uri.parse('${baseUrl()}/wishlist');
    var request = new http.MultipartRequest("Post", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    request.fields.addAll({'user_id': userID});

    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    if (mounted) {
      setState(() {
        getWishListModal = GetWishListModal.fromJson(userData);
      });
    }
  }

  // _getServiceWishList() async {
  //   var uri = Uri.parse('${baseUrl()}/service_wishlist');
  //   var request = new http.MultipartRequest("Post", uri);
  //   Map<String, String> headers = {
  //     "Accept": "application/json",
  //   };
  //   request.headers.addAll(headers);
  //   request.fields.addAll({'user_id': userID});

  //   var response = await request.send();
  //   print(response.statusCode);
  //   String responseData = await response.stream.transform(utf8.decoder).join();
  //   var userData = json.decode(responseData);
  //   if (mounted) {
  //     setState(() {
  //       getServiceWishListModal =
  //           service.GetServiceWishListModal.fromJson(userData);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Container(
        child: Scaffold(
          backgroundColor: appColorWhite,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 2,
            automaticallyImplyLeading: false,
            title: Text(
              'Saved',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                if (widget.back == true) {
                  Navigator.pop(context);
                }
              },
            ),
          ),
          body: Column(
            children: [
              Container(height: 15),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: DefaultTabController(
                    length: 1,
                    initialIndex: 0,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 250,
                          height: 40,
                          decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[300]),
                          child: Center(
                            child: TabBar(
                              labelColor: appColorWhite,
                              unselectedLabelColor: appColorBlack,
                              labelStyle: TextStyle(
                                  fontSize: 13.0,
                                  color: appColorWhite,
                                  fontFamily: 'OpenSansBold'),
                              unselectedLabelStyle: TextStyle(
                                  fontSize: 13.0,
                                  color: appColorBlack,
                                  fontFamily: 'OpenSansBold'),
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: appColorBlack),
                              tabs: <Widget>[
                                Tab(
                                  text: 'Products',
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: <Widget>[
                              // serviceWidget(),
                              productWidget()
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget serviceWidget() {
  //   return getServiceWishListModal == null
  //       ? Center(
  //           child: CircularProgressIndicator(),
  //         )
  //       : getServiceWishListModal.wishlist.length > 0
  //           ? ListView.builder(
  //               scrollDirection: Axis.vertical,
  //               shrinkWrap: true,
  //               itemCount: getServiceWishListModal.wishlist.length,
  //               itemBuilder: (context, index) {
  //                 return _serviceItmeList(
  //                     getServiceWishListModal.wishlist[index], index);
  //               },
  //             )
  //           : Center(
  //               child: Text(
  //               "Wishlist is Empty",
  //               style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
  //             ));
  // }

  // Widget _serviceItmeList(service.Wishlist wishlist, int index) {
  //   return likedService.contains(wishlist.resId)
  //       ? InkWell(
  //           onTap: () {
  //             // Navigator.push(
  //             //   context,
  //             //   MaterialPageRoute(
  //             //       builder: (context) => DetailScreen(
  //             //             resId: wishlist.resId,
  //             //           )),
  //             // );
  //           },
  //           child: Padding(
  //             padding: const EdgeInsets.only(left: 40, right: 40),
  //             child: Column(
  //               children: [
  //                 Container(
  //                   height: 130,
  //                   width: double.infinity,
  //                   margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
  //                   child: Container(
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       children: [
  //                         ClipRRect(
  //                           borderRadius: BorderRadius.circular(
  //                             0.0,
  //                           ),
  //                           child: Image.network(
  //                             wishlist.resImage,
  //                             height: 90,
  //                             width: 90,
  //                             // errorBuilder: (BuildContext context,
  //                             //     Object exception, StackTrace stackTrace) {
  //                             //   return Icon(Icons.error);
  //                             // },
  //                             fit: BoxFit.cover,
  //                           ),
  //                         ),
  //                         Container(
  //                           width: 20,
  //                         ),
  //                         Expanded(
  //                           child: Column(
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Text(
  //                                 wishlist.resName,
  //                                 style: TextStyle(
  //                                     fontSize: 16,
  //                                     color: appColorBlack,
  //                                     fontWeight: FontWeight.bold),
  //                                 maxLines: 2,
  //                                 softWrap: true,
  //                                 overflow: TextOverflow.ellipsis,
  //                               ),
  //                               Container(height: 5),
  //                               Text(
  //                                 "\$${wishlist.resDesc}",
  //                                 maxLines: 2,
  //                                 style: TextStyle(
  //                                     color: Colors.grey,
  //                                     fontWeight: FontWeight.bold,
  //                                     fontSize: 14),
  //                               ),
  //                               Container(height: 5),
  //                             ],
  //                           ),
  //                         ),
  //                         IconButton(
  //                           icon: Icon(
  //                             Icons.delete_outline,
  //                             color: appColorBlack,
  //                             size: 20,
  //                           ),
  //                           onPressed: () {
  //                             // unLikeServiceFunction(
  //                             //     wishlist.resId, userID, index);
  //                           },
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //                 Container(
  //                   height: 1,
  //                   color: Colors.grey[300],
  //                 )
  //               ],
  //             ),
  //           ),
  //         )
  //       : Container();
  // }

  Widget productWidget() {
    return getWishListModal == null
        ? Center(
            child: loader(context),
          )
        : getWishListModal!.wishlist!.length > 0
            ? ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: getWishListModal!.wishlist!.length,
                itemBuilder: (context, index) {
                  return _productItmeList(
                      getWishListModal!.wishlist![index], index);
                },
              )
            : Center(
                child: Text(
                "Wishlist is Empty",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ));
  }

  Widget _productItmeList(Wishlist wishlist, int index) {
    return likedProduct.contains(wishlist.proId)
        ? InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductsDetails(
                          productId: wishlist.proId,
                        )),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Column(
                children: [
                  Container(
                    height: 130,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                              0.0,
                            ),
                            child: Image.network(
                              wishlist.productImage!,
                              height: 90,
                              width: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  wishlist.productName!,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: appColorBlack,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Container(height: 5),
                                Text(
                                  "\$${wishlist.productPrice}",
                                  style: TextStyle(
                                      color: appColorBlack,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Container(height: 5),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete_outline,
                              color: appColorBlack,
                              size: 20,
                            ),
                            onPressed: () {
                              // unLikeProduct(wishlist.proId, userID, index);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey[300],
                  )
                ],
              ),
            ),
          )
        : Container();
  }

  // unLikeServiceFunction(String resId, String userID, int index) async {
  //   UnlikeServiceModal unlikeServiceModal;

  //   var uri = Uri.parse('${baseUrl()}/unlike');
  //   var request = new http.MultipartRequest("POST", uri);
  //   Map<String, String> headers = {
  //     "Accept": "application/json",
  //   };
  //   request.headers.addAll(headers);
  //   request.fields.addAll({
  //     'res_id': resId,
  //     'user_id': userID,
  //   });

  //   var response = await request.send();
  //   print(response.statusCode);
  //   String responseData = await response.stream.transform(utf8.decoder).join();
  //   var userData = json.decode(responseData);

  //   unlikeServiceModal = UnlikeServiceModal.fromJson(userData);

  //   if (unlikeServiceModal.status == '1') {
  //     setState(() {
  //       getServiceWishListModal.wishlist.remove(index);
  //       likedService.remove(resId);
  //       serviceWidget();
  //     });
  //     Flushbar(
  //       backgroundColor: appColorWhite,
  //       messageText: Text(
  //         unlikeServiceModal.msg,
  //         style: TextStyle(
  //           fontSize: SizeConfig.blockSizeHorizontal! * 4,
  //           color: appColorBlack,
  //         ),
  //       ),

  //       duration: Duration(seconds: 3),
  //       // ignore: deprecated_member_use
  //       mainButton: Container(),
  //       icon: Icon(
  //         Icons.favorite_border,
  //         color: appColorBlack,
  //         size: 25,
  //       ),
  //     )..show(context);
  //   } else {
  //     Flushbar(
  //       title: "Fail",
  //       message: unlikeServiceModal.msg,
  //       duration: Duration(seconds: 3),
  //       icon: Icon(
  //         Icons.error,
  //         color: Colors.red,
  //       ),
  //     )..show(context);
  //   }
  // }

  // unLikeProduct(String productId, String userID, int index) async {
  //   UnlikeModel unlikeModel;

  //   var uri = Uri.parse('${baseUrl()}/unlike_product');
  //   var request = new http.MultipartRequest("POST", uri);
  //   Map<String, String> headers = {
  //     "Accept": "application/json",
  //   };
  //   request.headers.addAll(headers);
  //   request.fields.addAll({
  //     'pro_id': productId,
  //     'user_id': userID,
  //   });

  //   var response = await request.send();
  //   print(response.statusCode);
  //   String responseData = await response.stream.transform(utf8.decoder).join();
  //   var userData = json.decode(responseData);

  //   unlikeModel = UnlikeModel.fromJson(userData);

  //   if (unlikeModel.status == 1) {
  //     setState(() {
  //       getWishListModal.wishlist!.remove(index);
  //       likedProduct.remove(productId);
  //       productWidget();
  //     });
  //     Flushbar(
  //       backgroundColor: appColorWhite,
  //       messageText: Text(
  //         unlikeModel.msg,
  //         style: TextStyle(
  //           fontSize: SizeConfig.blockSizeHorizontal * 4,
  //           color: appColorBlack,
  //         ),
  //       ),

  //       duration: Duration(seconds: 3),
  //       // ignore: deprecated_member_use
  //       mainButton: Container(),
  //       icon: Icon(
  //         Icons.favorite_border,
  //         color: appColorBlack,
  //         size: 25,
  //       ),
  //     )..show(context);
  //   } else {
  //     Flushbar(
  //       title: "Fail",
  //       message: unlikeModel.msg,
  //       duration: Duration(seconds: 3),
  //       icon: Icon(
  //         Icons.error,
  //         color: Colors.red,
  //       ),
  //     )..show(context);
  //   }
  // }
}
