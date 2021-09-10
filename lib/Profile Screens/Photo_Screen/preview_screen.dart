// import 'dart:io';
// import 'dart:typed_data';
// import 'package:discovret1_0/Components/icons.dart';
// import 'package:discovret1_0/Constants/discovret_constants.dart';
// import 'package:discovret1_0/Provider Services/profile_info_provider.dart';
// import 'package:discovret1_0/QR%20Scanner Screens/qr_code_home_screen.dart';
// import 'package:discovret1_0/Settings Screens/settings_home_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:camera/camera.dart';
// import 'dart:async';
// import 'package:path/path.dart';
// import 'package:provider/provider.dart';
// import 'package:image/image.dart' as img;
// // import 'package:exif/exif.dart';

// class PreviewScreen extends StatefulWidget {
//   final String? imgPath;

//   PreviewScreen({this.imgPath});

//   @override
//   _PreviewScreenState createState() => _PreviewScreenState(imgPath: imgPath);
// }

// class _PreviewScreenState extends State<PreviewScreen> {
//   Uint8List? imageData;
//   final String? imgPath;
//   _PreviewScreenState({this.imgPath});

//   void loadAsset() async {
//     Uint8List data = (await rootBundle.load(imgPath!)).buffer.asUint8List();
//     setState(() => this.imageData = data);
//   }

//   @override
//   void initState() {
//     super.initState();
//     loadAsset();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final UserProfileInfo userProfileInfo =
//         Provider.of<UserProfileInfo>(context);
//     return Scaffold(
//       // appBar: AppBar(
//       //   leading: IconButton(
//       //     icon: Icon(
//       //       Icons.arrow_back_sharp,
//       //       color: Colors.black,
//       //     ),
//       //     onPressed: () {
//       //       Navigator.pop(context);
//       //     },
//       //     iconSize: 30,
//       //     color: Colors.black,
//       //   ),
//       //   backgroundColor: Colors.white,
//       //   title: Row(
//       //     mainAxisAlignment: MainAxisAlignment.start,
//       //     children: [
//       //       Container(
//       //         child: FittedBox(
//       //           fit: BoxFit.scaleDown,
//       //           child: Icon(DiscMapOutline.disc_map_outline1,
//       //               color: Colors.black, size: kactiveIconSize),
//       //         ),
//       //       ),
//       //       Expanded(
//       //         child: Container(
//       //           alignment: Alignment.centerLeft,
//       //           child: FittedBox(
//       //             fit: BoxFit.scaleDown,
//       //             child: Text(
//       //               'iscovret',
//       //               style: GoogleFonts.markoOne(
//       //                 textStyle: TextStyle(
//       //                     fontSize: kinactiveIconSize,
//       //                     letterSpacing: 1,
//       //                     fontWeight: FontWeight.bold,
//       //                     color: Colors.black),
//       //               ),
//       //             ),
//       //           ),
//       //         ),
//       //       ),
//       //     ],
//       //   ),
//       //   actions: [
//       //     Padding(
//       //       padding: const EdgeInsets.only(right: 15),
//       //       child: Row(
//       //         children: [
//       //           IconButton(
//       //             icon: Icon(
//       //               Icons.qr_code_rounded,
//       //               color: kinactiveIconColor,
//       //               size: kinactiveIconSize,
//       //             ),
//       //             onPressed: () {
//       //               // setState(() {
//       //               Navigator.pushNamed(context, QrCodeScreen.id);
//       //               // });
//       //               // onTapNavigator(index);
//       //             },
//       //           ),
//       //           IconButton(
//       //             icon: Icon(
//       //               // Typicons.cog_outline,
//       //               Icons.settings,
//       //               color: kinactiveIconColor,
//       //               size: kinactiveIconSize,
//       //             ),
//       //             onPressed: () {
//       //               // setState(() {
//       //               Navigator.pushNamed(context, SettingsScreen.id);
//       //               // });
//       //               // onTapNavigator(index);
//       //             },
//       //           )
//       //         ],
//       //       ),
//       //     )
//       //   ],
//       // ),
//       body: Container(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Expanded(
//               flex: 2,
//               child: Image.file(
//                 File(widget.imgPath!),
//                 fit: BoxFit.cover,
//                 filterQuality: FilterQuality.high,
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 width: double.infinity,
//                 height: deviceHeight * .13,
//                 color: Colors.black,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.transparent,
//                             borderRadius: BorderRadius.all(Radius.circular(30)),
//                             border:
//                                 Border.all(color: kDiscovretYellow, width: 2.5),
//                           ),
//                           child: TextButton.icon(
//                             onPressed: () {
//                               // print(widget.imgPath);
//                               userProfileInfo.addPhoto(widget.imgPath);
//                               Navigator.pop(context);
//                               // getBytes().then((bytes){
//                               //   Share.file('Share via', basename(widget.imgPath),bytes.buffer.asUint8List(), 'image/path');
//                               // });
//                             },
//                             icon: Icon(
//                               Icons.check_circle_outline_sharp,
//                               color: kDiscovretGreen,
//                             ),
//                             label: Padding(
//                               padding: const EdgeInsets.only(left: 2),
//                               child: Text(
//                                 'Use Photo',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.transparent,
//                             borderRadius: BorderRadius.all(Radius.circular(30)),
//                             border:
//                                 Border.all(color: kDiscovretYellow, width: 2.5),
//                           ),
//                           child: TextButton.icon(
//                             onPressed: () {
//                               Navigator.pop(context);
//                               // getBytes().then((bytes){
//                               //   Share.file('Share via', basename(widget.imgPath),bytes.buffer.asUint8List(), 'image/path');
//                               // });
//                             },
//                             icon: Icon(
//                               Icons.cancel_outlined,
//                               color: Colors.red,
//                             ),
//                             label: Padding(
//                               padding: const EdgeInsets.only(left: 2),
//                               child: Text(
//                                 'Cancel Photo',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

// //converts string into bytedata for photo.
//   Future<ByteData> getBytes() async {
//     Uint8List imageData = File(widget.imgPath!).readAsBytesSync() as Uint8List;
//     return ByteData.view(imageData.buffer);
//   }

//   // Future<File> convertToJPG(String imagePath) async {
//   //   final originalFile = File(imagePath);
//   //   // List<int> imageBytes = await originalFile.readAsBytes();
//   //   // final originalImage = img.decodeImage(imageBytes);
//   //   img.Image fixedImage;
//   //   final fixedFile =
//   //       await originalFile.writeAsBytes(img.encodeJpg(fixedImage));

//   //   return fixedFile;
//   // }

//   Widget _ImageWrapper() {
//     if (imageData == null) {
//       return CircularProgressIndicator();
//     }

//     return Container(
//       width: 150,
//       height: 150,
//       decoration: BoxDecoration(
//         image: new DecorationImage(
//             fit: BoxFit.cover, image: MemoryImage(imageData!, scale: 0.5)),
//       ),
//     );
//   }
// }
