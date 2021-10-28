import 'package:discovret1_0/Components/background_screen.dart';
import 'package:discovret1_0/Components/discovret_scaffold.dart';
import 'package:discovret1_0/Components/widgets.dart';
import 'package:discovret1_0/Profile%20Screens/FriendsList%20Screen/view_friend_profile.dart';
import 'package:discovret1_0/Provider%20Services/profile_info_provider.dart';
import 'package:discovret1_0/Provider%20Services/provider_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:discovret1_0/Constants/discovret_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:discovret1_0/Components/icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'friend_search.dart';

class CloseFriendsList extends StatefulWidget {
  static const String id = 'CloseFriendsListScreen';
  @override
  _CloseFriendsListState createState() => _CloseFriendsListState();
}

Widget? nullSafetyWidget(
    {int? count, Widget? nullWidget, Widget? unNullWidget}) {
  if (count == 0) {
    return nullWidget;
  } else
    return unNullWidget;
}

class _CloseFriendsListState extends State<CloseFriendsList> {
  @override
  Widget build(BuildContext context) {
    final UserProfileInfo userProfileInfo =
        Provider.of<UserProfileInfo>(context);
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
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Hero(
                    tag: 'Friends:',
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Icon(
                        Icons.people_outline,
                        size: deviceWidth * .25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // Container(
                //   height: kDiscovretIconSize,
                //   width: kDiscovretIconSize,
                //   child: Image.asset("assets/Disc_Map_NoBorders.png"),
                // ),
                Positioned(
                  left: 14,
                  top: -2,
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
            // SizedBox(
            //   height: 15,
            // ),
            // CircularHeaderBox(
            //   color: null,
            //   textString: 'Close Friends',
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // FriendTypeInfoCard('5 visits per year = 1 Disc coin'),
            // SizedBox(
            //   height: 5,
            // ),
            // SizedBox(height: 20),

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
                    "Close Friends: ${userProfileInfo.closeFriendsCount}"
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
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            FriendTypeInfoCard('5 visits per year = 1 Disc coin'),
            SizedBox(
              height: 10,
            ),
            nullSafetyWidget(
              count: userProfileInfo.closeFriendsCount,
              nullWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
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
                      text: 'No close friends at this time',
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              unNullWidget: ListView.builder(
                  controller: ScrollController(),
                  itemCount: userProfileInfo.closeFriendsCount,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    final friendObject =
                        userProfileInfo.listCloseFriends[index]!;
                    return CloseFriendListCard(
                        firstName: friendObject.firstName,
                        lastName: friendObject.lastName,
                        daysTillExp: friendObject.daysTillExp,
                        visitsThisYear: friendObject.visitsThisYear,
                        profilePicture: friendObject.profilePicture,
                        onPressedDelete: () {
                          // Navigator.pop(context);
                          // userProfileInfo.deleteFriend(
                          //     object: friendObject,
                          //     list: userProfileInfo.listActiveFriends);
                        },
                        onPressedProfile: () {
                          Navigator.pushNamed(
                            context,
                            ViewProfileFriend.id,
                            arguments: ViewProfileFriendObject(
                              photoCount: friendObject.userPictures.length,
                              firstLanguage: friendObject.firstLanguage,
                              gender: friendObject.gender,
                              profileAccuracyRating:
                                  friendObject.profileAccuracyRating,
                              reviewCount: friendObject.reviewCount,
                              safetyRating: friendObject.safetyRating,
                              firstName: friendObject.firstName,
                              lastName: friendObject.lastName,
                              bio: friendObject.bio,
                              daysTillExp: 73,
                              visitsThisYear: friendObject.visitsThisYear,
                              profilePhoto: friendObject.profilePicture,
                              relationshipStatus:
                                  friendObject.relationshipStatus,
                              biologicalSex: friendObject.sex,
                              age: friendObject.age,
                              interestedIn: friendObject.interestedIn,
                              userPhotos: friendObject.userPictures,
                              allFriends: friendObject.allFriends,
                              allPlaces: friendObject.allPlaces,
                              allBusinesses: friendObject.allBusinesses,
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

   // CloseFriendListCard(),
            // CloseFriendListCard(),
            // CloseFriendListCard(),
            // CloseFriendListCard(),
            // CloseFriendListCard(),