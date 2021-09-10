import 'dart:io';
import 'package:discovret1_0/Components/discovret_scaffold.dart';
import 'package:discovret1_0/Components/widgets.dart';
import 'package:discovret1_0/Constants/discovret_constants.dart';
import 'package:discovret1_0/Components/icons.dart';
import 'package:discovret1_0/FirebaseServices/db_models.dart';
import 'package:discovret1_0/FirebaseServices/db_services.dart';
import 'package:discovret1_0/FirebaseServices/f_storage.dart';
import 'package:discovret1_0/Provider Services/profile_info_provider.dart';
// import 'package:discovret1_0/Profile/Photo_Screen/photos_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewUserPhotos extends StatelessWidget {
  static const String id = 'ViewProfilePhotoScreen';
  final String? selectedPhoto;
  final int? indexPhotos;
  final FirebaseStorageServices _fS = FirebaseStorageServices();
  final FirestoreService _db = FirestoreService();

  ViewUserPhotos({this.selectedPhoto, this.indexPhotos});

  @override
  Widget build(BuildContext context) {
    final UserProfileInfo userProfileInfo =
        Provider.of<UserProfileInfo>(context);
    final DbUserProfileInfo dbUserProfileInfo =
        Provider.of<DbUserProfileInfo>(context);
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
      body: ViewUserPhoto(
        imageString: dbUserProfileInfo.userPictures![indexPhotos!],
        onPressedProfile: () {
          // dbUserProfileInfo.profilePicture = selectedPhoto;
          _db.updateProfilePhoto(field: 'ProfilePicture', value: selectedPhoto);
          print(selectedPhoto);
          Navigator.pop(context);
          // print(userProfileInfo.profilePicture);
        },
        onPressedDelete: () {
          if (selectedPhoto == dbUserProfileInfo.profilePicture) {
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: Text('Delete'),
                      content: Text(
                          'Deleting your selected profile picture is not allowed. Please change your profile picture first.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Okay'),
                        ),
                      ],
                      elevation: 24,
                      backgroundColor: Colors.white,
                    ));
          } else {
            Navigator.pop(context);
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: Text('Delete'),
                      content:
                          Text('Are you sure you want to Delete this Photo?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            _db.deleteUserPhoto(
                                field: 'UserPictures', value: selectedPhoto);
                            _fS.fsDeleteUserPhoto(fsUrl: selectedPhoto!);
                            Navigator.pop(context);
                          },
                          child: Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('No'),
                        ),
                      ],
                      elevation: 24,
                      backgroundColor: Colors.white,
                    ));
          }
        },
      ),
    );
  }
}
