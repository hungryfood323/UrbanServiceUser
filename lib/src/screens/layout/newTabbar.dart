import 'dart:convert';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/screens/layout/cart.dart';
import 'package:demo_project/src/screens/layout/multihome.dart';
import 'package:demo_project/src/screens/layout/new_layouts_product/categoryList.dart';
import 'package:demo_project/src/screens/layout/profile.dart';
import 'package:demo_project/src/screens/layout/serviceList.dart';
import 'package:demo_project/src/share_preference/preferencesKey.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class TabbarScreen extends StatefulWidget {
  //int currentIndex;

  @override
  _TabbarScreenState createState() => _TabbarScreenState();
}

class _TabbarScreenState extends State<TabbarScreen> {
  int _currentIndex = 0;

//   List<dynamic> _handlePages = [
//     // ServiceListScreen(),

//     MultiHome(),
//     ServiceList(),

//     // StoreScreen(),
//     ProductCategory(),

// //BookingList(),

//     Profile(),
//   ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentIndex = MultiHome();
  @override
  void initState() {
    if (preferences!.containsKey("guest user")) {
      print("guest user login");
      setState(() {
        userID = preferences!.getString('guest user')!;
      });
    } else {
      getUserDataFromPrefs();
    }

    super.initState();
  }

  getUserDataFromPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userDataStr =
        preferences.getString(SharedPreferencesKey.LOGGED_IN_USERRDATA);
    Map<String, dynamic> userData = json.decode(userDataStr!);
    print(userData);

    setState(() {
      userID = userData['user_id'];
    });
  }

  bool isLoading = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
      bucket: bucket,
       child: currentIndex),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appColorBlack,
        child: Image.asset(
          'assets/images/cart.png',
          height: 22,
          width: 23,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GetCartScreeen(
                // back: true,
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 5,
          child: Container(
             height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialButton(
                        minWidth: 30,
                        onPressed: (){
                          setState(() {
                            currentIndex = MultiHome();
                          _currentIndex = 0;
                          }); 
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _currentIndex == 0
                             ? Image.asset('assets/images/Home_Dark.png',
                             height: 23,
                             
                            )
                            : Image.asset('assets/images/Home_Outlined.png',
                            height: 23,
                            ),
                            _currentIndex == 0
                            ?  Text('Home')
                            : Text(''),
                          ],
                        ),
                        ),

                         MaterialButton(
                          minWidth: 30,
                        onPressed: (){
                          setState(() {
                            currentIndex = ServiceList();
                          _currentIndex = 1;
                          }); 
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _currentIndex == 1
                             ? Image.asset('assets/images/Service_Dark.png',
                             height: 27,
                             
                            )
                            : Image.asset('assets/images/Service_Outlined.png',
                            height: 27,
                            ),
                            _currentIndex == 1
                            ?  Text('Service')
                            : Text(''),
                          ],
                        ),
                        )
                    ],
                  ),
                ),
                // right side row
                 Padding(
                   padding: const EdgeInsets.only(top: 4),
                   child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialButton(
                         minWidth: 30,
                        onPressed: (){
                          setState(() {
                            currentIndex = ProductCategory();
                          _currentIndex = 2;
                          }); 
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _currentIndex == 2
                             ? Image.asset('assets/images/Product_Dark.png',
                             height: 30,
                             
                            )
                            : Image.asset('assets/images/Product_Outlined.png',
                            height: 30,
                            ),
                            _currentIndex == 2
                            ?  Text('Product')
                            : Text(''),
                          ],
                        ),
                        ),

                         MaterialButton(
                           minWidth: 30,
                        onPressed: (){
                          setState(() {
                            currentIndex = Profile();
                          _currentIndex = 3;
                          }); 
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _currentIndex == 3
                             ? Image.asset('assets/images/Profile_Dark.png',
                             height: 23,
                             
                            )
                            : Image.asset('assets/images/Profile_Outlined.png',
                            height: 23,
                            ),
                            _currentIndex == 3
                            ?  Text('Profile')
                            : Text(''),
                          ],
                        ),
                        )
                    ],
                ),
                 )
              ],
            ),
          ),
          // selectedIconTheme: IconThemeData(color: appColorBlack),
          // selectedItemColor: appColorBlack,
          // selectedFontSize: 12,
          // unselectedFontSize: 12,
          // selectedLabelStyle:
          //     TextStyle(fontWeight: FontWeight.bold, color: appColorBlack),
          // backgroundColor: Colors.white,
          // type: BottomNavigationBarType.fixed,
          // currentIndex: _currentIndex,
          // onTap: (index) {
          //   setState(() {
          //     _currentIndex = index;
          //   });
          // },
          // items: <BottomNavigationBarItem>[
          //   _currentIndex == 0
          //       ? BottomNavigationBarItem(
          //           icon: Image.asset(
          //             'assets/images/Home_Dark.png',
          //             height: 23,
          //           ),
          //           label: "Home")
          //       : BottomNavigationBarItem(
          //           icon: Image.asset(
          //             'assets/images/Home_Outlined.png',
          //             height: 23,
          //           ),
          //           label: ""),

          //   _currentIndex == 1
          //       ? BottomNavigationBarItem(
          //           icon: Image.asset(
          //             'assets/images/Service_Dark.png',
          //             height: 27,
          //           ),
          //           label: "Services")
          //       : BottomNavigationBarItem(
          //           icon: Image.asset(
          //             'assets/images/Service_Outlined.png',
          //             height: 27,
          //           ),
          //           label: ""),

          //   _currentIndex == 2
          //       ? BottomNavigationBarItem(
          //           icon: Image.asset(
          //             'assets/images/Product_Dark.png',
          //             height: 28,
          //           ),
          //           label: "Product")
          //       : BottomNavigationBarItem(
          //           icon: Image.asset(
          //             'assets/images/Product_Outlined.png',
          //             height: 28,
          //           ),
          //           label: ""),

          //   _currentIndex == 3
          //       ? BottomNavigationBarItem(
          //           icon: Image.asset(
          //             'assets/images/Profile_Dark.png',
          //             height: 23,
          //           ),
          //           label: "Profile")
          //       : BottomNavigationBarItem(
          //           icon: Image.asset(
          //             'assets/images/Profile_Outlined.png',
          //             height: 23,
          //           ),
          //           label: ""),

          //   // _currentIndex == 4
          //   //     ? BottomNavigationBarItem(
          //   //         icon: Image.asset(
          //   //           'assets/images/user1.jpg',
          //   //           height: 25,

          //   //         ),
          //   //         label: "Profile")
          //   //     : BottomNavigationBarItem(
          //   //         icon: Image.asset(
          //   //           'assets/images/profile111.jpg',
          //   //           height: 25,
          //   //         ),
          //   //         label: ""),
          // ],
        ),
      ),
    );
  }
}
