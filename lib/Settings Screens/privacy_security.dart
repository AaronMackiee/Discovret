import 'package:discovret1_0/Components/background_screen.dart';
import 'package:discovret1_0/Components/discovret_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:discovret1_0/Constants/discovret_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:discovret1_0/Components/icons.dart';

class PrivacySecurity extends StatefulWidget {
  static const String id = 'PrivacySecurityScreen';
  @override
  _PrivacySecurityState createState() => _PrivacySecurityState();
}

class _PrivacySecurityState extends State<PrivacySecurity> {
  @override
  Widget build(BuildContext context) {
    return DiscovretScaffold(
      index: 2,
      searchIconActive: Icon(Icons.person_search,
          color: kinactiveIconColor, size: kinactiveIconSize),
      mapIconActive: Icon(MyFlutterApp.discovretmapicon,
          color: kinactiveIconColor, size: kinactiveIconSize),
      profileIconActive: Icon(Icons.account_circle_sharp,
          color: kinactiveIconColor, size: kinactiveIconSize),
      settingsIconColor: kDiscovretGreen,
      settingsIconSize: 38,
      qrIconColor: kinactiveIconColor,
      qrIconSize: kinactiveIconSize,
      body: DiscovretBackground(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 1000,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    border: Border.all(color: Color(0xFFECC84B), width: 2.5),
                  ),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Privacy & Security',
                            style: TextStyle(
                                letterSpacing: 5,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'First let me recognize that Polaris is a collaborative business and we like to have visibility within the company where our values are recognized with our decision and that they are important to our partners and the extensions of our business. This is why I would consider Polaris staying in the United States. For starters there is the quickness and ease of collaboration between design engineers and technical staff in manufacturing plants. Also, based on pro forma financials, it has the lowest initial costs and highest profit. Our biggest concern is that our economy is slowing down, which means we shouldn’t be making a big investment right now. Our demand for Side-by-Side is forecasted to flatline which means there’s a likelihood that a new manufacturing plant for Side-by-Side wouldn’t help our profits. There are concerns about staying in America which would be the manufacturing talent gap caused by the concern from young students because of the location of our Polaris manufacturing sites in a small town with only Polaris as the only big company. But currently we don’t need to hire any new employees because of the economic slowdown. Once the economy looks promising again, that is when I would maybe consider moving on of the sites closer to our distribution centers.',
                          style: TextStyle(
                              letterSpacing: 0,
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  child: Center(
                    child: Text(
                      'Ok',
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
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
