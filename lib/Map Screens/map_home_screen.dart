import 'package:discovret1_0/Constants/discovret_constants.dart';
import 'package:discovret1_0/Components/icons.dart';
import 'package:discovret1_0/FirebaseServices/auth_service.dart';
import 'package:discovret1_0/FirebaseServices/db_models.dart';
import 'package:discovret1_0/FirebaseServices/db_services.dart';
import 'package:discovret1_0/FirebaseServices/f_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import '../Components/background_screen.dart';
import '../Components/discovret_scaffold.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:discovret1_0/Provider Services/account_info_provider.dart';
import 'package:discovret1_0/Provider Services/profile_info_provider.dart';

enum AppBarIcon { settings, map, account_profile }

class MapHomeScreen extends StatefulWidget {
  static const String id = 'MapHomeScreen';
  @override
  _MapHomeScreenState createState() => _MapHomeScreenState();
}

class _MapHomeScreenState extends State<MapHomeScreen>
    with SingleTickerProviderStateMixin {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final Firestore _db = Firestore.instance;
  // User loggedInUser;
  final FirestoreService _db = FirestoreService();
  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
  }

  AnimationController? controller;

// AnimationController controller;
// @override
// void initState() {
//   super.initState();

//   controller = AnimationController(
//     upperBound: 100.0,
//     duration: Duration(seconds: 3),
//     vsync: this,
//   );
//   controller.forward();
//   controller.addListener(() {
//     setState(() {
//       controller.value;
//       print(controller.value);
//     });
//   });
// }

  @override
  Widget build(BuildContext context) {
    // final UserProfileInfo userProfileInfo =
    //     Provider.of<UserProfileInfo>(context);
    final AuthService dbUser = AuthService();
    // final DbUserDiscSearchList dbUserSearchList =
    //     Provider.of<DbUserDiscSearchList>(context);
    final DbUserProfileInfo dbUserProfileInfo =
        Provider.of<DbUserProfileInfo>(context);
    final DbUserProfileSearchInfo dbUserProfileSearchInfo =
        Provider.of<DbUserProfileSearchInfo>(context);
    final dbUserFriendsList = Provider.of<List<AllFriendsObject>>(context);
    return LoadingOverlay(
      isLoading: showSpinner,
      progressIndicator: CircularProgressIndicator(
        color: kDiscovretGreen,
      ),
      child: DiscovretScaffold(
        index: 1,
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
        body: Container(
          child: DiscovretBackground(
            child: Center(
              child: ListView(
                children: [
                  // Text(dbUserFriendsList.friendObjects!.first.firstName!),
                  // Text(dbUser.getUser!.email!),
                  // Text(dbUserProfileInfo.firstName!),
                  // Text(dbUserProfileInfo.lastName!),
                  // Text(dbUserProfileInfo.interestedIn!),
                  // Text(dbUserProfileInfo.sex!),
                  // ListView.builder(
                  //     shrinkWrap: true,
                  //     itemCount: dbUserSearchList.length,
                  //     itemBuilder: (context, index) {
                  //       UserDiscSearchList searchList = dbUserSearchList[index];
                  //       return Text(searchList.searchItem);
                  //     }),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: dbUserProfileSearchInfo.languages!.length,
                      itemBuilder: (context, index) {
                        String item = dbUserProfileSearchInfo.languages![index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 15, top: 3, bottom: 3),
                          child: Text(
                            item,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        );
                      }),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: dbUserFriendsList.length,
                      itemBuilder: (context, index) {
                        final item = dbUserFriendsList[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 15, top: 3, bottom: 3),
                          child: Text(
                            item.firstName!,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        );
                      }),

                  InkWell(
                    onTap: () {
                      print(dbUserFriendsList.first.firstName);
                    },
                    child: Container(
                      height: 30,
                      width: 50,
                      color: kDiscovretYellow,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
