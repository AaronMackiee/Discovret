import 'package:discovret1_0/Components/background_screen.dart';
import 'package:discovret1_0/Components/discovret_scaffold.dart';
import 'package:discovret1_0/Components/widgets.dart';
import 'package:discovret1_0/Provider Services/profile_info_provider.dart';
import 'package:discovret1_0/Profile Screens/FriendsList%20Screen/view_friend_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:discovret1_0/Constants/discovret_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:discovret1_0/Components/icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'friend_search.dart';

class ActiveFriendsList extends StatefulWidget {
  static const String id = 'activeFriendsListScreen';
  @override
  _ActiveFriendsListState createState() => _ActiveFriendsListState();
}

class _ActiveFriendsListState extends State<ActiveFriendsList> {
  @override
  Widget build(BuildContext context) {
    final UserProfileInfo userProfileInfo =
        Provider.of<UserProfileInfo>(context);

    Widget? nullSafetyWidget(
        {int? count, Widget? nullWidget, Widget? unNullWidget}) {
      if (count == 0) {
        return nullWidget;
      } else
        return unNullWidget;
    }

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
          children: [
            SizedBox(height: 20),
            Stack(
              clipBehavior: Clip.none,
              alignment: AlignmentDirectional.center,
              children: [
                Hero(
                  tag: 'Friends:',
                  child: Icon(
                    Icons.people_outline,
                    size: deviceWidth * .25,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  left: 14,
                  top: -2,
                  child: RawMaterialButton(
                    constraints: BoxConstraints(minHeight: 40, minWidth: 40),
                    onPressed: () {
                      setState(() {
                        Navigator.pushNamed(context, FriendSearch.id);
                      });
                    },
                    fillColor: Colors.white,
                    shape: CircleBorder(),
                    child:
                        Icon(Icons.search, size: 30, color: kDiscovretYellow),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(
              indent: 20,
              endIndent: 20,
              height: 10,
              color: kDiscovretYellow,
              thickness: 2.5,
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 25, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Active Friends: 12".toUpperCase(),
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 20,
                        letterSpacing: 1,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // SizedBox(
            //   height: 15,
            // ),
            // CircularHeaderBox(
            //   color: null,
            //   textString: 'Active Friends',
            // ),
            SizedBox(
              height: 25,
            ),
            FriendTypeInfoCard('1 visit per year = 0.25 Disc coin'),
            SizedBox(
              height: 10,
            ),
            nullSafetyWidget(
              count: userProfileInfo.activeFriendsCount,
              nullWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: kDiscovretIconSize,
                    width: kDiscovretIconSize,
                    child: Image.asset("assets/Disc_Map_NoBorders.png"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: SubjectIconTextWhite(
                      text: 'No active friends at this time',
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              unNullWidget: ListView.builder(
                  controller: ScrollController(),
                  itemCount: userProfileInfo.activeFriendsCount,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    final friendObject =
                        userProfileInfo.listActiveFriends[index]!;
                    return ActiveFriendsListCard(
                        firstName: friendObject.firstName,
                        lastName: friendObject.lastName,
                        daysTillExp: friendObject.daysTillExp,
                        visitsThisYear: friendObject.visitsThisYear,
                        profilePicture: friendObject.profilePhoto,
                        onPressedDelete: () {
                          Navigator.pop(context);
                          userProfileInfo.deleteFriend(
                              object: friendObject,
                              list: userProfileInfo.listActiveFriends);
                        },
                        onPressedProfile: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewProfileFriend(
                                firstLanguage: friendObject.firstLanguage,
                                gender: friendObject.gender,
                                rating: friendObject.rating,
                                firstName: friendObject.firstName,
                                lastName: friendObject.lastName,
                                bio: friendObject.bio,
                                daysTillExp: friendObject.daysTillExp,
                                visitsThisYear: friendObject.visitsThisYear,
                                profilePhoto: friendObject.profilePhoto,
                                relationshipStatus:
                                    friendObject.relationshipStatus,
                                biologicalSex: friendObject.biologicalSex,
                                age: friendObject.age,
                                interestedIn: friendObject.interestedIn,
                                photos: friendObject.listPhotos,
                              ),
                            ),
                          );
                        });
                  }),
            )!
          ],
        ),
      ),
    );
  }
}
