import 'package:demo_project/src/blocs/store_bloc.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/models/getProdByCat_model.dart';
import 'package:demo_project/src/screens/layout/new_layouts_product/productDetails.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: must_be_immutable
class ProductList extends StatefulWidget {
  String? id;
  ProductList({Key? key, this.id}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    storeBloc.storeSink(widget.id!);
    // serviceBloc.serviceSink();
    super.initState();
  }

  Future<void> _pullRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      storeBloc.storeSink(widget.id!);
    });
    // why use freshWords var? https://stackoverflow.com/a/52992836/2301224
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          "Products",
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
      body: Container(
        child: SingleChildScrollView(
          child: RefreshIndicator(
            onRefresh: _pullRefresh,
            color: appColorBlack,
            child: StreamBuilder<GetProdByCatID>(
                stream: storeBloc.storeStream,
                builder: (context, AsyncSnapshot<GetProdByCatID> snapshot) {
                  if (!snapshot.hasData) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: Center(
                        child: CircularProgressIndicator(color: appColorBlack),
                      ),
                    );
                  }
                  List<Products>? allService = snapshot.data!.products != null
                      ? snapshot.data!.products
                      : [];
                  return allService!.length > 0
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: allService.length,
                          itemBuilder: (context, int index) {
                            return serviceCard(allService[index]);
                          },
                        )
                      : Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 200,
                              width: 200,
                              child: Image.asset(
                                "assets/images/noproducts.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                            Text(
                              "Not Fount any Product",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ));
                }),
          ),
        ),
      ),
    );
  }

  Widget serviceCard(Products data) {
    // String? id = data.id;
    //print("id: "+id);
    return InkWell(
        onTap: () {
          // print("click");
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductsDetails(
                      productId: data.productId,
                    )),
          );
        },
        child: Stack(
          children: [
          Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              // height: MediaQuery.of(context).size.height * 2.6 / 10,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(1.0, 1.0), // shadow direction: bottom right
                  )
                ],
              ),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              // width: 70,
                              // height: 70,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                //color: Colors.redAccent,
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 90,
                                    width: 80,
                                    child: Image.network(
                                      data.productImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            data.productName!,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "\$" + data.productPrice! + "/h",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    data.proRatings! != ''
                                        ? Row(
                                            children: [
                                              RatingBar.builder(
                                                // minRating: 1,
                                                 initialRating: double.parse(data.proRatings!),
                                                direction: Axis.horizontal,
                                                itemSize: 12,
                                                //ignoreGestures: true,
                                                allowHalfRating: true,
                                                itemCount: 5,

                                                // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                itemBuilder: (context, _) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                },
                                              ),
                                              SizedBox(width: 1),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 2.0),
                                                height: 20.0,
                                                width: 30.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.circular(6.0),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    data.proRatings!,
                                                    style: TextStyle(
                                                      color: appColorWhite,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(),
                                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 1, vertical: 5),
                        child: Text(
                          data.productDescription!,
                          maxLines: 2,
                          // trimLines: 1,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 13,
                              color: Colors.grey[600]),
                          // trimMode: TrimMode.Line,

                          // colorClickableText: appColorYellow,
                          // lessStyle: TextStyle(
                          //   fontSize: 12,
                          //   fontWeight: FontWeight.bold,
                          //   color: appColorBlack,
                          //   decoration: TextDecoration.underline,
                          // ),
                          // moreStyle: TextStyle(
                          //   fontSize: 12,
                          //   fontWeight: FontWeight.bold,
                          //   color: appColorBlack,
                          //   decoration: TextDecoration.underline,
                          // ),
                        ),
                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))),
                  
        ]));
  }
}
