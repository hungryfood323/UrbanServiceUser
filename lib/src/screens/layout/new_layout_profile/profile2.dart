import 'package:demo_project/src/global/global.dart';
import 'package:flutter/material.dart';

class Profile10 extends StatefulWidget {
  const Profile10({Key? key}) : super(key: key);

  @override
  State<Profile10> createState() => _Profile10State();
}

class _Profile10State extends State<Profile10> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          "Profile",
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
        child: Container(
            child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Stack(children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover, image: AssetImage('assets/images/unknown.png'))),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20,
                        ),
                      ))
                ]),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                 Icon(
                  Icons.person_outlined,
                  color: Colors.black,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30,left: 10),
                    child: TextField(
                       style: TextStyle(
                    color: Colors.black,
                    fontSize: 16),
                      textAlign: TextAlign.start,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      cursorColor: Colors.grey,                     
                      decoration: InputDecoration(
                        labelText: 'Enter Name',
                        labelStyle: TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.only(bottom: 0),
                        focusColor: Colors.black,
                        
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                 Icon(
                  Icons.mail_outline_outlined,
                  color: Colors.black,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30,left: 10),
                    child: TextField(
                       style: TextStyle(
                    color: Colors.black,
                    fontSize: 16),
                      textAlign: TextAlign.start,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        labelText: 'Enter Email',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusColor: Colors.grey,
                        
                      ),
                    ),
                  ),
                ),
              ],
            ),
             SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                 Icon(
                  Icons.phone_outlined,
                  color: Colors.black,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30,left: 10),
                    child: TextField(
                      style: TextStyle(
                    color: Colors.black,
                    fontSize: 16),
                      textAlign: TextAlign.start,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        labelText: 'Enter Mobile no.',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusColor: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
             SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                 Icon(
                  Icons.location_on_outlined,
                  color: Colors.black,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30,left: 10),
                    child: TextField(
                       style: TextStyle(
                    color: Colors.black,
                    fontSize: 16),
                      textAlign: TextAlign.start,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        labelText: 'Enter Address',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusColor: Colors.grey,
                       
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 150),
              child: ElevatedButton(
                  onPressed: () async {},
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.white30),
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all(const Size(400, 50)),
                  ),
                  child: Text(
                    "Save",
                  )),
            ),
          ],
        )),
      ),
    );
  }
}
