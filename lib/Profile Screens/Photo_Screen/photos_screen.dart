// import 'dart:html';
import 'dart:io';
import 'package:discovret1_0/Components/background_screen.dart';
import 'package:discovret1_0/Components/discovret_scaffold.dart';
import 'package:discovret1_0/Components/widgets.dart';
import 'package:discovret1_0/Constants/discovret_constants.dart';
import 'package:discovret1_0/Components/icons.dart';
import 'package:discovret1_0/FirebaseServices/auth_service.dart';
import 'package:discovret1_0/FirebaseServices/db_models.dart';
import 'package:discovret1_0/FirebaseServices/db_services.dart';
import 'package:discovret1_0/FirebaseServices/f_storage.dart';
import 'package:discovret1_0/Provider Services/profile_info_provider.dart';
import 'package:discovret1_0/Profile Screens/Photo_Screen/add_photo.dart';
import 'package:discovret1_0/Profile Screens/Photo_Screen/view_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:firebase_storage/firebase_storage.dart' as storage;
// import 'package:permission_handler/permission_handler.dart';

import 'image_picker.dart';

class ProfilePhotosScreen extends StatefulWidget {
  static const String id = 'ProfilePhotosScreen';
  @override
  _ProfilePhotosScreenState createState() => _ProfilePhotosScreenState();
}

class _ProfilePhotosScreenState extends State<ProfilePhotosScreen> {
  final ImagePicker _picker = ImagePicker();
  final AuthService _auth = AuthService();
  final FirebaseStorageServices _fS = FirebaseStorageServices();
  final FirestoreService _db = FirestoreService();
  final UserProfileInfo userProfileInfo = UserProfileInfo();
  final DbUserProfileInfo dbUserProfileInfo = DbUserProfileInfo();

  var imageFile;
  var imageFileDone;
  List<dynamic> userPhotoList = [];
  bool showSpinner = false;
  int photoCount = 0;
  int? index;

  Future _selectPhoto() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => BottomSheet(
        onClosing: () {},
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera),
              title: Text('Camera'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.filter),
              title: Text('Pick a File'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
            )
          ],
        ),
      ),
    );
  }

  int getUserPhotoCount({required List<dynamic> list}) {
    photoCount = list.length;
    return photoCount;
  }

  Future _pickImage(ImageSource source) async {
    userPhotoList.clear();
    final pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);
    if (pickedFile == null) {
      return;
    }

    imageFile = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));
    if (imageFile == null) {
      return;
    } else {}

    final String currentDateNow =  DateTime.now().toIso8601String();
    imageFileDone = await compressImage(imageFile.path, 35);
    await _fS.uploadUserPhoto(
        path: imageFileDone.path, currentTime: currentDateNow);

    final imageUrl = await _fS.downloadUserPhoto(currentTime: currentDateNow);

    userPhotoList.add(imageUrl);
    // userProfileInfo.listUserPhotos.add(imageUrl);

    _db.updateUserPhotosList(field: 'UserPictures', value: userPhotoList);

    // await _uploadFile(file.path);
  }

  Future<File> compressImage(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');

    final result = await FlutterImageCompress.compressAndGetFile(path, newPath,
        quality: quality);
    return result!;
  }

  @override
  Widget build(BuildContext context) {
    final UserProfileInfo userProfileInfo =
        Provider.of<UserProfileInfo>(context);
    final DbUserProfileInfo dbUserProfileInfo =
        Provider.of<DbUserProfileInfo>(context);
    userProfileInfo.userPhotosCount;
    return DiscovretScaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 4,
              blurRadius: 4,
              // offset: Offset(3, 5),
            ),
          ],
        ),
        child: FloatingActionButton(
          elevation: 100,
          highlightElevation: 500,
          materialTapTargetSize: MaterialTapTargetSize.padded,
          backgroundColor: kDiscovretGreen,
          splashColor: kDiscovretYellow,
          onPressed: () {
            // userProfileInfo.listUserPhotos = dbUserProfileInfo.userPictures!;
            getUserPhotoCount(list: dbUserProfileInfo.userPictures!);
            print(userProfileInfo.listUserPhotos);
            _selectPhoto();
            // try {
            //   setState(() {
            //     showSpinner = true;
            //   });

            //   setState(() {
            //     showSpinner = false;
            //   });
            // } catch (e) {
            //   print(e);
            //   showSpinner = false;
            // }
          },
          child: Icon(
            Icons.add_a_photo_outlined,
            color: Colors.white,
          ),
        ),
      ),
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
      body: LoadingOverlay(
        isLoading: showSpinner,
        progressIndicator: CircularProgressIndicator(
          color: kDiscovretGreen,
        ),
        child: DiscovretBackground(
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: dbUserProfileInfo.userPictures!.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            // SliverGridDelegateWithMaxCrossAxisExtent(
            //     maxCrossAxisExtent: 150,
            //     childAspectRatio: 1,
            //     crossAxisSpacing: 0.5,
            //     mainAxisSpacing: 0.5),
            itemBuilder: (context, index) {
              final userPhoto = dbUserProfileInfo.userPictures![index];
              return PictureGridTile(
                cardimage: NetworkImage(userPhoto),
                color: dbUserProfileInfo.profilePicture == userPhoto
                    ? kDiscovretYellow
                    : Colors.white,
                iconWidget: dbUserProfileInfo.profilePicture == userPhoto
                    ? Icon(Icons.account_box_outlined,
                        color: Colors.white, size: 50)
                    : SizedBox(),
                onpress: () {
                  // Navigator.pushNamed(context, ViewProfilePhotos.id);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewUserPhotos(
                              selectedPhoto: userPhoto, indexPhotos: index)));
                },
              );
              // }
            },
          ),
        ),
      ),
    );
  }
}


//  Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               IconButton(
//                 highlightColor: Colors.white,
//                 icon: Icon(
//                   Icons.edit,
//                   color: kinactiveIconColor,
//                   size: kinactiveIconSize,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     null;
//                   });
//                   // onTapNavigator(index);
//                 },
//               ),
//               IconButton(
//                 icon: Icon(
//                   Icons.camera_alt,
//                   color: kinactiveIconColor,
//                   size: kinactiveIconSize,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     null;
//                   });
//                   // onTapNavigator(index);
//                 },
//               ),
//               IconButton(
//                 icon: Icon(
//                   Icons.delete,
//                   color: kinactiveIconColor,
//                   size: kinactiveIconSize,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     null;
//                   });
//                   // onTapNavigator(index);
//                 },
//               )
//             ],
//           )

 // ListView(
        //   children: [
        //     SizedBox(
        //       height: 5,
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Hero(
        //         tag: 'Photos',
        //         child: Padding(
        //           padding: const EdgeInsets.all(5.0),
        //           child: Icon(
        //             Icons.camera_alt_outlined,
        //             size: 90,
        //             color: Colors.white,
        //           ),
        //         ),
        //       ),
        //     ),
        //     CircularHeaderBox(
        //         textString: 'My Photos', color: Colors.transparent),
        //     SizedBox(
        //       height: 15,
        //     ),
        //     Row(
        //       children: [
        //         Expanded(
        //           child: ReusablePictureCard(
        //             onpress: () {
        //               setState(() {});
        //             },
        //             cardimage: AssetImage('assets/profile1.jpg'),
        //           ),
        //         ),
        //         Expanded(
        //           child: ReusablePictureCard(
        //             onpress: () {
        //               setState(() {});
        //             },
        //             cardimage: AssetImage('assets/profile2.jpg'),
        //           ),
        //         ),
        //         Expanded(
        //           child: ReusablePictureCard(
        //             onpress: () {
        //               setState(() {});
        //             },
        //             cardimage: AssetImage('assets/profile3.jpg'),
        //           ),
        //         )
        //       ],
        //     ),
        //     Row(
        //       children: [
        //         Expanded(
        //           child: ReusablePictureCard(
        //             onpress: () {
        //               setState(() {});
        //             },
        //             cardimage: AssetImage('assets/profile4.jpg'),
        //           ),
        //         ),
        //         Expanded(
        //           child: ReusablePictureCard(
        //             onpress: () {
        //               setState(() {});
        //             },
        //             cardimage: AssetImage('assets/profile5.jpg'),
        //           ),
        //         ),
        //         Expanded(
        //           child: ReusablePictureCard(
        //             onpress: () {
        //               setState(() {});
        //             },
        //             cardimage: AssetImage('assets/profile6.jpg'),
        //           ),
        //         )
        //       ],
        //     ),
        //     Row(
        //       children: [
        //         Expanded(
        //           child: ReusablePictureCard(
        //             onpress: () {
        //               setState(() {});
        //             },
        //             cardimage: AssetImage('assets/profile7.jpg'),
        //           ),
        //         ),
        //         Expanded(
        //           child: ReusablePictureCard(
        //             onpress: () {
        //               setState(() {});
        //             },
        //             cardimage: AssetImage('assets/profile8.jpg'),
        //           ),
        //         ),
        //         Expanded(
        //           child: ReusablePictureCard(
        //             onpress: () {
        //               setState(() {});
        //             },
        //             cardimage: AssetImage('assets/profile9.jpg'),
        //           ),
        //         )
        //       ],
        //     ),
        //     Row(
        //       children: [
        //         Expanded(
        //           child: ReusablePictureCard(
        //             onpress: () {
        //               setState(() {});
        //             },
        //             cardimage: AssetImage('assets/profile10.jpg'),
        //           ),
        //         ),
        //         Expanded(
        //           child: ReusablePictureCard(
        //             onpress: () {
        //               setState(() {});
        //             },
        //             cardimage: AssetImage('assets/profile11.jpg'),
        //           ),
        //         ),
        //         Expanded(
        //           child: ReusablePictureCard(
        //             onpress: () {
        //               setState(() {});
        //             },
        //             cardimage: AssetImage('assets/profile12.jpg'),
        //           ),
        //         )
        //       ],
        //     ),
        //     Row(
        //       children: [
        //         Expanded(
        //           child: ReusablePictureCard(
        //             onpress: () {
        //               setState(() {});
        //             },
        //             cardimage: AssetImage('assets/profile13.jpg'),
        //           ),
        //         ),
        //         Expanded(
        //           child: ReusablePictureCard(
        //             onpress: () {
        //               setState(
        //                 () {
        //                   Navigator.pushNamed(context, ViewProfilePhoto.id);
        //                 },
        //               );
        //             },
        //             cardimage: AssetImage('assets/profile14.jpg'),
        //           ),
        //         ),
        //         Expanded(
        //           child: AddPictureCard(),
        //         )
        //       ],
        //     ),
        //   ],
        // ),
