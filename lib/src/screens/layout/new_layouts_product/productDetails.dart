// ignore_for_file: unused_element, unused_local_variable

import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:demo_project/src/blocs/addtocart_bloc.dart';
import 'package:demo_project/src/blocs/like_bloc.dart';

import 'package:demo_project/src/blocs/productdetail_bloc.dart';
import 'package:demo_project/src/blocs/unlike_bloc.dart';
import 'package:demo_project/src/elements/error_dialog.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/global/sizeconfig.dart';
import 'package:demo_project/src/models/productDetail_model.dart';
import 'package:demo_project/src/screens/layout/cart.dart';
import 'package:demo_project/src/screens/layout/wishList.dart';
import 'package:demo_project/src/screens/user/login/login_container_view.dart';
import 'package:demo_project/src/strings.dart/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:dots_indicator/dots_indicator.dart';

// ignore: must_be_immutable
class ProductsDetails extends StatefulWidget {
  String? productId;

  ProductsDetails({
    this.productId,
  });
  @override
  _ProductsDetailsState createState() {
    return _ProductsDetailsState(this.productId!);
  }
}

class _ProductsDetailsState extends State<ProductsDetails>
    with SingleTickerProviderStateMixin {
  String productId;
  _ProductsDetailsState(this.productId);

  PageController pageController = PageController();
  TabController? _tabController;

  final CarouselController _controller = CarouselController();

  var currPageValue = 0.0;
  // double scaleFactor = 0.8;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    productDetailBloc.productDetailSink(productId);
    super.initState();
    pageController.addListener(() {
      setState(() {
        currPageValue = pageController.page!;
      });
    });
  }

  // @override
  // // ignore: must_call_super
  // void dispose() {
  //   pageController.dispose();
  // }

  //ScrollController? _scrollController;

  // AddtoCartModal addtoCartModal;

  String totalPrice = '';
  bool tab1 = true;
  bool tab2 = false;
  bool tab3 = false;
  bool isLoading = false;
  var selectImg = "";

  bool cartLoader = false;

  int _n = 1;

  void minus(String value) {
    setState(() {
      if (_n != 1) {
        _n--;
        int price = _n * int.parse(value);
        totalPrice = price.toString();
      }
    });
  }

  void add(String value) {
    setState(() {
      _n++;
      int price = _n * int.parse(value);
      totalPrice = price.toString();
    });
    print(totalPrice);
  }

  refresh() {
    // _getProductDetails();
  }

  // _getProductDetails() async {
  // var uri = Uri.parse('${baseUrl()}/get_product_details');
  //   var request = new http.MultipartRequest("POST", uri);
  //   Map<String, String> headers = {
  //     "Accept": "application/json",
  //   };
  //   request.headers.addAll(headers);
  //   request.fields['product_id'] = widget.productId;
  //   var response = await request.send();
  //   print(response.statusCode);
  //   String responseData = await response.stream.transform(utf8.decoder).join();
  //   var userData = json.decode(responseData);

  //   if (mounted) {
  //     setState(() {
  //       productDetailsModal = ProductDetailsModal.fromJson(userData);
  //       totalPrice = productDetailsModal.product.productPrice;
  //     });
  //   }

  //   print(responseData);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          "Product",
          style: TextStyle(color: appColorBlack, fontWeight: FontWeight.w600),
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
      body: SingleChildScrollView(
        child: cartLoader
            ? Center(
                child: SizedBox(
                height: MediaQuery.of(context).size.height / 1.5,
                child: Center(
                    child: CircularProgressIndicator(color: appColorBlack)),
              ))
            : Stack(
                children: [
                  // productDetailModel == null
                  //     ? Center(child: CupertinoActivityIndicator())
                  //     : _projectInfo(),
                  StreamBuilder<ProductDetailModel>(
                      stream: productDetailBloc.productDetailStream,
                      builder: (context,
                          AsyncSnapshot<ProductDetailModel> snapshot) {
                        if (!snapshot.hasData) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height / 1.5,
                            child: Center(
                                child: CircularProgressIndicator(
                                    color: appColorBlack)),
                          );
                        }

                        var getProductDeatil =
                            snapshot.data != null ? snapshot.data : (null);

                        List<Review>? getAllReview =
                            snapshot.data!.review != null
                                ? snapshot.data!.review
                                : (null);

                        return _projectInfo(getProductDeatil!, getAllReview!);

                        // return Text(snapshot.data!.restaurant!.serviceName??'');
                      }),
                ],
              ),
      ),
    );
  }

  Widget _projectInfo(ProductDetailModel data, List<Review> review) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: false,
              autoPlayAnimationDuration: Duration(seconds: 2),
              enableInfiniteScroll: false,
              height: 400,
              onPageChanged: (index, reason) {
                setState(() {
                });
              }),
          items: data.product!.productImage!.map<Widget>((it) {
            return ClipRRect(
              borderRadius: new BorderRadius.circular(5.0),
              child: Container(
                height: 200,
                width: SizeConfig.screenWidth,
                child: CachedNetworkImage(
                  imageUrl: it,
                  imageBuilder: (context, imageProvider) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    decoration: BoxDecoration(
                      borderRadius: new BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Center(
                    child: Container(
                      height: 50,
                      width: 50,
                      // margin: EdgeInsets.all(70.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(appColorBlue),
                        ),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }).toList(),
        ),
      ),
      SizedBox(
        height: 3,
      ),

      // Center(
      //   child: new DotsIndicator(
      //     dotsCount: data.product!.productImage!.length > 1
      //         ? data.product!.productImage!.length
      //         : 1,
      //     position: currPageValue,
      //     decorator: DotsDecorator(
      //       color: Colors.black87, // Inactive color
      //       activeColor: Colors.grey,
      //     ),
      //   ),
      // ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                data.product!.productName!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: likedProduct.contains(productId)
                    ? SizedBox(
                        height: 30,
                        width: 30,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            //shape: CircleBorder(),
                            padding: EdgeInsets.all(1),
                            primary: Colors.black, // <-- Splash color
                          ),
                          child: Icon(
                            Icons.favorite,
                            color: Colors.red,
                            // size: 20,
                          ),
                          onPressed: () {
                            unLikeBloc
                                .unlikeSink(productId, userID)
                                .then((value) {
                              if (value.status == 1) {
                                setState(() {
                                  likedProduct.remove(productId);
                                });
                                Flushbar(
                                  backgroundColor: appColorWhite,
                                  messageText: Text(
                                    value.msg!,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: appColorBlack,
                                    ),
                                  ),

                                  duration: Duration(seconds: 3),
                                  // ignore: deprecated_member_use
                                  mainButton: Container(),
                                  icon: Icon(
                                    Icons.favorite_border,
                                    color: appColorBlack,
                                    size: 25,
                                  ),
                                )..show(context);
                              } else {
                                Flushbar(
                                  title: "Fail",
                                  message: value.msg,
                                  duration: Duration(seconds: 3),
                                  icon: Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                )..show(context);
                              }
                            });
                            // unLikeProduct(
                            //     data.product!.productId!,
                            //     userID);
                          },
                        ),
                      )
                    : SizedBox(
                        height: 30,
                        width: 30,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            //shape: CircleBorder(),
                            padding: EdgeInsets.all(1),
                            primary: Colors.black, // <-- Splash color
                          ),
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            // size: 20,
                          ),
                          onPressed: () {
                            likeBloc.likeSink(productId, userID).then((value) {
                              if (value.responseCode == "1") {
                                setState(() {
                                  likedProduct.add(productId);
                                });
                                Flushbar(
                                  backgroundColor: appColorWhite,
                                  messageText: Text(
                                    value.message!,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: appColorBlack,
                                    ),
                                  ),

                                  duration: Duration(seconds: 3),
                                  // ignore: deprecated_member_use
                                  mainButton: FlatButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => WishListScreen(
                                            back: true,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Go to wish list",
                                      style: TextStyle(color: appColorBlack),
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.favorite,
                                    color: appColorBlack,
                                    size: 25,
                                  ),
                                )..show(context);
                              } else {
                                Flushbar(
                                  title: "Fail",
                                  message: value.message,
                                  duration: Duration(seconds: 3),
                                  icon: Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                )..show(context);
                              }
                            });
                            // likeProduct(
                            //     data.product!.productId,
                            //     userID);
                          },
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
      data.product!.proRatings != ''
          ? Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  RatingBar.builder(
                    // minRating: 1,
                    initialRating: double.parse(data.product!.proRatings!),
                    direction: Axis.horizontal,
                    itemSize: 15,
                    //ignoreGestures: true,
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
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Center(
                      child: Text(
                        data.product!.proRatings!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: InkWell(
                  onTap: () {
                    minus(data.product!.productPrice!);
                  },
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                        child: Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 15,
                    )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3, right: 15),
                child: Text(
                  _n.toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              InkWell(
                onTap: () {
                  add(data.product!.productPrice!);
                },
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                      child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 15,
                  )),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: totalPrice != ''
                ? Text(
                    "\$ " + totalPrice,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        fontFamily: 'OpenSansBold'),
                  )
                : Text(
                    "\$ " + data.product!.productPrice.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        fontFamily: 'OpenSansBold'),
                  ),
          )
        ],
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Container(
          color: Colors.white,
          child: TabBar(
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.black),
            tabs: [
              Container(child: Text('Description')),
              Container(child: Text('How To Use')),
              Container(child: Text('Reviews')),
            ],
            unselectedLabelColor: const Color(0xffacb3bf),
            indicatorColor: Colors.black,
            labelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 3.0,
            indicatorPadding: EdgeInsets.all(0),
            labelPadding: EdgeInsets.fromLTRB(8, 8, 8, 7),
            isScrollable: false,
            controller: _tabController,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          height: SizeConfig.blockSizeVertical! * 30,
          child: TabBarView(controller: _tabController, children: <Widget>[
            Container(
              child: Text(data.product!.productDescription!,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 14, color: appColorBlack)),
            ),
            Container(
              child: Text(data.product!.productDescription!,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 14, color: appColorBlack)),
            ),
            Container(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: reviewWidget(review),
            ))
          ]),
        ),
      ),

      // Container(
      //   color: backgroundgrey,
      //   child: Padding(
      //     padding: const EdgeInsets.all(15),
      //     child: Container(
      //       color: appColorWhite,
      //       child: Padding(
      //         padding: const EdgeInsets.all(15),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           children: [
      //             Container(width: 40),
      //             Column(
      //               children: [
      //                 Text(
      //                   'One Fair Price :',
      //                   style: TextStyle(
      //                       fontWeight: FontWeight.bold, fontSize: 16),
      //                 ),
      //                 Text(
      //                   'Inclusive of all taxes \n and a good discount',
      //                   style: TextStyle(fontSize: 11, color: Colors.grey),
      //                 )
      //               ],
      //             ),
      //             Container(width: 15),
      //             totalPrice != ''
      //                 ? Text(
      //                     "\$ " + totalPrice,
      //                     style: TextStyle(
      //                         fontWeight: FontWeight.bold,
      //                         fontSize: 30,
      //                         fontFamily: 'OpenSansBold'),
      //                   )
      //                 : Text(
      //                     "\$ " + data.product!.productPrice.toString(),
      //                     style: TextStyle(
      //                         fontWeight: FontWeight.bold,
      //                         fontSize: 30,
      //                         fontFamily: 'OpenSansBold'),
      //                   )
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),

      Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: userID != '0'
              ? InkWell(
                  onTap: () {
                    setState(() {
                      cartLoader = true;
                    });
                    print(userID);
                    print(data.product!.productId);
                    addtoacartBloc
                        .addtocartSink(
                            _n.toString(), userID, data.product!.productId!)
                        .then(
                      (userResponse) {
                        print(userResponse.responseCode);
                        if (userResponse.responseCode ==
                            Strings.responseSuccess) {
                          setState(() {
                            cartLoader = false;
                          });
                          Flushbar(
                            backgroundColor: appColorWhite,
                            messageText: Text(
                              "Item added",
                              style: TextStyle(
                                fontSize: 13,
                                color: appColorBlack,
                              ),
                            ),

                            duration: Duration(seconds: 3),
                            // ignore: deprecated_member_use
                            mainButton: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GetCartScreeen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Go to cart",
                                style: TextStyle(color: appColorBlack),
                              ),
                            ),
                            icon: Icon(
                              Icons.shopping_cart,
                              color: appColorBlack,
                              size: 30,
                            ),
                          )..show(context);
                          addtoacartBloc.dispose();
                          productDetailBloc.productDetailSink(productId);
                          //
                          // Navigator.of(context).pushAndRemoveUntil(
                          //   MaterialPageRoute(
                          //     builder: (context) => TabbarScreen(),
                          //   ),
                          //   (Route<dynamic> route) => false,
                          // );
                        } else if (userResponse.responseCode == '0') {
                          setState(() {
                            cartLoader = false;
                          });
                          showDialog<dynamic>(
                              context: context,
                              builder: (BuildContext context) {
                                return ErrorDialog(
                                  message: '${userResponse.message.toString()}',
                                );
                              });
                        } else {
                          setState(() {
                            isLoading = false;
                          });
                          showDialog<dynamic>(
                              context: context,
                              builder: (BuildContext context) {
                                return ErrorDialog(
                                  message: 'Error',
                                );
                              });
                        }
                        setState(() {
                          cartLoader = false;
                        });
                      },
                    );
                  },
                  child: SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                            color: appColorBlack,
                            // gradient: new LinearGradient(
                            //     colors: [
                            //       const Color(0xFF4b6b92),
                            //       const Color(0xFF619aa5),
                            //     ],
                            //     begin: const FractionalOffset(0.0, 0.0),
                            //     end: const FractionalOffset(1.0, 0.0),
                            //     stops: [0.0, 1.0],
                            //     tileMode: TileMode.clamp),
                            border: Border.all(color: Colors.grey[400]!),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        height: 50.0,
                        // ignore: deprecated_member_use
                        child: Center(
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "ADD TO CART",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: appColorWhite,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                )
              : InkWell(
                  onTap: () {
                    Flushbar(
                      backgroundColor: appColorWhite,
                      messageText: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 13,
                          color: appColorBlack,
                        ),
                      ),

                      duration: Duration(seconds: 3),
                      // ignore: deprecated_member_use
                      mainButton: FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => LoginContainerView(),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: Text(
                          "Click here to login",
                          style: TextStyle(color: appColorBlack),
                        ),
                      ),
                      icon: Icon(
                        Icons.login_outlined,
                        color: appColorBlack,
                        size: 20,
                      ),
                    )..show(context);
                  },
                  child: SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                            color: appColorBlack,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        height: 50.0,
                        // ignore: deprecated_member_use
                        child: Center(
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "ADD TO CART",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: appColorWhite,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                )),

      // Padding(
      //   padding: const EdgeInsets.only(right: 15, left: 15),
      //   child: ElevatedButton(
      //       style: ButtonStyle(
      //           overlayColor: MaterialStateProperty.all(Colors.white30),
      //           minimumSize: MaterialStateProperty.all(const Size(430, 55)),
      //           backgroundColor: MaterialStateProperty.all(Colors.black),
      //           shape: MaterialStateProperty.all(RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(8)))),
      //       onPressed: () {
      //         // Navigator.push(
      //         //   context,
      //         //   MaterialPageRoute(builder: (context) => ()),
      //         // );
      //       },
      //       child: Text(
      //         'Add To Cart',
      //         style: TextStyle(
      //             color: Colors.white,
      //             fontSize: 16,
      //             fontWeight: FontWeight.bold),
      //       )),
      // ),
    ]);
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
