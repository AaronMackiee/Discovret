import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discovret1_0/Components/background_screen.dart';
import 'package:discovret1_0/Components/discovret_scaffold.dart';
import 'package:discovret1_0/Components/widgets.dart';
import 'package:discovret1_0/FirebaseServices/auth_service.dart';
import 'package:discovret1_0/FirebaseServices/db_models.dart';
import 'package:discovret1_0/FirebaseServices/db_services.dart';
import 'package:discovret1_0/Provider Services/profile_info_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:discovret1_0/Constants/discovret_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:discovret1_0/Components/icons.dart';
import 'package:flutter_circular_text/circular_text/model.dart';
import 'package:flutter_circular_text/circular_text/widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'friend_list_brain.dart';

class FriendConfirmations extends StatefulWidget {
  static const String id = 'FriendConfirmationsScreen';
  @override
  _FriendConfirmationsState createState() => _FriendConfirmationsState();
}

class _FriendConfirmationsState extends State<FriendConfirmations> {
  String text = 'Uplift';
  String? selectedObjectPicture;
  AuthService _auth = AuthService();
  FirestoreService _dbServices = FirestoreService();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    // final UserProfileInfo userProfileInfo =
    //     Provider.of<UserProfileInfo>(context);
    final _dbUserConfirmations =
        Provider.of<List<ConfirmationsObject>>(context);
    // FriendProfile selectedObject =
    //     userProfileInfo.selectedConfirmationObject;

    // int itemCount = userProfileInfo.friendConfirmationsCount;

    // Widget checkNullValues() {
    //   if (selectedObject == null) {
    //     return SizedBox(height: 300);
    //   } else {
    //     return FriendConfirmationCard(
    //       fullName: selectedObject.friendProfileName,
    //       firstName: selectedObject.friendProfileName,
    //       picture: selectedObject.friendProfilePicture,
    //     );
    //   }
    // }
    List<NewConfirmationObject> userConfirmations = [];
    ConfirmationsObject friend;

    for (friend in _dbUserConfirmations) {
      if (friend.uid1 != _auth.getUser!.uid) {
        userConfirmations.add(NewConfirmationObject(
            docId: friend.docId!,
            name: friend.name1!,
            uids: friend.uids!,
            profilePicture: friend.profilePicture1!,
            uid: friend.uid1!));
      } else {
        userConfirmations.add(NewConfirmationObject(
            docId: friend.docId!,
            name: friend.name2!,
            uids: friend.uids!,
            profilePicture: friend.profilePicture2!,
            uid: friend.uid2!));
      }
    }

    bool isValidFormReview = false;
    var _numberFormReview = GlobalKey<FormState>();

    void checkProfileFormReview() {
      if (_numberFormReview.currentState!.validate()) {
        isValidFormReview = true;
      } else {
        isValidFormReview = false;
      }
    }

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
        child: Container(
          child: nullSafetyWidget(
            count: userConfirmations.length,
            nullWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                    text: 'No confirmations at this time',
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            unNullWidget: PageView.builder(
              scrollDirection: Axis.horizontal,
              physics: ScrollPhysics(),
              itemCount: userConfirmations.length,
              itemBuilder: (context, index) {
                final confirmationObjectReview = userConfirmations[index];
                return Form(
                  key: _numberFormReview,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: FriendConfirmationCard(
                    fullName: confirmationObjectReview.name,
                    picture: confirmationObjectReview.profilePicture,
                    child: Text(
                      "Confirmations: ${index + 1}/${userConfirmations.length}"
                          .toUpperCase(),
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 20,
                          letterSpacing: 1,
                          color: kDiscovretYellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onTapConfirm: () {
                      checkProfileFormReview();
                      if (isValidFormReview == true) {
                        _dbServices.updateConfirmationList(
                            fieldArray: 'Uids',
                            field: (confirmationObjectReview.uids.first ==
                                    _auth.getUser!.uid)
                                ? 'ConfirmedRequest1'
                                : 'ConfirmedRequest2',
                            docId: confirmationObjectReview.docId,
                            valueArray: _auth.getUser!.uid,
                            value: true);
                        _db.collection('Compliments').add({});
                      } else {}
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class NewConfirmationObject {
  final String name;
  final String profilePicture;
  final String uid;
  final String docId;
  final List<dynamic> uids;

  NewConfirmationObject(
      {required this.name,
      required this.uids,
      required this.profilePicture,
      required this.uid,
      required this.docId});
}

          // ListView.builder(
            //   shrinkWrap: true,
            // physics: ScrollPhysics(),
            //   itemCount: userProfileInfo.friendConfirmationsCount,
            //   itemExtent: 100.00,
            //   itemBuilder: (context, index) {
            //     final confirmationObjectAvatar =
            //         userProfileInfo.listConfirmationObjects[index];
            //     return ConfirmationsAvatar(
            //       profileImage:
            //           confirmationObjectAvatar.friendProfilePicture,
            //       onTap: () {
            //         userProfileInfo.selectedConfirmationObject =
            //             confirmationObjectAvatar;
            //         userProfileInfo.selectedConfirmationObject;
            //         // selectedObjectName =
            //         //     confirmationObject.friendProfileName;
            //         // selectedObjectPicture =
            //         //     confirmationObject.friendProfilePicture;
            //         print(confirmationObjectAvatar.friendProfileName);
            //         //is not changing state because notify listeners.
            //       },
            //     );
            //   },
            // ),
            // SizedBox(height: 5),
            // Divider(
            //   color: Colors.white,
            //   thickness: 5,
            // ),
            // SizedBox(height: 7),
            // // checkNullValues(),
