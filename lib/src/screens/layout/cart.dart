import 'package:another_flushbar/flushbar.dart';
import 'package:demo_project/src/blocs/getcart_bloc.dart';
import 'package:demo_project/src/blocs/removecart_bloc.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/global/sizeconfig.dart';
import 'package:demo_project/src/models/getCartItem.dart';
import 'package:demo_project/src/screens/layout/checkoutProduct.dart';
import 'package:demo_project/src/screens/user/login/login_container_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GetCartScreeen extends StatefulWidget {
  @override
  _GetCartState createState() => new _GetCartState();
}

class _GetCartState extends State<GetCartScreeen> {
  bool isPayment = false;
  var isLoading = false;

  @override
  void initState() {
    // _getCart();
    getCartBloc.getCartSink(userID);
    super.initState();
  }

  // _getCart() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   var uri = Uri.parse('${baseUrl()}/get_cart_items');
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
  //   cartModel = GetCartModal.fromJson(userData);

  //   print(responseData);
  //   if (mounted)
  //     setState(() {
  //       isLoading = false;
  //     });
  // }

  // removeCart(String id) async {
  //   setState(() {
  //     isLoading = true;
  //   });

  //   var uri = Uri.parse('${baseUrl()}/remove_cart_items');
  //   var request = new http.MultipartRequest("Post", uri);
  //   Map<String, String> headers = {
  //     "Accept": "application/json",
  //   };
  //   request.headers.addAll(headers);
  //   request.fields.addAll({'cart_id': id});
  //   // request.fields['user_id'] = userID;
  //   var response = await request.send();
  //   print(response.statusCode);
  //   String responseData = await response.stream.transform(utf8.decoder).join();
  //   var userData = json.decode(responseData);
  //   removeCartModal = RemoveCartModal.fromJson(userData);

  //   if (removeCartModal.responseCode == "1") {
  //     setState(() {
  //       cartModel = null;
  //     });
  //     _getCart();
  //   }

  //   print(responseData);

  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          backgroundColor: appColorWhite,
          appBar: AppBar(
            backgroundColor: appColorWhite,
            elevation: 2,
            title: Text(
              "Cart",
              style: TextStyle(
                  fontSize: 20,
                  color: appColorBlack,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: appColorBlack,
                )),
            actions: [],
          ),
          body: userID != '0'
              ? StreamBuilder<GetCartModel>(
                  stream: getCartBloc.getCartStream,
                  builder: (context, AsyncSnapshot<GetCartModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    // var getcartDeatil =
                    //     snapshot.data != null ? snapshot.data : (null);

                    return Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  snapshot.data!.cart != null
                                      ? ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount:
                                              snapshot.data!.cart!.length,
                                          itemBuilder: (context, index) {
                                            return _itmeList(
                                                snapshot.data!.cart![index],
                                                index);
                                          },
                                        )
                                      : Center(
                                          child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              child: Image.asset(
                                                "assets/images/emptyCart.png",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Text(
                                              "Cart is Empty",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )),
                                ],
                              ),
                            ),
                            Container(height: 15),
                            snapshot.data!.cartTotal != null
                                ? Card(
                                    margin: EdgeInsets.all(0),
                                    elevation: 10,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30,
                                          right: 30,
                                          bottom: 20,
                                          top: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Cart Total: \$${snapshot.data!.cartTotal.toString()}",
                                                  style: TextStyle(
                                                      color: appColorBlack,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              Container(height: 10),
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              CheckoutProduct()),
                                                    );
                                                  },
                                                  child: SizedBox(
                                                      height: 50,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: appColorBlack,
                                                            // gradient:
                                                            //     new LinearGradient(
                                                            //         colors: [
                                                            //           const Color(
                                                            //               0xFF4b6b92),
                                                            //           const Color(
                                                            //               0xFF619aa5),
                                                            //         ],
                                                            //         begin:
                                                            //             const FractionalOffset(
                                                            //                 0.0, 0.0),
                                                            //         end:
                                                            //             const FractionalOffset(
                                                            //                 1.0, 0.0),
                                                            //         stops: [0.0, 1.0],
                                                            //         tileMode: TileMode
                                                            //             .clamp),
                                                            // border: Border.all(color: Colors.grey[400],),
                                                            borderRadius: BorderRadius.all(Radius.circular(15))),
                                                        height: 50.0,
                                                        // ignore: deprecated_member_use
                                                        child: Center(
                                                          child: Stack(
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  "CHECKOUT",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color:
                                                                          appColorWhite,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                        isPayment == true
                            ? Center(
                                child: CupertinoActivityIndicator(),
                              )
                            : Container()
                      ],
                    );

                    // return Text(snapshot.data!.restaurant!.serviceName??'');
                  })
              : Stack(
                  children: <Widget>[
                    Container(
                      width: SizeConfig.screenWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/guest.png',
                            width: SizeConfig.blockSizeHorizontal! * 100,
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical! * 3,
                          ),
                          ElevatedButton(
                            child: Text('Click here to login'),
                            style: ElevatedButton.styleFrom(
                              primary: appColorBlack,
                              onPrimary: Colors.white,
                              shape: const BeveledRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => LoginContainerView(),
                                ),
                                (Route<dynamic> route) => false,
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                )),
    );
  }

  Widget _itmeList(Cart cart, int index) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => ProductDetails(
        //             productId: cart.productId,
        //           )),
        // );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
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
                        cart.productImage!,
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
                            cart.productName!,
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
                            "\$${cart.price}",
                             style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(height: 5),
                          Text(
                            "Qty : ${cart.quantity}",
                            style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold),
                          ),
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
                        removecartBloc
                            .removecartSink(cart.cartId!)
                            .then((cartData) {
                          print(cartData);
                          if (cartData.responseCode == "1") {
                            setState(() {
                              isLoading = false;
                            });
                            Flushbar(
                              backgroundColor: appColorWhite,
                              messageText: Text(
                                "Item remove",       
                                style: TextStyle(
                                  fontSize: 13,
                                  color: appColorBlack,
                                ),
                              ),
                              duration: Duration(seconds: 3),
                            )..show(context);
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                            Flushbar(
                              backgroundColor: appColorWhite,
                              messageText: Text(
                                "Item not remove",
                                style: TextStyle(
                                  fontSize: SizeConfig.blockSizeHorizontal,
                                  color: appColorBlack,
                                ),
                              ),
                              duration: Duration(seconds: 3),
                            )..show(context);
                          }
                        });
                        getCartBloc.getCartSink(userID);
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
    );
  }
}
