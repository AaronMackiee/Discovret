import 'dart:convert';
import 'dart:typed_data';
import 'package:discovret1_0/Components/icons.dart';
import 'package:discovret1_0/FirebaseServices/f_storage.dart';
import 'package:discovret1_0/Map Screens/map_home_screen.dart';
import 'package:discovret1_0/Provider Services/account_info_provider.dart';
import 'package:discovret1_0/Provider Services/profile_info_provider.dart';
import 'package:discovret1_0/FirebaseServices/auth_service.dart';
import 'package:discovret1_0/FirebaseServices/db_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_circular_text/circular_text.dart';
import 'package:flutter_circular_text/circular_text/model.dart';
import 'package:flutter_circular_text/circular_text/widget.dart';
import 'package:discovret1_0/Constants/discovret_constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class LogIn extends StatefulWidget {
  static const String id = 'LogInScreen';
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> with SingleTickerProviderStateMixin {
  // AnimationController controller;
  AuthService _auth = AuthService();
  bool showSpinner = false;
  final FirebaseStorageServices _fS = FirebaseStorageServices();

  @override
  void initState() {
    _auth.getUser;
    super.initState();
  }

  //   controller = AnimationController(
  //     upperBound: 130.0,
  //     duration: Duration(seconds: 1),
  //     vsync: this,
  //   );
  //   controller.forward();
  //   controller.addListener(() {
  //     setState(() {});
  //     print(controller.value);
  //   });

  @override
  Widget build(BuildContext context) {
    final UserAccountInfo userAccountInfo =
        Provider.of<UserAccountInfo>(context);
    final UserProfileInfo userProfileInfo =
        Provider.of<UserProfileInfo>(context);
    // final DbUserProfileInfo dbUserProfileInfo =
    //     Provider.of<DbUserProfileInfo>(context);
    // final DbUserProfileSearchInfo dbUserProfileSearchInfo =
    //     Provider.of<DbUserProfileSearchInfo>(context);
    // profileInfo.profilePicture = 'assets/profile1.jpg';
    return Scaffold(
      body: LoadingOverlay(
        isLoading: showSpinner,
        progressIndicator: CircularProgressIndicator(
          color: kDiscovretGreen,
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.1, 0.5, 0.7, 0.9],
              colors: [
                Color(0xFF0045FF),
                Color(0xC20044FF),
                Color(0x7C0044FF),
                Color(0x330044FF),
              ],
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: SafeArea(
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(height: 10),
                Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: AlignmentDirectional.center,
                      children: [
                        CircularText(
                          children: [
                            // TextItem(
                            //   text: Text(
                            //     'Discovret'.toUpperCase(),
                            //     style: TextStyle(
                            //         letterSpacing: 5,
                            //         fontSize: 40,
                            //         color: Colors.white,
                            //         fontWeight: FontWeight.bold),
                            //   ),
                            //   space: 12,
                            //   startAngle: -90,
                            //   startAngleAlignment: StartAngleAlignment.center,
                            //   direction: CircularTextDirection.clockwise,
                            // ),
                            TextItem(
                              text: Text(
                                "Discover > Understand > Uplift".toUpperCase(),
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFFECC84B),
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              space: 7,
                              startAngle: 89,
                              startAngleAlignment: StartAngleAlignment.center,
                              direction: CircularTextDirection.anticlockwise,
                            ),
                          ],
                          radius: kDiscovretIconSize,
                          position: CircularTextPosition.outside,
                          backgroundPaint: Paint()..color = Colors.transparent,
                        ),
                        Positioned(
                          top: 9,
                          child: Row(
                            children: [
                              Icon(DiscMapOutline.disc_map_outline1,
                                  color: Colors.white, size: 44),
                              Text(
                                'iscovret',
                                style: GoogleFonts.markoOne(
                                  textStyle: TextStyle(
                                      fontSize: 40,
                                      letterSpacing: 5,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 25,
                          child: Container(
                            height: kDiscovretIconSize,
                            width: kDiscovretIconSize,
                            child: Image(
                              fit: BoxFit.contain,
                              image:
                                  AssetImage("assets/Disc_Map_NoBorders.png"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 40),
                SizedBox(height: 30),
                Column(
                  children: [
                    // Text(dbUserProfileSearchInfo.languages.first),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            final user = await _auth.signInWithEmailPassword(
                                email: userAccountInfo.email!,
                                password: userAccountInfo.password!);
                            if (user.user!.email == userAccountInfo.email) {
                              // final imageUrl = await _fS.downloadProfilePhoto();
                              // userProfileInfo.profilePicture = imageUrl;
                              _auth.getUser;
                              Navigator.pushNamedAndRemoveUntil(
                                  context, MapHomeScreen.id, (route) => false);
                            }
                            setState(() {
                              showSpinner = false;
                            });
                            print(userProfileInfo.profilePicture);
                          } catch (e) {
                            print(e);
                            showSpinner = false;
                          }
                        },
                        child: Container(
                          height: 35,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                  fontSize: 20,
                                  letterSpacing: 2.75,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: kDiscovretGreen,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2.5,
                                blurRadius: 2.5,
                              ),
                            ],
                            // border:
                            //     Border.all(color: Color(0xFFECC84B), width: 2.5),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child: Center(
                          child: TextField(
                            onChanged: (value) {
                              userAccountInfo.email = value;
                            },
                            textAlign: TextAlign.center,
                            // autofocus: true,
                            style:
                                TextStyle(color: Colors.blueGrey, fontSize: 17),
                            decoration: InputDecoration.collapsed(
                              hintText: "",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        height: 45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    Text(
                      'Email',
                      style: TextStyle(
                        letterSpacing: 5,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child: Center(
                          child: TextField(
                            onChanged: (value) {
                              userAccountInfo.password = value;
                            },
                            textAlign: TextAlign.center,
                            // autofocus: true,
                            style:
                                TextStyle(color: Colors.blueGrey, fontSize: 17),
                            decoration: InputDecoration.collapsed(
                              hintText: "",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        height: 45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                    Text(
                      'Password',
                      style: TextStyle(
                        letterSpacing: 5,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'CreateAccountScreen');
                        },
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Create Account',
                                style: TextStyle(
                                    letterSpacing: 5,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        print(userProfileInfo.profilePicture);
                                        Navigator.pushNamed(
                                            context, 'PersonalAccountScreen');
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 115,
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 3),
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Icon(
                                                    Icons
                                                        .account_circle_outlined,
                                                    color: Colors.white,
                                                    size: 19,
                                                  ),
                                                ),
                                              ),
                                              FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  'Personal',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      letterSpacing: 1,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Color(0xFF0B9320),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        height: 35,
                                        width: 115,
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 3),
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Icon(
                                                    Icons.store_outlined,
                                                    color: Colors.white,
                                                    size: 19,
                                                  ),
                                                ),
                                              ),
                                              FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  'Business',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      letterSpacing: 1,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Color(0xFF0B9320),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            border: Border.all(
                                color: Color(0xFFECC84B), width: 2.5),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Forgot Password',
                      style: TextStyle(
                          letterSpacing: 5,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                          // color: Color(0xFFECC84B),
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
