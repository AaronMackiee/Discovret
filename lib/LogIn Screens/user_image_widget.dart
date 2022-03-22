import 'dart:io';

import 'package:discovret1_0/Components/Widgets.dart';
import 'package:discovret1_0/Constants/discovret_constants.dart';
import 'package:discovret1_0/Provider%20Services/account_info_provider.dart';
import 'package:discovret1_0/Provider%20Services/profile_info_provider.dart';
import 'package:discovret1_0/FirebaseServices/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:provider/provider.dart';

class UserImage extends StatefulWidget {
  final Function(File file) onFileChanged;

  const UserImage({Key? key, required this.onFileChanged}) : super(key: key);

  @override
  _UserImageState createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  final ImagePicker _picker = ImagePicker();
  final AuthService _auth = AuthService();
  String? imageUrl;
  File? file;

  Future _selectPhoto() async {
    await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => Theme(
        data: ThemeData(canvasColor: Colors.transparent),
        child: BottomSheet(
          onClosing: () {},
          builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        height: 35,
                        width: 35,
                        child: Image(
                          fit: BoxFit.contain,
                          image: AssetImage("assets/Disc_Map2.png"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: SubjectIconText(
                        text: 'Photo Options',
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 30,
                  thickness: 5,
                  color: kDiscovretYellow,
                ),
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
        ),
      ),
    );
  }

  // showModalBottomSheet(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10.0),
  //           ),
  //           context: context,
  //           isScrollControlled: true,
  //           builder: (context) => SingleChildScrollView(
  //             child: Container(
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //               ),
  //               // padding: EdgeInsets.only(
  //               //     bottom: MediaQuery.of(context).viewInsets.bottom),
  //               child: Padding(
  //                 padding:
  //                     const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         DiscCoin(
  //                           size: 37,
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.only(left: 10),
  //                           child: SubjectIconText(
  //                             text: 'Crypto Rewards Info',
  //                             fontSize: 22,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     Divider(
  //                       height: 30,
  //                       thickness: 5,
  //                       color: kDiscovretYellow,
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(
  //                           vertical: 10, horizontal: 5),
  //                       child: Text(
  //                         'Discovered Friend',
  //                         style: TextStyle(
  //                             fontSize: 18,
  //                             fontWeight: FontWeight.bold,
  //                             color: kDiscovretBlue),
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(vertical: 10),
  //                       child: Text(
  //                         'Newly confirmed friend = 0.25 Disc coin',
  //                         style: TextStyle(
  //                             fontSize: 15,
  //                             fontWeight: FontWeight.normal,
  //                             color: Colors.black),
  //                       ),
  //                     ),
  //                     Divider(
  //                       height: 10,
  //                       thickness: 0.5,
  //                       color: Colors.blueGrey,
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(vertical: 10),
  //                       child: Text(
  //                         'Close Friend',
  //                         style: TextStyle(
  //                             fontSize: 18,
  //                             fontWeight: FontWeight.bold,
  //                             color: kDiscovretBlue),
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(vertical: 10),
  //                       child: Text(
  //                         '5 visits per year = 1 Disc coin',
  //                         style: TextStyle(
  //                             fontSize: 15,
  //                             fontWeight: FontWeight.normal,
  //                             color: Colors.black),
  //                       ),
  //                     ),
  //                     Divider(
  //                       height: 10,
  //                       thickness: 0.5,
  //                       color: Colors.blueGrey,
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(vertical: 10),
  //                       child: Text(
  //                         'Active Friend',
  //                         style: TextStyle(
  //                             fontSize: 18,
  //                             fontWeight: FontWeight.bold,
  //                             color: kDiscovretBlue),
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(vertical: 10),
  //                       child: Text(
  //                         '1 visit per year = 0.25 Disc',
  //                         style: TextStyle(
  //                             fontSize: 15,
  //                             fontWeight: FontWeight.normal,
  //                             color: Colors.black),
  //                       ),
  //                     ),
  //                     Divider(
  //                       height: 10,
  //                       thickness: 0.5,
  //                       color: Colors.blueGrey,
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(vertical: 10),
  //                       child: Text(
  //                         'Inactive Friend',
  //                         style: TextStyle(
  //                             fontSize: 18,
  //                             fontWeight: FontWeight.bold,
  //                             color: kDiscovretBlue),
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(vertical: 10),
  //                       child: Text(
  //                         '1 year with no visit = - 0.25 Disc coin',
  //                         style: TextStyle(
  //                             fontSize: 15,
  //                             fontWeight: FontWeight.normal,
  //                             color: Colors.black),
  //                       ),
  //                     ),
  //                     //
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );

  Future _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);
    if (pickedFile == null) {
      return;
    }

    var file = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));
    if (file == null) {
      return;
    } else {}

    file = await compressImage(file.path, 35);
    setState(() {
      this.file = file;
      // print(userAccountInfo.hasProfilePicture);
    });
    widget.onFileChanged((file));

    // await _uploadFile(file.path);
  }

  Future<File> compressImage(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');

    final result = await FlutterImageCompress.compressAndGetFile(path, newPath,
        quality: quality);
    return result!;
  }

  // void imageValidation ({bool? hasPicture}) {

  // }

  @override
  Widget build(BuildContext context) {
    final UserProfileInfo userProfileInfo =
        Provider.of<UserProfileInfo>(context);
    return Column(
      children: [
        if (file == null)
          GestureDetector(
            onTap: () {
              _selectPhoto();
              // print(file);
            },
            child: Container(
              height: deviceWidth * .50,
              width: deviceWidth * .50,
              padding: EdgeInsets.all(5),
              child: Icon(Icons.add_a_photo,
                  size: deviceWidth * .20, color: kDiscovretGreen),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(200)),
              ),
            ),
          ),
        if (file != null)
          InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => _selectPhoto(),
              child: AppRoundImageFile(
                file: file!,
                height: deviceWidth * .50,
                width: deviceWidth * .50,
              )),
        InkWell(
          onTap: () {
            _selectPhoto();
            print(file);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 30),
            child: Text(
              (file != null) ? 'Change Profile Photo' : 'Select Profile Photo',
              style: TextStyle(
                  letterSpacing: 3,
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            ),
          ),
        )
      ],
    );
  }

  Future _uploadFile(String path) async {
    final ref = storage.FirebaseStorage.instance
        .ref()
        .child('UserImages')
        .child('ProfilePictures')
        .child('${_auth.getUser!.uid + p.basename(path)}');
    // .child('${DateTime.now().toIso8601String() + p.basename(path)}');

    final result = await ref.putFile(File(path));
    final fileUrl = await result.ref.getDownloadURL();

    setState(() {
      imageUrl = fileUrl;
    });

    // widget.onFileChanged((fileUrl));
  }
}

class AppRoundImageFile extends StatelessWidget {
  final File file;
  final double height;
  final double width;

  const AppRoundImageFile(
      {required this.file, required this.height, required this.width});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: Image.file(file, height: height, width: width),
    );
  }
}
