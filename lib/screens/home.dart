import 'package:finalwireless/screens/map.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'signin.dart';

import 'send_report_widget.dart';
import 'getlocation.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  final FirebaseAuth auth = FirebaseAuth.instance;

  List<Widget> itemsData = [];

  @override
  void initState() {
    super.initState();
    print("init state for home");
   // getPostsData();
    controller.addListener(() {
      double value = controller.offset / 119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  Future signOut(BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.signOut();
    print("logout...");
    Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(builder: (context) => new Signin()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double categoryHeight = 140;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Emergency Caller"),
          elevation: 0,
          backgroundColor: Colors.blue,
          leading: IconButton(
              icon: Icon(Icons.logout, color: Colors.white),
              onPressed: () {
                print("before logout");
                signOut(context);
              }),
        ),

        body: Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "  WELCOME",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 43),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "     ${auth.currentUser!.email}",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SafeArea(
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MapScreen(),
                              ),
                          );
                        },
                            child: Image.asset(
                              'assets/images/doctor.png',
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                            ),
                       ),
                        Text(
                          'Find hospital and police station',
                        ),
                        Divider(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SendReport(),
                              ),
                            );
                          },
                          child: Image.asset(
                            'assets/images/alert.png',
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          'Send emergency report',
                        ),
                        Divider(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const GetUserLocation(),
                              ),
                            );
                          },
                          child: Image.asset(
                            'assets/images/compass.png',
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          'Get location',
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}

