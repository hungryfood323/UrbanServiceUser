import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_project/src/blocs/servicelist_bloc.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/models/serviceList_model.dart';
import 'package:demo_project/src/screens/layout/serviceDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: must_be_immutable
class SearchProduct extends StatefulWidget {
  bool? back;
  SearchProduct({this.back});
  @override
  _ServiceTabState createState() => _ServiceTabState();
}

class _ServiceTabState extends State<SearchProduct> {
  TextEditingController controller = new TextEditingController();
  List<Services>? allService;

  @override
  void initState() {
    super.initState();
    serviceBloc.serviceSink();
    // getAllProduct();
  }

  // getAllProduct() async {
  //   var uri = Uri.parse('${baseUrl()}/get_all_products');
  //   var request = new http.MultipartRequest("GET", uri);
  //   Map<String, String> headers = {
  //     "Accept": "application/json",
  //   };
  //   request.headers.addAll(headers);
  //   // request.fields['vendor_id'] = userID;
  //   var response = await request.send();
  //   print(response.statusCode);
  //   String responseData = await response.stream.transform(utf8.decoder).join();
  //   var userData = json.decode(responseData);

  //   if (mounted) {
  //     setState(() {
  //       allProduct = AllProductModal.fromJson(userData);
  //     });
  //   }

  //   print(responseData);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorWhite,
      appBar: AppBar(
        title: Padding(
            padding:
                const EdgeInsets.only(top: 10, right: 0, left: 0, bottom: 8),
            child: Container(
              decoration: new BoxDecoration(
                  color: Colors.green,
                  borderRadius: new BorderRadius.all(
                    Radius.circular(15.0),
                  )),
              height: 40,
              child: Center(
                child: TextField(
                  controller: controller,
                  onChanged: onSearchTextChanged,
                  autofocus: true,
                  style: TextStyle(color: Colors.grey),
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.grey.shade200),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(15.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.grey.shade200),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(15.0),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.grey.shade200),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(15.0),
                      ),
                    ),
                    filled: true,
                    hintStyle:
                        new TextStyle(color: Colors.grey[600], fontSize: 14),
                    hintText: "Search",
                    contentPadding: EdgeInsets.only(top: 10.0),
                    fillColor: Colors.grey[200],
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey[600],
                      size: 25.0,
                    ),
                  ),
                ),
              ),
            )),
        centerTitle: false,
        elevation: 1,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: null,
        actions: <Widget>[
          Container(
            width: 50,
            child: IconButton(
              padding: const EdgeInsets.all(0),
              icon: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                setState(() {
                  controller.clear();
                  onSearchTextChanged("");
                });
                Navigator.pop(context);
              },
            ),
          ),
          Container(width: 15),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 8),
            StreamBuilder<ServiceListModel>(
                stream: serviceBloc.serviceListStream,
                builder: (context, AsyncSnapshot<ServiceListModel> snapshot) {
                  if (!snapshot.hasData) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: Center(
                        child: CircularProgressIndicator(color: appColorBlack),
                      ),
                    );
                  }
                  allService = snapshot.data!.services != null
                      ? snapshot.data!.services
                      : [];
                  return allService!.length > 0
                      ? _searchResult.length != 0 ||
                              controller.text.trim().toLowerCase().isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _searchResult.length,
                              itemBuilder: (context, int index) {
                                return serviceCard(_searchResult[index]);
                              },
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: allService!.length,
                              itemBuilder: (context, int index) {
                                return serviceCard(allService![index]);
                              },
                            )
                      : Center(
                          child: Text(
                            "Don't have any Service now",
                            style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        );
                }),
          ],
        ),
      ),
    );
  }

  Widget serviceCard(Services data) {
    String? id = data.id;
    //print("id: "+id);
    return InkWell(
      onTap: () {
        // print("click");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ServiceDetailScreen(id!)),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        // height: MediaQuery.of(context).size.height * 2.6 / 10,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey.shade200,
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
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(height: SizeConfig.safeBlockVertical! * 2.5),
                    Text(data.serviceName!, style: TextStyle(fontSize: 19)),
                    double.parse(data.serviceRatings!) > 0.0
                        ? Row(
                            children: [
                              RatingBar.builder(
                                initialRating:
                                    double.parse(data.serviceRatings ?? ''),
                                minRating: 1,
                                direction: Axis.horizontal,
                                itemSize: 10,
                                allowHalfRating: false,
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
                              // Text(
                              //   "\ (" +
                              //       data.reviewCount.toString() +
                              //       " reviews\)",
                              //   style: TextStyle(fontSize: 10.0),
                              // )
                              Container(
                                    margin: EdgeInsets.only(left: 5.0),
                                    height: 18.0,
                                    width: 30.0,
                                    decoration: BoxDecoration(
                                      color: appColorWhite,
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                    child: Center(
                                        child: Text(
                                      data.serviceRatings!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                    )),
                                  )
                            ],
                          )
                        : Container(),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Price Unit: " + data.priceUnit.toString(),
                          style:
                              TextStyle(fontSize: 11.0, color: appColorBlack),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            "Duration: " + data.duration.toString() + " hour",
                            style: TextStyle(fontSize: 11.0),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    data.serviceDescription!.length > 0
                        ? Text(
                            data.serviceDescription!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(color: Colors.grey),
                          )
                        : Container(),
                    SizedBox(height: 10),
                    data.storeAddress! != ''
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 17.0,
                              ),
                              Flexible(
                                child: Text(
                                  data.storeAddress!,
                                  style: TextStyle(
                                      color: appColorBlack, fontSize: 13.0),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
              SizedBox(
                width: 05,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("\$" + data.servicePrice.toString(),
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Futura',
                          color: appColorBlack)),
                  // Image.network(data['service_image'],
                  //     height: 100, width: 100),

                  Container(
                    width: 97.0,
                    height: 97.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      //color: Colors.redAccent,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: data.serviceImage!,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Center(
                          child: Container(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              color: appColorBlack,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            Center(child: Text('Image Not Found')),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget serviceWidget() {
  //   return allProduct == null
  //       ? Center(
  //           child: CupertinoActivityIndicator(),
  //         )
  //       : allProduct.products.length > 0
  //           ? _searchResult.length != 0 ||
  //                   controller.text.trim().toLowerCase().isNotEmpty
  //               ? Padding(
  //                   padding: const EdgeInsets.only(top: 20),
  //                   child: GridView.builder(
  //                     shrinkWrap: true,
  //                     //physics: NeverScrollableScrollPhysics(),
  //                     primary: false,
  //                     padding: EdgeInsets.all(5),
  //                     itemCount: _searchResult.length,
  //                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //                       crossAxisCount: 2,
  //                       childAspectRatio: 170 / 200,
  //                     ),
  //                     itemBuilder: (BuildContext context, int index) {
  //                       return itemWidget(_searchResult[index]);
  //                     },
  //                   ),
  //                 )
  //               : Padding(
  //                   padding: const EdgeInsets.only(top: 20),
  //                   child: GridView.builder(
  //                     shrinkWrap: true,
  //                     //physics: NeverScrollableScrollPhysics(),
  //                     primary: false,
  //                     padding: EdgeInsets.all(5),
  //                     itemCount: allProduct.products.length,
  //                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //                       crossAxisCount: 2,
  //                       childAspectRatio: 170 / 200,
  //                     ),
  //                     itemBuilder: (BuildContext context, int index) {
  //                       return itemWidget(allProduct.products[index]);
  //                     },
  //                   ),
  //                 )
  //           : Center(
  //               child: Text(
  //                 "Don't have any product",
  //                 style: TextStyle(
  //                   color: appColorBlack,
  //                   fontStyle: FontStyle.italic,
  //                 ),
  //               ),
  //             );
  // }

  // Widget itemWidget(Products products) {
  //   return InkWell(
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => ProductDetails(
  //                   productId: products.productId,
  //                 )),
  //       );
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.only(right: 10),
  //       child: Padding(
  //         padding: const EdgeInsets.only(top: 10),
  //         child: Card(
  //           elevation: 5,
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //           child: Container(
  //             width: 180,
  //             child: Padding(
  //               padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: [
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Container(
  //                         height: 120,
  //                         width: 140,
  //                         child: Image.network(products.productImage[0]),
  //                       ),
  //                     ],
  //                   ),
  //                   Container(height: 5),
  //                   Text(
  //                     products.productName,
  //                     maxLines: 2,
  //                     style: TextStyle(
  //                         color: appColorBlack,
  //                         fontSize: 14,
  //                         fontWeight: FontWeight.bold),
  //                   ),
  //                   Container(height: 5),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     crossAxisAlignment: CrossAxisAlignment.end,
  //                     children: [
  //                       Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Row(
  //                             children: [
  //                               Icon(Icons.local_offer_outlined, size: 20),
  //                               Container(width: 5),
  //                               Text(
  //                                 "\$" + products.productPrice,
  //                                 style: TextStyle(
  //                                     color: appColorOrange,
  //                                     fontSize: 16,
  //                                     fontWeight: FontWeight.bold),
  //                               ),
  //                             ],
  //                           ),
  //                         ],
  //                       ),
  //                       Container(
  //                         decoration: BoxDecoration(
  //                             color: appColorOrange,
  //                             borderRadius:
  //                                 BorderRadius.all(Radius.circular(15))),
  //                         child: Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Icon(
  //                             Icons.shopping_bag_outlined,
  //                             color: appColorWhite,
  //                             size: 20,
  //                           ),
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    allService!.forEach((userDetail) {
      if (userDetail.serviceName != null) if (userDetail.serviceName!
          .toLowerCase()
          .contains(text.toLowerCase())) _searchResult.add(userDetail);
    });

    setState(() {});
  }
}

List _searchResult = [];
