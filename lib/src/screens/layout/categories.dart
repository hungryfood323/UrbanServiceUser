import 'package:demo_project/src/blocs/home_bloc.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/models/home_model.dart';
import 'package:demo_project/src/screens/layout/catWiseSeviceList.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => new _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  var isLoading = false;

  @override
  void initState() {
    homeBloc.homeSink();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      backgroundColor: appColorWhite,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: appColorWhite,
        elevation: 2,
        title: Text(
          "Category",
          style: TextStyle(
              fontSize: 20, color: appColorBlack, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [],
      ),
      body: StreamBuilder<HomeModel>(
          stream: homeBloc.homeStream,
          builder: (context, AsyncSnapshot<HomeModel> snapshot) {
            if (!snapshot.hasData) {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 1.5,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      primary: false,
                      // padding: EdgeInsets.all(10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 200 / 220,
                      ),
                      itemCount: snapshot.data!.category!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return categoryWidget(snapshot.data!.category![index]);
                      },
                    )),
              ],
            );
          }),
    ));
  }

  Widget categoryWidget(Category data) {
    return Container(
        height: MediaQuery.of(context).size.height * 3 / 10,
        child: Padding(
          padding: EdgeInsets.all(2),
          child: InkWell(
            onTap: () {
              print(data.id);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CategoryWiseServiceList(data.id)));
            },
            child: Card(
              elevation: 1.0,
              shadowColor: Colors.black,
              color: Colors.grey.shade200,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(08),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 60,
                      width: 60,
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(12),
                      //   color: appColorGreen,
                      // ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.network(
                          data.icon!,
                          //fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                                child:
                                    CircularProgressIndicator(strokeWidth: 2));
                          },
                          //color: iconColor,
                        ),
                      )),
                  Container(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text(
                      data.cName!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: appColorBlack,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(height: 5),
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
        ));
  }
}
