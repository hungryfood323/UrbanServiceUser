import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_project/src/blocs/servicelist_bloc.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/global/sizeconfig.dart';
import 'package:demo_project/src/models/serviceList_model.dart';


import 'package:flutter/material.dart';



class ProductCategory extends StatefulWidget {
  @override
  ProductCategoryState createState() => ProductCategoryState();
}

class ProductCategoryState extends State<ProductCategory> {
  @override
  void initState() {
    _pullRefresh();
    super.initState();
  }

  Future<void> _pullRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      serviceBloc.serviceSink();
    });
    // why use freshWords var? https://stackoverflow.com/a/52992836/2301224
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          "Product Category",
          style: TextStyle(color: appColorBlack, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        color: appColorBlack,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              StreamBuilder<ServiceListModel>(
                  stream: serviceBloc.serviceListStream,
                  builder: (context, AsyncSnapshot<ServiceListModel> snapshot) {
                    if (!snapshot.hasData) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height / 1.5,
                        child: Center(
                          child:
                              CircularProgressIndicator(color: appColorBlack),
                        ),
                      );
                    }
                    List<Services>? allService = snapshot.data!.services != null
                        ? snapshot.data!.services
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
                                  "assets/images/noservice.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Text(
                                "Don't have any Service",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ));
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget serviceCard(Services data) {
    // String? id = data.id;
    //print("id: "+id);
    return InkWell(
        onTap: () {
          // print("click");
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => ServiceDetailScreen(id!)),
          // );
        },
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
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
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              //color: Colors.redAccent,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: data.serviceImage!,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
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
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              appColorBlack),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Center(child: Text('Image Not Found')),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Text(
                              data.serviceName!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ))));
  }
}
