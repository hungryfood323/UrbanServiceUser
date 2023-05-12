import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_project/src/blocs/category_bloc.dart';
import 'package:demo_project/src/blocs/store_bloc.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/models/getAllProdCat.dart';
import 'package:demo_project/src/models/getProdByCat_model.dart';
import 'package:demo_project/src/provider/category_api.dart';
import 'package:demo_project/src/screens/layout/new_layouts_product/productDetails.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StoreScreen extends StatefulWidget {
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  String activeValue = '';
  String activeValue2 = '';
  int currntIndex = 0;
  String initialid = '';

  @override
  void initState() {
    super.initState();
    categoryBloc.categorySink();
    CategoryApi().categoryApi().then((value){
      setState(() {
        initialid = value.category![0].id!;
        storeBloc.storeSink(initialid);
      });
    });
    
    // getProductCategory();
  }

  Future<void> _pullRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
     categoryBloc.categorySink();
     storeBloc.storeSink(initialid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade200,
        title: Text(
          "Product",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<GetAllProdCategory>(
                  stream: categoryBloc.categoryStream,
                  builder: (context, AsyncSnapshot<GetAllProdCategory> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Container(),
                      );
                    }
                    List<Category>? allCategory = snapshot.data!.category != null
                        ? snapshot.data!.category
                        : [];
      
                    activeValue = snapshot.data!.category![0].cName!;
                    initialid=snapshot.data!.category![0].id!;
                    print(activeValue);
      
                    return allCategory!.length > 0
                        ? Container(
                            margin: EdgeInsets.only(right: 5.0),
                            height: 60,
                            // width:230,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              //physics: NeverScrollableScrollPhysics(),
                              itemCount: allCategory.length,
                              itemBuilder: (context, int index) {
                                return categorycard(allCategory[index], index);
                              },
                            ),
                          )
                        : Center(
                            child: Text(
                              "Don't have any Store now",
                              style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          );
                  }),
              // productModal == null
              //     ? Center(
              //         child: CircularProgressIndicator(),
              //       )
              //     : currntIndex==0 ? categoryWidget(): Container(
              //       child: Center(child: Text("Product not found"),),),
              currntIndex == 0
                  ? StreamBuilder<GetProdByCatID>(
                      stream: storeBloc.storeStream,
                      builder: (context, AsyncSnapshot<GetProdByCatID> snapshot) {
                        if (!snapshot.hasData) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height / 1.3,
                            child: Center(
                              child:
                                  CircularProgressIndicator(color: appColorBlack),
                            ),
                          );
                        }
                        List<Products>? allProduct =
                            snapshot.data!.products != null
                                ? snapshot.data!.products
                                : [];
                        return allProduct!.length > 0
                            ? GridView.builder(
                                shrinkWrap: true,
                                // physics: NeverScrollableScrollPhysics(),
                                primary: false,
                                // padding: EdgeInsets.all(10),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  childAspectRatio: 300 / 200,
                                ),
                                itemCount: allProduct.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return _nearByitemCard(allProduct[index]);
                                })
                            : SizedBox(
                                height: MediaQuery.of(context).size.height / 1.5,
                                child: Center(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 200,
                                      width:200,
                                      child: Image.asset(
                                        "assets/images/noproducts.png",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Text(
                                      "Not Found any Product",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                              );
                      })
                  : Container(
                      child: Align(
                          child: Center(
                        child: Text("Product not found"),
                      )),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardWidget(Products data) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductsDetails(
                      productId: data.productId,
                    )),
          );
        },
        child: Card(
          elevation: 0.5,
          shadowColor: Colors.black,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(08),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      fit: BoxFit.scaleDown,
                      image: NetworkImage(data.productImage!),
                    ),
                  ),
                ),
                Container(height: 10),
                Row(
                  children: [
                    Text(
                      data.productName!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.indigo.shade500,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$" + data.productPrice!,
                      style: TextStyle(
                          color: appColorBlack,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    Container(
                      height: 25,
                      width: 40,
                      child: Center(
                        child: Icon(Icons.shopping_cart,
                            color: appColorWhite, size: 18),
                      ),
                      decoration: BoxDecoration(
                        color: appColorBlack,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          bottomLeft: Radius.circular(5.0),
                        ),
                      ),
                    )
                  ],
                ),
                // Text(
                //   cateModel.categories[index].storeCount +
                //       " Shops",
                //   style: TextStyle(
                //       color: appColorWhite,
                //       fontSize: 12,
                //       fontFamily: customfont,
                //       fontWeight: FontWeight.bold),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget categorycard(Category category, index) {
    return Container(
      height: 60,
      // color: WhiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // scrollDirection: Axis.horizontal,
        //padding: EdgeInsets.zero,
        children: [
          GestureDetector(
            onTap: () {
              print(category.id);
              // provider.GetBookings(orderstatus: "Confirm");
              setState(() {
                // activeValue = category.cName!;
                activeValue2 = category.cName!;
                currntIndex = 0;
                storeBloc.storeSink(category.id!);
              });
            },
            child: Container(
              // width: 120,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(category.cName!,
                    style: TextStyle(
                        color: activeValue2 == ''
                            ? activeValue == category.cName
                                ? Colors.white
                                : appColorBlack
                            : activeValue2 == category.cName
                                ? Colors.white
                                : appColorBlack,
                        fontWeight: FontWeight.bold)),
              ),
              margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
              decoration: BoxDecoration(
                color: activeValue2 == ''
                    ? activeValue == category.cName
                        ? appColorBlack
                        : Colors.white
                    : activeValue2 == category.cName
                        ? appColorBlack
                        : Colors.white,
                border: Border.all(
                    color: activeValue2 == category.cName
                        ? Colors.grey.shade200
                        : appColorBlack),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _nearByitemCard(Products data) {
    double _height, _width, _fixedPadding;
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _fixedPadding = _height * 0.010;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductsDetails(
                    productId: data.productId,
                  )),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(_fixedPadding),
        child: Material(
          elevation: 2.0,
          shadowColor: Colors.black,
          borderRadius: BorderRadius.circular(14.0),
          child: Container(
            // height: ScreenUtil.getInstance().setHeight(470),
            // height: SizeConfig.blockSizeVertical * 10,
            // width: SizeConfig.blockSizeHorizontal * 25,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.0),
            ),

            child: Column(
              children: <Widget>[
                Container(
                  width: _width,
                  height: _height * 1.9 / 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14.0),
                    child: FittedBox(
                      child: CachedNetworkImage(
                        imageUrl: data.productImage!,
                        placeholder: (context, url) => Center(
                          child: Container(
                            margin: EdgeInsets.all(70.0),
                            child: CupertinoActivityIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: 5,
                          width: 5,
                          child: Icon(
                            Icons.error,
                          ),
                        ),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // SizedBox(
                //   height: _height * 0.025,
                // ),
                Padding(
                  padding: EdgeInsets.all(_fixedPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Text(data.productName!,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                ),
                                SizedBox(
                                  height: _height * 0.010,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Text(data.productDescription!,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.black)),
                                ),
                                SizedBox(
                                  height: _height * 0.010,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              // mainAxisAlignment:
                              //     MainAxisAlignment.start,
                              // crossAxisAlignment:
                              //     CrossAxisAlignment.end,
                              children: [
                                RatingBar.builder(
                                  initialRating: data.proRatings != null
                                      ? double.parse(data.proRatings!)
                                      : 0.0,
                                  minRating: 0,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 13,
                                  ignoreGestures: true,
                                  unratedColor: Colors.grey,
                                  itemBuilder: (context, _) =>
                                      Icon(Icons.star, color: appColorOrange),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Text("\$ " + data.productPrice!,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: appColorBlack)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
