// import 'package:discovret1_0/Components/reusable_body_elements.dart';
import 'package:discovret1_0/Components/widgets.dart';
import 'package:discovret1_0/FirebaseServices/db_models.dart';
import 'package:discovret1_0/LogIn%20Screens/user_image_widget.dart';
import 'package:discovret1_0/Provider Services/account_info_provider.dart';
import 'package:discovret1_0/Provider Services/profile_info_provider.dart';
import 'package:discovret1_0/Provider Services/profile_settings_provider.dart';
import 'package:discovret1_0/QR%20Scanner Screens/qr_scanner_screen.dart';
import 'package:flutter/material.dart';
import 'package:discovret1_0/Constants/discovret_constants.dart';
import 'package:discovret1_0/Components/icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Components/discovret_scaffold.dart';
import '../Components/background_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'understand_screen.dart';

class QrCodeScreen extends StatefulWidget {
  static const String id = 'QrCodeScreen';
  @override
  _QrCodeScreenState createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  // bool newValue;
  // bool _isSwitched = false;
  // String _buttonState = 'Button Enable';

  // onSwitchValueChanged(bool newval) {
  //   setState(() {
  //     val = newval;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final UserProfileInfo userProfileInfo =
        Provider.of<UserProfileInfo>(context);
    final UserProfileSettings userProfileSettings =
        Provider.of<UserProfileSettings>(context);
    final UserAccountInfo userAccountInfo =
        Provider.of<UserAccountInfo>(context);
    final DbUserProfileInfo dbUserProfileInfo =
        Provider.of<DbUserProfileInfo>(context);
    double paddingBorder = deviceWidth - (deviceWidth * .90);
    return DiscovretScaffold(
      index: 2,
      searchIconActive: Icon(Icons.person_search,
          color: kinactiveIconColor, size: kinactiveIconSize),
      mapIconActive: Icon(MyFlutterApp.discovretmapicon,
          color: kinactiveIconColor, size: kinactiveIconSize),
      profileIconActive: Icon(Icons.account_circle_sharp,
          color: kinactiveIconColor, size: kinactiveIconSize),
      settingsIconColor: kinactiveIconColor,
      settingsIconSize: kinactiveIconSize,
      qrIconColor: kDiscovretYellow,
      qrIconSize: kactiveIconSize,
      body: DiscovretBackground(
          child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            border: Border.all(color: kDiscovretYellow, width: 2.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: SubjectIconTextWhite(
                  text:
                      '${dbUserProfileInfo.firstName} ${dbUserProfileInfo.lastName}',
                  fontSize: 28,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Stack(alignment: AlignmentDirectional.center, children: [
                QrImage(
                  eyeStyle: QrEyeStyle(
                      color: Colors.black, eyeShape: QrEyeShape.square),
                  data: '${dbUserProfileInfo.uid}',
                  version: QrVersions.auto,
                  size: deviceWidth * .75,
                  gapless: false,
                  // embeddedImage:
                  //     NetworkImage('${dbUserProfileInfo.profilePicture}'),
                  // embeddedImageStyle: QrEmbeddedImageStyle(
                  //   size: Size(deviceWidth * .10, deviceWidth * .10),
                  // ),
                ),
                Container(
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(90)),
                    border: Border.all(color: Colors.white, width: 3.5),
                  ),
                  child: AppRoundImage.url(dbUserProfileInfo.profilePicture!,
                      height: 60, width: 60),
                ),
              ]),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: AppRoundImage.url(dbUserProfileInfo.profilePicture!,
                  //       height: 30, width: 30),
                  // ),
                  Text(
                    'Your QR Code',
                    style: TextStyle(
                        fontFamily: 'Syne Mono',
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                ],
              ),
              // SizedBox(height: 5),
              // Divider(thickness: 3, color: Colors.blueGrey),
              // SizedBox(height: 10),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 40),
              //   child: Row(
              //     children: [
              //       Container(
              //         height: 30,
              //         width: 30,
              //         child: Image(
              //           fit: BoxFit.contain,
              //           image: AssetImage("assets/Disc_Map2.png"),
              //         ),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.only(left: 8.0),
              //         child: Text(
              //           'Discover',
              //           style: GoogleFonts.lato(
              //             textStyle: TextStyle(
              //               fontSize: 22,
              //               color: Color(0xFFECC84B),
              //               fontWeight: FontWeight.normal,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Expanded(
                child: Container(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, QrScannerScreen.id);
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: kDiscovretGreen,
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  // offset: Offset(3, 5),
                                ),
                              ],
                            ),
                            child: Center(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 3),
                                      child: Icon(
                                        Icons.qr_code_scanner_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Scan QR Code',
                                      style: TextStyle(
                                          fontSize: 14,
                                          letterSpacing: 2.75,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 20)
            ],
          ),
        ),
      )),
    );
  }
}

     // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 30),
              //   child: Row(
              //     children: [
              //       Container(
              //         height: 30,
              //         width: 30,
              //         child: Image(
              //           fit: BoxFit.contain,
              //           image: AssetImage("assets/Disc_Map2.png"),
              //         ),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.only(left: 8.0),
              //         child: Text(
              //           'Discover',
              //           style: GoogleFonts.lato(
              //             textStyle: TextStyle(
              //               fontSize: 25,
              //               color: Color(0xFFECC84B),
              //               fontWeight: FontWeight.normal,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),