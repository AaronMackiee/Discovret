import 'package:discovret1_0/Components/background_screen.dart';
import 'package:discovret1_0/Components/discovret_scaffold.dart';
import 'package:discovret1_0/Components/widgets.dart';
import 'package:discovret1_0/FirebaseServices/db_models.dart';
import 'package:discovret1_0/Profile Screens/FriendsList%20Screen/view_friend_info.dart';
import 'package:discovret1_0/Profile Screens/FriendsList%20Screen/view_friends_photo.dart';
import 'package:discovret1_0/Profile Screens/Photo_Screen/view_photo.dart';
import 'package:discovret1_0/Provider%20Services/provider_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:discovret1_0/Constants/discovret_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:discovret1_0/Components/icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ViewProfileFriend extends StatelessWidget {
  static const String id = 'ViewProfileFriend';
  // final int photoCount;
  // final int reviewCount;
  // final int profileAccuracyRating;
  // final int safetyRating;
  // final String profilePhoto;
  // final String firstName;
  // final String lastName;
  // final String? bio;
  // final int? visitsThisYear;
  // final int? daysTillExp;
  // final String biologicalSex;
  // final String? gender;
  // final int age;
  // final String interestedIn;
  // final String relationshipStatus;
  // final String firstLanguage;
  // final List<dynamic> userPhotos;
  // final List<dynamic> allFriends;
  // final List<dynamic> allBusinesses;
  // final List<dynamic> allPlaces;
  // final List<dynamic>? countriedLivedIn;
  // final List<dynamic>? culturalHeritage;
  // final List<dynamic>? hobbiesInterest;
  // final List<dynamic>? languages;
  // final List<dynamic>? mentoringIn;
  // final List<dynamic>? religionsPracticed;

  // ViewProfileFriend(
  //     {Key? key,
  //     required this.profileAccuracyRating,
  //     required this.photoCount,
  //     required this.safetyRating,
  //     required this.reviewCount,
  //     required this.userPhotos,
  //     required this.profilePhoto,
  //     required this.firstName,
  //     required this.lastName,
  //     this.bio,
  //     this.visitsThisYear,
  //     this.daysTillExp,
  //     required this.biologicalSex,
  //     this.gender,
  //     required this.age,
  //     required this.interestedIn,
  //     required this.relationshipStatus,
  //     required this.firstLanguage,
  //     required this.allFriends,
  //     required this.allBusinesses,
  //     required this.allPlaces,
  //     this.countriedLivedIn,
  //     this.culturalHeritage,
  //     this.hobbiesInterest,
  //     this.languages,
  //     this.mentoringIn,
  //     this.religionsPracticed})
  //     : super(key: key);

  // int get getPhotoCount {
  //   int length = photos.length;
  //   return length;
  // }
  // set photoCount

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ViewProfileFriendObject;
    final _dbAllFriendsList = Provider.of<List<AllFriendsObject>>(context);
    int photoCount = args.userPhotos.length;
    List<AllFriendsObject> mutualFriends = [];
    AllFriendsObject friend;

    for (friend in _dbAllFriendsList) {
      if (args.allFriends.contains(friend.uid)) {
        mutualFriends.add(friend);
      }
    }

    String mutualFriendsCount = mutualFriends.length.toString();

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
            SizedBox(
              height: 7,
            ),
            Stack(
              clipBehavior: Clip.none,
              alignment: AlignmentDirectional.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 75,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(args.profilePhoto),
                  ),
                ),
                Positioned(
                  right: 3,
                  top: -3,
                  child: IconButton(
                    icon: Icon(Icons.more_horiz_outlined,
                        size: 30, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Container(
              height: 35,
              width: double.infinity,
              margin: EdgeInsets.all(5),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  '${args.firstName} ${args.lastName}',
                  style: TextStyle(
                      fontFamily: 'Syne Mono',
                      // fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            (args.bio == '')
                ? SizedBox(
                    height: 5,
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Text(
                        '${args.bio}',
                        style: TextStyle(
                            fontWeight: FontWeight.normal, color: Colors.white),
                      ),
                    ),
                  ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                      height: 90,
                      // width: 250,
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: kclearContainer,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Icon(
                              Icons.warning_amber,
                              size: 30,
                              color: kDiscovretGreen,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 1),
                            child: Text(
                              'Safety Rating',
                              // textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Text(
                              '${args.safetyRating}% / ${args.reviewCount.toString()} ${args.reviewCount == 1 ? 'Review' : 'Reviews'}',
                              // textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                      height: 90,
                      // width: 250,
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: kclearContainer,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            // Icons.emoji_people_outlined,
                            Icons.person_outlined,
                            size: 32,
                            color: kDiscovretGreen,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 10),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'Profile Accuracy Rating',
                                style: TextStyle(
                                    fontSize: 17,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 1),
                            child: Text(
                              '${args.profileAccuracyRating}% / ${args.reviewCount} ${args.reviewCount == 1 ? 'Review' : 'Reviews'}',
                              // textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Flexible(
                  //   flex: 1,
                  //   fit: FlexFit.tight,
                  //   child: Container(
                  //     height: 90,
                  //     // width: 250,
                  //     margin: EdgeInsets.symmetric(horizontal: 2),
                  //     decoration: BoxDecoration(
                  //       color: kclearContainer,
                  //       borderRadius: BorderRadius.all(Radius.circular(10)),
                  //     ),
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Icon(
                  //           Icons.timer,
                  //           size: 30,
                  //           color: kDiscovretGreen,
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.symmetric(vertical: 1),
                  //           child: Text(
                  //             'Days',
                  //             // textAlign: TextAlign.left,
                  //             style: TextStyle(
                  //                 fontSize: kTextSize15,
                  //                 letterSpacing: 0,
                  //                 fontWeight: FontWeight.bold,
                  //                 color: Colors.black),
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.symmetric(vertical: 1),
                  //           child: Text(
                  //             '$daysTillExp',
                  //             // textAlign: TextAlign.left,
                  //             style: TextStyle(
                  //                 fontSize: kTextSize15,
                  //                 letterSpacing: 0,
                  //                 // fontWeight: FontWeight.bold,
                  //                 color: Colors.black),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Divider(
              thickness: 1.5,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: kDiscovretYellow),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      "About Info:".toUpperCase(),
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 18,
                          letterSpacing: 1,
                          color: kDiscovretBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InfoOutputCard(
              textStringParent: 'Biological Sex',
              textStringchild: args.biologicalSex,
            ),
            InfoOutputCard(
                textStringParent: 'Gender:',
                textStringchild: (args.gender == '') ? args.biologicalSex : args.gender),
            InfoOutputCard(
              textStringParent: 'Age:',
              textStringchild: args.age.toString(),
            ),
            InfoOutputCard(
              textStringParent: 'Interested In:',
              textStringchild: args.interestedIn,
            ),
            InfoOutputCard(
              textStringParent: 'Relationship Status:',
              textStringchild: args.relationshipStatus,
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, FriendInfo.id);
                },
                child: Container(
                  width: double.infinity,
                  height: 30,
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: kDiscovretGreen,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Center(
                      child: Text(
                        'See All',
                        // textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: kTextSize15,
                            letterSpacing: 0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Divider(
              thickness: 1.5,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.people_outline, color: kDiscovretYellow),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      "Mutual Friends: $mutualFriendsCount".toUpperCase(),
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 18,
                          letterSpacing: 1,
                          color: kDiscovretBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: (mutualFriends.length == 0) ? 1 : 150,
              width: double.infinity,
              child: ListView.builder(
                itemCount: mutualFriends.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final friendObject = mutualFriends[index];
                  return MutualFriendAvatar(
                    firstName: friendObject.firstName,
                    lastName: friendObject.lastName,
                    profileImage: friendObject.profilePicture,
                    onPressed: () {
                      Navigator.pushNamed(
                            context, 
                            ViewProfileFriend.id,
                            arguments: 
                            ViewProfileFriendObject(
                                photoCount: friendObject.userPictures.length,
                                firstLanguage: friendObject.firstLanguage,
                                gender: friendObject.gender,
                                profileAccuracyRating: friendObject.profileAccuracyRating,
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
                    },
                  );
                },
              ),
            ),
            Divider(
              thickness: 1.5,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.photo_camera_outlined, color: kDiscovretYellow),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      "Photos: $photoCount".toUpperCase(),
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 18,
                          letterSpacing: 1,
                          color: kDiscovretBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GridView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: args.userPhotos.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) {
                final photo = args.userPhotos[index];
                return PictureGridTile(
                  cardimage: NetworkImage(photo),
                  color: Colors.white,
                  iconWidget: SizedBox(),
                  onpress: () {
                    // Navigator.pushNamed(context, ViewProfilePhotos.id);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewFriendsPhoto(
                                selectedPhoto: photo,
                                indexPhotos: index,
                                photos: args.userPhotos)));
                  },
                );
              },
            ),
            SizedBox(height: 5),
            Divider(
              thickness: 1.5,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.pin_drop_outlined, color: kDiscovretYellow),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: SubjectIconText(
                      text: 'Places: 45',
                      fontSize: kTextSize18,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1.5,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.store_mall_directory_outlined,
                      color: kDiscovretYellow),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: SubjectIconText(
                      text: 'Businesses: 90',
                      fontSize: kTextSize18,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1.5,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

      // Row(
            //   children: [
            //     Expanded(
            //       child: ReusablePictureCard(
            //         onpress: () {
            //           setState(() {});
            //         },
            //         cardimage: AssetImage('assets/profile1.jpg'),
            //       ),
            //     ),
            //     Expanded(
            //       child: ReusablePictureCard(
            //         onpress: () {
            //           setState(() {});
            //         },
            //         cardimage: AssetImage('assets/profile2.jpg'),
            //       ),
            //     ),
            //     Expanded(
            //       child: ReusablePictureCard(
            //         onpress: () {
            //           setState(() {
            //             Navigator.pushNamed(context, 'ViewFriendsPhotoScreen');
            //           });
            //         },
            //         cardimage: AssetImage('assets/profile3.jpg'),
            //       ),
            //     )
            //   ],
            // ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: ReusablePictureCard(
            //         onpress: () {
            //           setState(() {});
            //         },
            //         cardimage: AssetImage('assets/profile4.jpg'),
            //       ),
            //     ),
            //     Expanded(
            //       child: ReusablePictureCard(
            //         onpress: () {
            //           setState(() {});
            //         },
            //         cardimage: AssetImage('assets/profile5.jpg'),
            //       ),
            //     ),
            //     Expanded(
            //       child: ReusablePictureCard(
            //         onpress: () {
            //           setState(() {});
            //         },
            //         cardimage: AssetImage('assets/profile6.jpg'),
            //       ),
            //     )
            //   ],
            // ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: ReusablePictureCard(
            //         onpress: () {
            //           setState(() {});
            //         },
            //         cardimage: AssetImage('assets/profile7.jpg'),
            //       ),
            //     ),
            //     Expanded(
            //       child: ReusablePictureCard(
            //         onpress: () {
            //           setState(() {});
            //         },
            //         cardimage: AssetImage('assets/profile8.jpg'),
            //       ),
            //     ),
            //     Expanded(
            //       child: ReusablePictureCard(
            //         onpress: () {
            //           setState(() {});
            //         },
            //         cardimage: AssetImage('assets/profile9.jpg'),
            //       ),
            //     )
            //   ],
            // ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: ReusablePictureCard(
            //         onpress: () {
            //           setState(() {});
            //         },
            //         cardimage: AssetImage('assets/profile10.jpg'),
            //       ),
            //     ),
            //     Expanded(
            //       child: ReusablePictureCard(
            //         onpress: () {
            //           setState(() {});
            //         },
            //         cardimage: AssetImage('assets/profile11.jpg'),
            //       ),
            //     ),
            //     Expanded(
            //       child: ReusablePictureCard(
            //         onpress: () {
            //           setState(() {});
            //         },
            //         cardimage: AssetImage('assets/profile12.jpg'),
            //       ),
            //     )
            //   ],
            // ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: ReusablePictureCard(
            //         onpress: () {
            //           setState(() {});
            //         },
            //         cardimage: AssetImage('assets/profile13.jpg'),
            //       ),
            //     ),
            //     Expanded(
            //       child: ReusablePictureCard(
            //         onpress: () {
            //           setState(
            //             () {
            //               Navigator.pushNamed(context, 'ViewPhotoScreen');
            //             },
            //           );
            //         },
            //         cardimage: AssetImage('assets/profile14.jpg'),
            //       ),
            //     ),
            //     Expanded(
            //       child: ReusablePictureCard(
            //         onpress: () {
            //           setState(() {});
            //         },
            //         cardimage: AssetImage('assets/profile15.jpg'),
            //       ),
            //     ),
            //   ],
            // ),