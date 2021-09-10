import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discovret1_0/Components/Widgets.dart';
import 'package:discovret1_0/Components/icons.dart';
import 'package:discovret1_0/Constants/discovret_constants.dart';
import 'package:discovret1_0/FirebaseServices/auth_service.dart';
import 'package:discovret1_0/FirebaseServices/db_models.dart';
import 'package:discovret1_0/FirebaseServices/db_services.dart';
import 'package:discovret1_0/LogIn Screens/login_screen.dart';
import 'package:discovret1_0/Map Screens/map_home_screen.dart';
import 'package:discovret1_0/Provider Services/profile_info_provider.dart';
import 'package:discovret1_0/Profile Screens/FriendsList%20Screen/friend_object.dart';
import 'package:discovret1_0/QR%20Scanner Screens/qr_code_home_screen.dart';
import 'package:discovret1_0/Settings Screens/settings_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'understand_screen.dart';

class QrScannerScreen extends StatefulWidget {
  // const QrScannerScreen({ Key? key }) : super(key: key);
  static const String id = 'QrScannerScreen';

  @override
  _QrScannerScreenState createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  FriendObject newFriend = FriendObject();
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final FirestoreService _dbServices = FirestoreService();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final AuthService _auth = AuthService();
  List<String> checkUids = [];
  bool showSpinner = false;
  ConfirmationsObject? confirmObject;
  bool alreadyInConfirmationList = false;
  bool alreadyInFriendsList = false;
  bool? hasBeenScanned;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  Future<bool?> discoverFriendAlert(
      {required BuildContext context, required String uid}) async {
    final _dbUserConfirmations =
        Provider.of<List<ConfirmationsObject>>(context, listen: false);
    final DbUserProfileInfo _dbUserProfileInfo =
        Provider.of<DbUserProfileInfo>(context, listen: false);
    setState(() {
      showSpinner = true;
    });
    final friend = await _dbServices.addFriendWithQRCode(uid);
    checkUids.add(friend.uid!);
    checkUids.add(_auth.getUser!.uid);
    for (confirmObject in _dbUserConfirmations) {
      if (checkUids.contains(confirmObject!.uid1) &
          checkUids.contains(confirmObject!.uid2)) {
        alreadyInConfirmationList = true;
      }
    }
    if (_dbUserProfileInfo.allFriends!.contains(friend.uid)) {
      alreadyInFriendsList = true;
    }
    if ((alreadyInFriendsList == true) | (alreadyInConfirmationList == true)) {
      hasBeenScanned = true;
    } else {
      hasBeenScanned = false;
    }
    setState(() {
      showSpinner = false;
    });
    // final AddFriendObject friend =
    //     Provider.of<AddFriendObject>(context, listen: false);
    // final AddFriendObject friend = AddFriendObject();
    return Alert(
            context: context,
            style: AlertStyle(
              alertBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: BorderSide(
                  width: 2.5,
                  color: kDiscovretYellow,
                ),
              ),
              // overlayColor: Colors.white,
              backgroundColor: Color(0xFF7197FF),
              titleStyle: GoogleFonts.lato(
                  textStyle: TextStyle(
                fontSize: deviceWidth * .07,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
            ),
            type: AlertType.none,
            title: "Good Job!",
            // desc: "Aaron Mackie",
            content: LoadingOverlay(
              isLoading: showSpinner,
              progressIndicator: CircularProgressIndicator(
                color: kDiscovretGreen,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'You Have Discovered',
                      style: TextStyle(fontSize: 18, color: kDiscovretYellow),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    height: deviceWidth * .30,
                    width: deviceWidth * .30,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(friend.profilePicture!),
                    ),
                  ),
                  SizedBox(height: 15),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '${friend.firstName} ${friend.lastName}',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      (hasBeenScanned == false)
                          ? 'Add to Confirmation Queue?'
                          : 'This person has already been added',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            buttons: (hasBeenScanned == false)
                ? [
                    DialogButton(
                      color: kDiscovretGreen,
                      child: Text(
                        "Yes",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        final DbUserProfileInfo dbUserProfileInfo =
                            Provider.of<DbUserProfileInfo>(context,
                                listen: false);
                        _db
                            .collection('FriendConfirmations')
                            .doc('${_auth.getUser!.uid}$uid')
                            .set({
                          'Uids':
                              FieldValue.arrayUnion([_auth.getUser!.uid, uid]),
                          'Uid1': _auth.getUser!.uid,
                          'Uid2': friend.uid,
                          'Name1':
                              '${dbUserProfileInfo.firstName} ${dbUserProfileInfo.lastName}',
                          'Name2': '${friend.firstName} ${friend.lastName}',
                          'ProfilePicture1': dbUserProfileInfo.profilePicture,
                          'ProfilePicture2': friend.profilePicture,
                          'ConfirmedRequest1': false,
                          'ConfirmedRequest2': false,
                          'RejectedRequest1': false,
                          'RejectedRequest2': false,
                          'DocId': '${_auth.getUser!.uid}$uid',
                        }, SetOptions(merge: true));
                        dispose();
                        Navigator.pop(context);
                      },
                      width: 120,
                    ),
                    DialogButton(
                      color: kDiscovretGreen,
                      child: Text(
                        "No",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        dispose();
                        Navigator.pop(context);
                      },
                      width: 120,
                    ),
                  ]
                : [
                    DialogButton(
                      color: kDiscovretGreen,
                      child: Text(
                        "Okay",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        dispose();
                        Navigator.pop(context);
                      },
                      width: 120,
                    ),
                  ])
        .show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(
      //       Icons.arrow_back_sharp,
      //       color: Colors.black,
      //     ),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //     iconSize: 30,
      //     color: Colors.black,
      //   ),
      //   backgroundColor: Colors.white,
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: [
      //       Container(
      //         child: FittedBox(
      //           fit: BoxFit.scaleDown,
      //           child: Icon(DiscMapOutline.disc_map_outline1,
      //               color: Colors.black, size: kactiveIconSize),
      //         ),
      //       ),
      //       Expanded(
      //         child: Container(
      //           alignment: Alignment.centerLeft,
      //           child: FittedBox(
      //             fit: BoxFit.scaleDown,
      //             child: Text(
      //               'iscovret',
      //               style: GoogleFonts.markoOne(
      //                 textStyle: TextStyle(
      //                     fontSize: kinactiveIconSize,
      //                     letterSpacing: 1,
      //                     fontWeight: FontWeight.bold,
      //                     color: Colors.black),
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.only(right: 15),
      //       child: Row(
      //         children: [
      //           IconButton(
      //             icon: Icon(
      //               Icons.qr_code_rounded,
      //               color: kDiscovretYellow,
      //               size: kactiveIconSize,
      //             ),
      //             onPressed: () {
      //               // setState(() {
      //               Navigator.pushNamed(context, QrCodeScreen.id);
      //               // });
      //               // onTapNavigator(index);
      //             },
      //           ),
      //           IconButton(
      //             icon: Icon(
      //               // Typicons.cog_outline,
      //               Icons.settings,
      //               color: kinactiveIconColor,
      //               size: kinactiveIconSize,
      //             ),
      //             onPressed: () {
      //               // setState(() {
      //               Navigator.pushNamed(context, SettingsScreen.id);
      //               // });
      //               // onTapNavigator(index);
      //             },
      //           )
      //         ],
      //       ),
      //     )
      //   ],
      // ),
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          alignment: AlignmentDirectional.topStart,
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              child: _buildQrView(context),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // minimumSize: Size(40, 40),
                    primary: Colors.transparent,
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(30.0),
                    //   side: BorderSide(
                    //     width: 2.5,
                    //     color: kDiscovretYellow,
                    //   ),
                    // ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back, color: Colors.white, size: 30)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  // minimumSize: Size(40, 40),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(30.0),
                  //   side: BorderSide(
                  //     width: 2.5,
                  //     color: kDiscovretYellow,
                  //   ),
                  // ),
                ),
                onPressed: () async {
                  await controller?.toggleFlash();
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: FutureBuilder(
                    future: controller?.getFlashStatus(),
                    builder: (context, snapshot) {
                      if (snapshot.data == true) {
                        return Icon(Elusive.lightbulb);
                      } else
                        return Icon(Icons.lightbulb_outline,
                            color: Colors.white);
                      // return Icon(
                      //     (snapshot.data != null)
                      //         ? Elusive.lightbulb
                      //         : Icons.lightbulb_outline,
                      //     color: Colors.white);
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: deviceHeight * .22),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: SubjectIconTextWhite(
                      text: 'Scan a Discovret Qr Code',
                      fontSize: 16,
                    ),
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(top: deviceHeight * .10),
              child: Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      child: Image(
                        fit: BoxFit.contain,
                        image: AssetImage("assets/Disc_Map2.png"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Discover',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 28,
                            color: Color(0xFFECC84B),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: deviceHeight * .13),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(
                            width: 2.5,
                            color: kDiscovretYellow,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 15),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.qr_code_rounded,
                                  color: Colors.white, size: 26),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: SubjectIconTextWhite(
                                  text: 'View Your Qr Code',
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                ),
              ),
            ),
            // Expanded(
            //   flex: 1,
            //   child: Container(
            //     width: double.infinity,
            //     color: Colors.black,
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: ElevatedButton(
            //         style: ElevatedButton.styleFrom(
            //           primary: Colors.transparent,
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(30.0),
            //             side: BorderSide(
            //               width: 2.5,
            //               color: kDiscovretYellow,
            //             ),
            //           ),
            //         ),
            //         onPressed: () async {
            //           await controller?.toggleFlash();
            //           setState(() {});
            //         },
            //         child: Padding(
            //           padding: const EdgeInsets.all(3.0),
            //           child: FutureBuilder(
            //             future: controller?.getFlashStatus(),
            //             builder: (context, snapshot) {
            //               return
            //                   // Text('Flash: ${snapshot.data}');
            //                   Icon(
            //                       (snapshot.data)
            //                           ? Icons.flash_on
            //                           : Icons.flash_off,
            //                       color: Colors.white);
            //             },
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = deviceWidth * .70;
    // (MediaQuery.of(context).size.width < 400 ||
    //         MediaQuery.of(context).size.height < 400)
    //     ? 150.0
    //     : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      // You can choose between CameraFacing.front or CameraFacing.back. Defaults to CameraFacing.back
      // cameraFacing: CameraFacing.front,
      onQRViewCreated: _onQRViewCreated,
      // Choose formats you want to scan. Defaults to all formats.
      // formatsAllowed: [BarcodeFormat.qrcode],
      overlay: QrScannerOverlayShape(
        borderColor: kDiscovretGreen,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        final String uidString = result!.code;
        print(uidString);
        controller.stopCamera();
        Navigator.pushNamed(context, QrCodeScreen.id);
        discoverFriendAlert(context: context, uid: uidString);
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
    // Navigator.pushNamed(context, MapHomeScreen.id);
  }
}

              // if (result != null)
                    //   Text(
                    //       'Barcode Type: ${(result.format)}   Data: ${result.code}')
                    // else
                    //   Text('Scan a code'),

 // Container(
                        //   margin: EdgeInsets.all(8),
                        //   child: ElevatedButton(
                        //       onPressed: () async {
                        //         await controller?.flipCamera();
                        //         setState(() {});
                        //       },
                        //       child: FutureBuilder(
                        //         future: controller?.getCameraInfo(),
                        //         builder: (context, snapshot) {
                        //           if (snapshot.data != null) {
                        //             return Text(
                        //                 'Camera facing ${(snapshot.data)}');
                        //           } else {
                        //             return Text('loading');
                        //           }
                        //         },
                        //       )),
                        // )

                          // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: <Widget>[
                    //     Container(
                    //       margin: EdgeInsets.all(8),
                    //       child: ElevatedButton(
                    //         onPressed: () async {
                    //           await controller?.pauseCamera();
                    //         },
                    //         child: Text('pause', style: TextStyle(fontSize: 20)),
                    //       ),
                    //     ),
                    //     Container(
                    //       margin: EdgeInsets.all(8),
                    //       child: ElevatedButton(
                    //         onPressed: () async {
                    //           await controller?.resumeCamera();
                    //         },
                    //         child: Text('resume', style: TextStyle(fontSize: 20)),
                    //       ),
                    //     )
                    //   ],
                    // ),
