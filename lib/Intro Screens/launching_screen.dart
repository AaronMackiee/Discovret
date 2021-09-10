import 'dart:async';
import 'package:discovret1_0/Constants/discovret_constants.dart';
import 'package:discovret1_0/Constants/init_mediaQuery.dart';
import 'package:discovret1_0/FirebaseServices/db_models.dart';
import 'package:discovret1_0/FirebaseServices/f_storage.dart';
import 'package:discovret1_0/Map%20Screens/map_home_screen.dart';
import 'package:discovret1_0/Provider Services/profile_info_provider.dart';
import 'package:discovret1_0/FirebaseServices/auth_service.dart';
import 'package:discovret1_0/FirebaseServices/db_services.dart';
import 'package:discovret1_0/LogIn Screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

class LaunchingScreen extends StatefulWidget {
  static const String id = 'LaunchingScreen';
  @override
  LaunchingScreenState createState() => LaunchingScreenState();
}

class LaunchingScreenState extends State<LaunchingScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  AuthService _auth = AuthService();
  final FirebaseStorageServices _fS = FirebaseStorageServices();

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () => getCurrentUserAndPush(context));
  }

  // void goHomepage(context) {
  //   Navigator.of(context).pushAndRemoveUntil(
  //       MaterialPageRoute(builder: (context) {
  //     return LogIn();
  //   }), (Route<dynamic> route) => false);
  //   //Navigate to home page and remove the intro screen history
  //   //so that "Back" button wont work.
  // }

  void getCurrentUserAndPush(context) async {
    try {
      final User? user = _auth.getUser;
      final UserProfileInfo userProfileInfo =
          Provider.of<UserProfileInfo>(context, listen: false);
      if (user != null) {
        // profileInfo.searchListCount = FirestoreService().getDiscSearchList().length;
        Navigator.pushReplacementNamed(context, MapHomeScreen.id);
      } else {
        Navigator.pushReplacementNamed(context, LogIn.id);
        print('navigated');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: InitMediaQuery(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
                center: Alignment.center,
                colors: [Color(0xFF0045FF), Colors.white],
                stops: [-1.5, 2.0],
                radius: 1.5,
                focalRadius: 2.0,
                tileMode: TileMode.clamp),
          ),
          child: Center(
            child: Hero(
              tag: 'Discover1',
              child: Container(
                height: size.width * .45,
                width: size.width * .45,
                child: Image.asset("assets/Disc_Map_NoBorders.png"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
