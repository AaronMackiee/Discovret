
import 'package:flutter/material.dart';
import 'package:flutter_circular_text/circular_text.dart';
import 'package:flutter_circular_text/circular_text/model.dart';
import 'package:flutter_circular_text/circular_text/widget.dart';
import 'package:discovret1_0/Constants/discovret_constants.dart';

class BusinessAccount extends StatefulWidget {
  static const String id = 'BusinessAccountScreen';
  @override
  _BusinessAccountState createState() => _BusinessAccountState();
}

class _BusinessAccountState extends State<BusinessAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: ListView(
          children: [
            SizedBox(height: 1),
            Column(
              children: [
                SizedBox(height: 20),
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
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFFECC84B),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          space: 7,
                          startAngle: 89,
                          startAngleAlignment: StartAngleAlignment.center,
                          direction: CircularTextDirection.anticlockwise,
                        ),
                      ],
                      radius: 100,
                      position: CircularTextPosition.outside,
                      backgroundPaint: Paint()..color = Colors.transparent,
                    ),
                    Positioned(
                      top: 1,
                      child: Text(
                        'Discovret'.toUpperCase(),
                        style: TextStyle(
                            letterSpacing: 5,
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      left: -100,
                      top: -25,
                      // top: 4,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_sharp,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        iconSize: 30,
                      ),
                    ),
                    Positioned(
                      bottom: 25,
                      child: Container(
                        height: 130,
                        width: 130,
                        child: Image(
                          fit: BoxFit.contain,
                          image: AssetImage("assets/Disc_Map.png"),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 60),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                          fontSize: 25,
                          letterSpacing: 2.75,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: Center(
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blueGrey, fontSize: 17),
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
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blueGrey, fontSize: 17),
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: Center(
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blueGrey, fontSize: 17),
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
                  'Confirm Password',
                  style: TextStyle(
                    letterSpacing: 5,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'MapHomeScreen');
                    },
                    child: Container(
                      child: Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              letterSpacing: 5,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFF0B9320),
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
