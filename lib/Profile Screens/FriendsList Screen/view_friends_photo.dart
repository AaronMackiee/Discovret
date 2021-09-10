import 'dart:io';
import 'package:discovret1_0/Components/Widgets.dart';
import 'package:discovret1_0/Components/background_screen.dart';
import 'package:discovret1_0/Components/discovret_scaffold.dart';
import 'package:discovret1_0/Constants/discovret_constants.dart';
import 'package:discovret1_0/Components/icons.dart';
import 'package:discovret1_0/Provider Services/profile_info_provider.dart';
// import 'package:discovret1_0/Profile/Photo_Screen/photos_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewFriendsPhoto extends StatelessWidget {
  static const String id = 'ViewProfilePhotoScreen';
  final String? selectedPhoto;
  final int? indexPhotos;
  final List<dynamic>? photos;

  ViewFriendsPhoto({this.selectedPhoto, this.indexPhotos, this.photos});

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
        body: ViewFriendPhoto(
          imageString: photos![indexPhotos!],
        ));
  }
}
