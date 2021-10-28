// import 'dart:ffi';
// import 'dart:io';
// import 'dart:math';
// import 'package:discovret1_0/Components/Widgets.dart';
// import 'package:discovret1_0/Components/background_screen.dart';
// import 'package:discovret1_0/Components/discovret_scaffold.dart';
// import 'package:discovret1_0/Constants/discovret_constants.dart';
// import 'package:discovret1_0/Components/icons.dart';
// import 'package:discovret1_0/FirebaseServices/auth_service.dart';
// import 'package:discovret1_0/Profile Screens/Photo_Screen/preview_screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:image/image.dart' as img;

class AddProfilePhoto extends StatefulWidget {
  static const String id = 'AddProfilePhotoScreen';
  @override
  _AddProfilePhotoState createState() => _AddProfilePhotoState();
}

class _AddProfilePhotoState extends State<AddProfilePhoto> {
  /////////////////////////////////////////////////////////////////////////////////////////////////////

  // CameraController? cameraController;
  // List<CameraDescription> cameras = [];
  // late int selectedCameraIndex;
  // String? imgPath;

  // Future _initCameraController(CameraDescription cameraDescription) async {
  //   if (cameraController != null) {
  //     await cameraController!.dispose();
  //   }

  //   //dfadefasdfasdf

  //   cameraController =
  //       CameraController(cameraDescription, ResolutionPreset.high);
  //   cameraController!.addListener(() {
  //     if (mounted) {
  //       setState(() {});
  //     }
  //   });
  //   if (cameraController!.value.hasError) {
  //     print('Camera error ${cameraController!.value.errorDescription}');
  //   }

  //   try {
  //     await cameraController!.initialize();
  //   } on CameraException catch (e) {
  //     _showCameraException(e);
  //   }
  // }

  // //Display Camera preview

  // Widget _cameraPreviewWidget() {
  //   if (cameraController == null || !cameraController!.value.isInitialized) {
  //     return const Text('Loading', style: TextStyle(color: Colors.white));
  //   }
  //   return AspectRatio(
  //     aspectRatio: cameraController!.value.aspectRatio,
  //     child: CameraPreview(cameraController!),
  //   );
  // }

  // //Display the control bar with the buttons to take pictures.

  // Widget _cameraControlWidget(context) {
  //   return GestureDetector(
  //     onDoubleTap: () {},
  //     child: Container(
  //       height: 60,
  //       width: 60,
  //       decoration: BoxDecoration(
  //         color: Colors.transparent,
  //         borderRadius: BorderRadius.all(Radius.circular(30)),
  //         border: Border.all(color: kDiscovretYellow, width: 2.5),
  //       ),
  //       child: FloatingActionButton(
  //         // child: Icon(
  //         //   Icons.circle,
  //         //   color: kDiscovretGreen,
  //         // ),
  //         backgroundColor: Colors.white,
  //         onPressed: () {
  //           _onCapturePressed(context);
  //         },
  //       ),
  //     ),
  //   );
  // }

  // //Display a row with a button to select which side of camera to select

  // Widget _cameraToggleRowWidget() {
  //   if (cameras == null || cameras.isEmpty) {
  //     return Spacer();
  //   }

  //   CameraDescription selectedCamera = cameras[selectedCameraIndex];
  //   CameraLensDirection lensDirection = selectedCamera.lensDirection;

  //   return IconButton(
  //     icon: Icon(
  //       _getCameraLensIcon(lensDirection),
  //       color: Colors.white,
  //     ),
  //     onPressed: _onSwitchCamera,
  //   );
  // }

  // // TextButton(
  // //   onPressed: _onSwitchCamera,
  // //   child: Text(
  // //     '${lensDirection.toString().substring(lensDirection.toString().indexOf('.') + 1).toUpperCase()}',
  // //     style: TextStyle(
  // //         color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
  // //   ),
  // // ),

  // @override
  // void initState() {
  //   super.initState();
  //   availableCameras().then((availableCameras) {
  //     cameras = availableCameras;

  //     if (cameras.length > 0) {
  //       setState(() {
  //         selectedCameraIndex = 1;
  //         //Change this number if you want to start with the front or back camera
  //       });
  //       _initCameraController(cameras[selectedCameraIndex]).then((void v) {});
  //     } else {
  //       print('No camera available');
  //     }
  //   }).catchError((err) {
  //     print('Error : ${err.code}');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          // child: SafeArea(
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.stretch,
          //     children: [
          //       Expanded(
          //         flex: 1,
          //         child: _cameraPreviewWidget(),
          //       ),
          //       Align(
          //         alignment: Alignment.bottomCenter,
          //         child: Container(
          //           height: deviceHeight * .15,
          //           width: double.infinity,
          //           padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          //           color: Colors.black,
          //           child: Column(
          //             children: [
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                   Icon(
          //                     Icons.lock_outline,
          //                     color: Colors.white,
          //                     size: 17,
          //                   ),
          //                   Padding(
          //                     padding: const EdgeInsets.only(left: 8),
          //                     child: SubjectIconTextWhite(
          //                       text: 'locked in portrait mode',
          //                       fontSize: 9,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //               Padding(
          //                 padding: const EdgeInsets.only(top: 12),
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //                   children: [
          //                     _cameraToggleRowWidget(),
          //                     Padding(
          //                       padding:
          //                           const EdgeInsets.symmetric(horizontal: 20),
          //                       child: _cameraControlWidget(context),
          //                     ),
          //                     IconButton(
          //                         color: Colors.white,
          //                         icon: Icon(Icons.arrow_back_outlined),
          //                         onPressed: () {
          //                           Navigator.pop(context);
          //                           _cameraOff(context);
          //                         }),
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          ),
    );
    // if (!controller.value.isInitialized) {
    //   return Container();
    // }
    // return MaterialApp(
    //   home: CameraPreview(controller),
    // )
    // ;
  }

  // void _showCameraException(CameraException? e) {
  //   String errortext = 'Error : ${e!.code}\n Error message : ${e.description}';
  //   print(errortext);
  // }

  // void _onCapturePressed(context) async {
  //   try {
  //     final filePath =
  //         join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');

  //     XFile picture;
  //     picture = await cameraController!.takePicture();
  //     picture.saveTo(filePath);
  //     // picture.readAsBytes(picture.e)
  //     // String jpg = filePath.
  //     // Future<File> jpgFilePath = addJPG(filePath);

  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => PreviewScreen(imgPath: filePath),
  //       ),
  //     );

  //     //todo navigate to preview screen

  //   } catch (e) {
  //     // _showCameraException();
  //   }
  // }

  // // Future<File> addJPG(String imagePath) async {
  // //   final originalFile = File(imagePath);
  // //   // List<int> imageBytes = await originalFile.readAsBytes();
  // //   // final originalImage = img.decodeImage(imageBytes);
  // //   late img.Image fixedImage;
  // //   final fixedFile =
  // //       await originalFile.writeAsBytes(img.encodeJpg(fixedImage));

  // //   return fixedFile;
  // // }

  // void _cameraOff(context) {
  //   cameraController!.dispose();
  // }

  // void _onSwitchCamera() {
  //   selectedCameraIndex =
  //       selectedCameraIndex < cameras.length - 1 ? selectedCameraIndex + 1 : 0;

  //   CameraDescription selectedCamera = cameras[selectedCameraIndex];

  //   _initCameraController(selectedCamera);
  // }

  // IconData _getCameraLensIcon(CameraLensDirection lensDirection) {
  //   switch (lensDirection) {
  //     case CameraLensDirection.back:
  //       return CupertinoIcons.switch_camera;
  //     case CameraLensDirection.front:
  //       return CupertinoIcons.switch_camera_solid;
  //     case CameraLensDirection.external:
  //       return CupertinoIcons.photo_camera;
  //     default:
  //       return Icons.device_unknown;
  //   }
  // }
}
