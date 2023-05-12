import 'dart:convert';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/global/sizeconfig.dart';
import 'package:demo_project/src/models/filter_model.dart';
import 'package:demo_project/src/models/home_model.dart';
import 'package:demo_project/src/screens/layout/filterRes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SelectFilter extends StatefulWidget {
  @override
  _SelectFilterState createState() => _SelectFilterState();
}

class _SelectFilterState extends State<SelectFilter> {
  // bool checkedValue = false;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var array = [];
  var rat;
  HomeModel? homeModel;
  bool isLoading = false;
  @override
  void initState() {
    _getCat();

    super.initState();
  }

  _getCat() async {
    if (mounted)
      setState(() {
        isLoading = true;
      });

    var uri = Uri.parse('${baseUrl()}home');
    var request = new http.MultipartRequest("GET", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    // request.fields.addAll({'user_id': userID});
    // request.fields['user_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    homeModel = HomeModel.fromJson(userData);
    print("+++++++++");
    print(responseData);
    print("+++++++++");
    if (mounted)
      setState(() {
        isLoading = false;
      });
  }

  String price = '';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Container(
        //  decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage('assets/images/back.jpg'),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              title: Text(
                "Filter",
                style: TextStyle(color: appColorBlack),
              ),
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                ),
              ),
            ),
            body: isLoading
                ? Center(
                    child: CircularProgressIndicator(color: appColorBlack),
                  )
                : homeModel!.category != null
                    ? SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 10, left: 20),
                              child: Text(
                                "Categories",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal! * 5),
                              ),
                            ),
                            Container(
                                width: SizeConfig.screenWidth,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: homeModel!.category!.length,
                                  //scrollDirection: Axis.horizontal,
                                  // itemBuilder: (context, int index) => Column(
                                  //   children: <Widget>[
                                  //     Container(
                                  //       // padding: EdgeInsets.only(top: 10),
                                  //       child: Material(
                                  //         color: index % 2 == 0
                                  //             ? Color(0XFF062C3C)
                                  //             : Color(0XFF003E4F),
                                  //         child: Center(
                                  //           child: widgetCatedata(allRestaurent[index]),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  itemBuilder: (context, int index) {
                                    return //Text(allcategory.coursesList[index].firstName[0]);
                                        widgetCatedata(
                                            homeModel!.category![index]);
                                  },

                                  // {
                                  //   return InkWell(
                                  //     onTap: () {},
                                  //     child:
                                  //   );
                                  // },
                                )),
                            Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Price",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal! *
                                                5),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.45,
                                              child: Text(
                                                'Below \$100',
                                                style: TextStyle(
                                                    fontSize: SizeConfig
                                                            .blockSizeHorizontal! *
                                                        4),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      price == '1'
                                          ? InkWell(
                                              onTap: () {
                                                setState(() {
                                                  price = '';
                                                });
                                              },
                                              child: Icon(Icons.check_box))
                                          : InkWell(
                                              onTap: () {
                                                setState(() {
                                                  price = '1';
                                                });
                                              },
                                              child: Icon(Icons
                                                  .check_box_outline_blank))
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.45,
                                              child: Text(
                                                '\$100- \$500',
                                                style: TextStyle(
                                                    fontSize: SizeConfig
                                                            .blockSizeHorizontal! *
                                                        4),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      price == '2'
                                          ? InkWell(
                                              onTap: () {
                                                setState(() {
                                                  price = '';
                                                });
                                              },
                                              child: Icon(Icons.check_box))
                                          : InkWell(
                                              onTap: () {
                                                setState(() {
                                                  price = '2';
                                                });
                                              },
                                              child: Icon(Icons
                                                  .check_box_outline_blank))
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.45,
                                              child: Text(
                                                '\$500- \$1000',
                                                style: TextStyle(
                                                    fontSize: SizeConfig
                                                            .blockSizeHorizontal! *
                                                        4),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      price == '3'
                                          ? InkWell(
                                              onTap: () {
                                                setState(() {
                                                  price = '';
                                                });
                                              },
                                              child: Icon(Icons.check_box))
                                          : InkWell(
                                              onTap: () {
                                                setState(() {
                                                  price = '3';
                                                });
                                              },
                                              child: Icon(Icons
                                                  .check_box_outline_blank))
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.45,
                                              child: Text(
                                                'Above \$1000',
                                                style: TextStyle(
                                                    fontSize: SizeConfig
                                                            .blockSizeHorizontal! *
                                                        4),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      price == '4'
                                          ? InkWell(
                                              onTap: () {
                                                setState(() {
                                                  price = '';
                                                });
                                              },
                                              child: Icon(Icons.check_box))
                                          : InkWell(
                                              onTap: () {
                                                setState(() {
                                                  price = '4';
                                                });
                                              },
                                              child: Icon(Icons
                                                  .check_box_outline_blank))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Center(
                                child: CupertinoButton(
                                  onPressed: () async {
                                    setState(() {
                                      isLoading=true;
                                    });
                                    if (array.length > 0
                                        // && rat != null
                                        ) {
                                      print(array);
                                      print(rat);
                                      try {
                                        String url = '${baseUrl()}filter';

                                        final headers = {
                                          "Accept": "application/json",
                                          "Content-Type":
                                              "application/x-www-form-urlencoded"
                                        };

                                        final form = [];

                                        for (var value in array) {
                                          form.add("category[]=$value");
                                        }

                                        form.add("price=$price");

                                        final body = form.join('&');

                                        final response = await http.post(
                                            Uri.parse(url),
                                            headers: headers,
                                            body: body);
                                        print(json.decode(response.body));

                                        if (response.statusCode == 200) {
                                          setState(() {
                                            isLoading=false;
                                          });
                                          SharedPreferences preferences =
                                              await SharedPreferences
                                                  .getInstance();
                                          preferences.remove('filter');
                                          Map<String, dynamic> data = json
                                              .decode(response.body.toString());
                                          String user = jsonEncode(
                                              FilterModel.fromJson(data));
                                          preferences.setString('filter', user);
                                          //  print(json.decode(response.body));

                                          array.clear();
                                          setState(() {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FilterRes()),
                                            );
                                          });

                                          return json.decode(response.body);
                                        }

                                        return null;
                                      } catch (exception) {
                                        print(exception);

                                        return null;
                                      }
                                    } else {
                                      // Toast.show("Select category to continue",
                                      //     context,
                                      //     duration: Toast.LENGTH_SHORT,
                                      //     gravity: Toast.BOTTOM);
                                      Fluttertoast.showToast(
                                          msg: "Select category to continue",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.grey.shade200,
                                          textColor: Colors.black,
                                          fontSize: 13.0);
                                          setState(() {
                                            isLoading=false;
                                          });
                                    }
                                  },
                                  color: appColorBlack,
                                  borderRadius: new BorderRadius.circular(30.0),
                                  child: new Text(
                                    "Apply Filters",
                                    textAlign: TextAlign.center,
                                    style: new TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      )
                    : Container()),
      ),
    );
  }

  Widget widgetCatedata(Category data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width * 0.75,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  padding: const EdgeInsets.all(10.0),
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 10,
                        // offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                      child: new Image.network(
                    data.icon!,
                    width: 20,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                          child: SizedBox(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                        height: 10.0,
                        width: 10.0,
                      ));
                    },
                  )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Text(
                    data.cName!,
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal! * 4),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
          array.contains(data.id)
              ? Expanded(
                  child: Checkbox(
                    // color of tick Mark
                    activeColor: Colors.black,
                    // value: data.dataV = true,
                    value: true,
                    onChanged: (bool? newValue) {
                      setState(() {
                        array.remove(data.id);
                      });
                    },
                  ),
                )
              : Expanded(
                  child: Checkbox(
                    // value: data.dataV = false,
                    value: false,
                    onChanged: (bool? newValue) {
                      setState(() {
                        array.add(data.id);
                      });
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
