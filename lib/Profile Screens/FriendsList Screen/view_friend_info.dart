import 'package:discovret1_0/Components/background_screen.dart';
import 'package:discovret1_0/Components/discovret_scaffold.dart';
import 'package:discovret1_0/Components/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:discovret1_0/Constants/discovret_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:discovret1_0/Components/icons.dart';
import 'package:google_fonts/google_fonts.dart';

class FriendInfo extends StatefulWidget {
  static const String id = 'FriendInfoScreen';
  @override
  _FriendInfoState createState() => _FriendInfoState();
}

class _FriendInfoState extends State<FriendInfo> {
  String? content;

  @override
  Widget build(BuildContext context) {
    return DiscovretScaffold(
      index: 2,
      searchIconActive: Icon(Icons.person_search,
          color: kDiscovretYellow, size: kactiveIconSize),
      mapIconActive: Icon(MyFlutterApp.discovretmapicon,
          color: kDiscovretBlue, size: kactiveIconSize),
      profileIconActive: Icon(Icons.account_circle_sharp,
          color: kDiscovretGreen, size: kactiveIconSize),
      settingsIconColor: kinactiveIconColor,
      settingsIconSize: kinactiveIconSize,
      qrIconColor: kinactiveIconColor,
      qrIconSize: kinactiveIconSize,
      body: DiscovretBackground(
        child: ListView(
          shrinkWrap: true,
          children: [
            Column(
              children: [
                SizedBox(height: 5),
                Container(
                  height: kDiscovretIconSize,
                  width: kDiscovretIconSize,
                  child: Image.asset("assets/discovret_icon.png"),
                ),
                CircularHeaderBox(
                  color: null,
                  textString: 'About Info',
                ),
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Bio:',
                      style: TextStyle(
                          fontSize: 17,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  height: 130,
                  margin: EdgeInsets.all(5),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'Changing the world with an everday smile!',
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                Divider(
                  color: Colors.blueGrey,
                ),
                ClearInfoInputCard(
                    textStringParent: "Age:", textStringchild: '26'),
                Divider(
                  color: Colors.blueGrey,
                ),
                ClearInfoInputCard(
                    textStringParent: "Gender:", textStringchild: 'Male'),
                Divider(
                  color: Colors.blueGrey,
                ),
                ClearInfoInputCard(
                    textStringParent: "Interested In:",
                    textStringchild: 'Women'),
                Divider(
                  color: Colors.blueGrey,
                ),
                ClearInfoInputCard(
                    textStringParent: "Relationship\nStatus:",
                    textStringchild: 'Married'),
                SizedBox(height: 20),
                ClearInfoInputCard(
                    textStringParent: "languages:",
                    textStringchild: 'Engish, Chuukese, Yapese, Spanish'),
                Divider(
                  color: Colors.blueGrey,
                ),
                ClearInfoInputCard(
                    textStringParent: "Ethnicity:",
                    textStringchild: 'American'),
                Divider(
                  color: Colors.blueGrey,
                ),
                ClearInfoInputCard(
                    textStringParent: "Country of\nBirth:",
                    textStringchild: 'America'),
                Divider(
                  color: Colors.blueGrey,
                ),
                ClearInfoInputCard(
                    textStringParent: "Religion",
                    textStringchild:
                        'The Church of Jesus Christ of Latter Day Saints'),
                Divider(
                  color: Colors.blueGrey,
                ),
                ClearInfoInputCard(
                    textStringParent: "Ideas/Beliefs",
                    textStringchild:
                        'Pro-Life, Creationist, Anti-Global Warming'),
                Divider(
                  color: Colors.blueGrey,
                ),
                ClearInfoInputCard(
                    textStringParent: "Interest:",
                    textStringchild:
                        'Family, Faith, Service, Outdoor Activities, Coding, Supply Chain, Business'),
                Divider(
                  color: Colors.blueGrey,
                ),
                ClearInfoInputCard(
                    textStringParent: "Skills:",
                    textStringchild:
                        'Programming, Hair Cutting, Cooking, Business'),
                Divider(
                  color: Colors.blueGrey,
                ),
                ClearInfoInputCard(
                    textStringParent: "Mentoring in:",
                    textStringchild: 'Depression, Job Searching'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
