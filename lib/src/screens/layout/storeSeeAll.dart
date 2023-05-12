// import 'package:demo_project/src/blocs/home_bloc.dart';
// import 'package:demo_project/src/global/global.dart';
// import 'package:demo_project/src/models/home_model.dart';
// import 'package:demo_project/src/screens/layout/new_store_detail/storeDeail2.dart';
// import 'package:demo_project/src/screens/layout/storeDetails.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// // ignore: must_be_immutable
// class StoreAll extends StatefulWidget {
//   @override
//   _StoreAllState createState() => new _StoreAllState();
// }

// class _StoreAllState extends State<StoreAll> {
//   var isLoading = false;

//   @override
//   void initState() {
//     homeBloc.homeSink();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: Scaffold(
//       backgroundColor: appColorWhite,
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         iconTheme: IconThemeData(
//           color: Colors.black, //change your color here
//         ),
//         backgroundColor: appColorWhite,
//         elevation: 2,
//         title: Text(
//           "Stores",
//           style: TextStyle(
//               fontSize: 20, color: appColorBlack, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         actions: [],
//       ),
//       body: SingleChildScrollView(
//         child: StreamBuilder<HomeModel>(
//             stream: homeBloc.homeStream,
//             builder: (context, AsyncSnapshot<HomeModel> snapshot) {
//               if (!snapshot.hasData) {
//                 return SizedBox(
//                   height: MediaQuery.of(context).size.height / 1.5,
//                   child: Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                 );
//               }
//               return Column(
//                 children: [
//                   Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ListView.builder(
//                           physics: NeverScrollableScrollPhysics(),
//                           shrinkWrap: true,
//                           itemCount: snapshot.data!.store!.length,
//                           itemBuilder: (context, index) {
//                             return storeCard(snapshot.data!.store![index]);
//                           })),
//                 ],
//               );
//             }),
//       ),
//     ));
//   }

//   Widget storeCard(Store data) {
//     return InkWell(
//       onTap: () {
//         print(data.resId);
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => NewStoreDetailScreen(data.resId)));
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//         // height: 220.0,
//         width: MediaQuery.of(context).size.width * 8 / 10,
//         decoration: BoxDecoration(
//           color: Colors.grey.shade200,
//           shape: BoxShape.rectangle,
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: 75,
//                 width: 75,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Image.network(
//                     data.resImage!.resImag0!,
//                     fit: BoxFit.cover,
//                     loadingBuilder: (context, child, loadingProgress) {
//                       if (loadingProgress == null) return child;
//                       return Center(child: CupertinoActivityIndicator());
//                     },
//                     errorBuilder: (context, error, stackTrace) {
//                       return Center(child: Text("Image not Found"));
//                     },
//                   ),
//                 ),
//               ),
//               SizedBox(width: 10),
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Column(
//                       children: [
//                         // Text(calculateDistance(
//                         //         currentLocation!.latitude,
//                         //         currentLocation!.longitude,
//                         //         double.parse(
//                         //             data.lat!.length > 0 ? data.lat! : '0'),
//                         //         double.parse(
//                         //             data.lon!.length > 0 ? data.lon! : '0'))
//                         //     .toStringAsFixed(0)),
//                         Row(
//                           children: [
//                             Flexible(
//                               child: new Container(
//                                 padding: new EdgeInsets.only(right: 0.0),
//                                 child: new Text(
//                                   data.resName!,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: new TextStyle(
//                                     fontSize: 13.0,
//                                     fontFamily: 'Roboto',
//                                     color: new Color(0xFF212121),
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 5),
//                         Row(
//                           children: [
//                             RatingBar.builder(
//                               initialRating: data.resRatings != null &&  data.resRatings != ''
//                                   ? double.parse(data.resRatings!)
//                                   : 0.0,
//                               minRating: 0,
//                               direction: Axis.horizontal,
//                               allowHalfRating: true,
//                               itemCount: 5,
//                               itemSize: 13,
//                               ignoreGestures: true,
//                               unratedColor: Colors.grey,
//                               itemBuilder: (context, _) =>
//                                   Icon(Icons.star, color: appColorOrange),
//                               onRatingUpdate: (rating) {
//                                 print(rating);
//                               },
//                             ),
//                             data.resRatings != '0.0' && data.resRatings != ''
//                                 ? Container(
//                                     margin: EdgeInsets.only(left: 5.0),
//                                     height: 20.0,
//                                     width: 35.0,
//                                     decoration: BoxDecoration(
//                                       color: appColorWhite,
//                                       borderRadius: BorderRadius.circular(6.0),
//                                     ),
//                                     child: Center(
//                                         child: Text(
//                                       data.resRatings!,
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 10),
//                                     )),
//                                   )
//                                 : Container(),
//                           ],
//                         ),
//                         Text(data.resDesc!,
//                             style: TextStyle(fontSize: 12,color: Colors.grey.shade500),
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis)
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(width: 12.0),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
