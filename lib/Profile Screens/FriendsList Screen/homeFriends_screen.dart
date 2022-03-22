import 'package:discovret1_0/Components/background_screen.dart';
import 'package:discovret1_0/Components/discovret_scaffold.dart';
import 'package:discovret1_0/Components/widgets.dart';
import 'package:discovret1_0/FirebaseServices/db_models.dart';
import 'package:discovret1_0/Profile%20Screens/FriendsList%20Screen/all_friends_screen.dart';
import 'package:discovret1_0/Profile%20Screens/FriendsList%20Screen/friend_list_brain.dart';
import 'package:discovret1_0/Provider Services/profile_info_provider.dart';
import 'package:discovret1_0/Profile Screens/FriendsList%20Screen/FriendConfirmations_list.dart';
import 'package:discovret1_0/Profile Screens/FriendsList%20Screen/activeFriends_List.dart';
import 'package:discovret1_0/Profile Screens/FriendsList%20Screen/closeFriends_list.dart';
import 'package:discovret1_0/Profile Screens/FriendsList%20Screen/friend_search.dart';
import 'package:discovret1_0/Profile Screens/FriendsList%20Screen/inactiveFriends_list.dart';
import 'package:discovret1_0/Provider%20Services/provider_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:discovret1_0/Constants/discovret_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:discovret1_0/Components/icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FriendsList extends StatefulWidget {
  static const String id = 'FriendsListScreen';
  @override
  _FriendsListState createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList>
    with SingleTickerProviderStateMixin {

  // AnimationController controller;

  // @override
  // void initState() {
  //   super.initState();

  //   controller = AnimationController(
  //     animationBehavior: AnimationBehavior.normal,
  //     upperBound: 100.0,
  //     duration: Duration(seconds: 3),
  //     vsync: this,
  //   );
  //   controller.forward();
  //   controller.addListener(() {
  //     setState(() {});
  //     print(controller.value);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final UserProfileInfo userProfileInfo =
        Provider.of<UserProfileInfo>(context);
    final DbUserProfileInfo dbUserProfileInfo =
        Provider.of<DbUserProfileInfo>(context);
    final _dbListOfFriends = Provider.of<List<FriendListObject>>(context);
    final _dbUserConfirmations =
        Provider.of<List<ConfirmationsObject>>(context);
    final _dbAllFriendsList = Provider.of<List<AllFriendsObject>>(context);

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
              SizedBox(height: 5),
              Stack(
                clipBehavior: Clip.none,
                alignment: AlignmentDirectional.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Hero(
                      tag: 'Friends',
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.people_outline,
                          size: deviceWidth * .25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 14,
                    top: 3,
                    child: RawMaterialButton(
                      constraints: BoxConstraints(minHeight: 40, minWidth: 40),
                      onPressed: () {
                        Navigator.pushNamed(context, FriendSearch.id);
                      },
                      fillColor: Colors.white,
                      shape: CircleBorder(),
                      child:
                          Icon(Icons.search, size: 30, color: kDiscovretYellow),
                    ),
                  ),
                ],
              ),
              Divider(
                indent: 20,
                endIndent: 20,
                height: 10,
                color: kDiscovretYellow,
                thickness: 2.5,
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  "Friends: ${dbUserProfileInfo.allFriends!.length}"
                      .toUpperCase(),
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: 20,
                      letterSpacing: 1,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // CircularHeaderBox(
              //   color: null,
              //   textString: 'Friends',
              // ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FriendTypeCard(
                    assetImage: AssetImage('assets/profile5.jpg'),
                    headerText: 'Confirmations',
                    discCoinDesc: '0.25 Disc',
                    friendCount: _dbUserConfirmations.length,
                    onpress: () {
                      Navigator.pushNamed(context, FriendConfirmations.id);
                    },
                  ),
                  FriendTypeCard(
                    assetImage: AssetImage('assets/profile8.jpg'),
                    headerText: 'Close Friends',
                    discCoinDesc: '1 Disc',
                    friendCount: userProfileInfo.closeFriendsCount,
                    onpress: () {
                      Navigator.pushNamed(context, CloseFriendsList.id);
                    },
                  ),
                ],
              ),
              // SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FriendTypeCard(
                    assetImage: AssetImage('assets/profile13.jpg'),
                    headerText: 'Active Friends',
                    discCoinDesc: '0.25 Disc',
                    friendCount: userProfileInfo.activeFriendsCount,
                    onpress: () {
                      Navigator.pushNamed(context, ActiveFriendsList.id);
                      var test = userProfileInfo.listActiveFriends;
                      print(test);
                    },
                  ),
                  FriendTypeCard(
                    assetImage: AssetImage('assets/profile12.jpg'),
                    headerText: 'Inactive Friends',
                    discCoinDesc: '-0.25 Disc',
                    friendCount: userProfileInfo.inActiveFriendsCount,
                    onpress: () {
                      Navigator.pushNamed(context, InactiveFriendsList.id);
                    },
                  ),
                ],
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AllFriendsList.id);
                  },
                  child: Container(
                    child: Center(
                      child: Text(
                        'See All',
                        style: TextStyle(
                            letterSpacing: 0,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFF0B9320),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ));
  }
}
