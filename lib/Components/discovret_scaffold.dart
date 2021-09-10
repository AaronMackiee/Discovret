import 'package:discovret1_0/Components/background_screen.dart';
import 'package:discovret1_0/FirebaseServices/f_storage.dart';
import 'package:discovret1_0/Map Screens/map_home_screen.dart';
import 'package:discovret1_0/Profile Screens/profile_home_screen.dart';
import 'package:discovret1_0/ProfileSearch Screens/profile_search_home_screen.dart';
import 'package:discovret1_0/Provider%20Services/profile_info_provider.dart';
import 'package:discovret1_0/QR%20Scanner Screens/qr_code_home_screen.dart';
import 'package:discovret1_0/Settings Screens/settings_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:discovret1_0/Constants/discovret_constants.dart';
import 'package:discovret1_0/Components/icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class DiscovretScaffold extends StatelessWidget {
  DiscovretScaffold(
      {required this.body,
      required this.index,
      required this.settingsIconColor,
      required this.settingsIconSize,
      required this.qrIconColor,
      required this.qrIconSize,
      required this.searchIconActive,
      required this.mapIconActive,
      required this.profileIconActive,
      this.floatingActionButton,
      this.floatingActionButtonLocation});

  final Widget body;
  final int index;
  final Color settingsIconColor;
  final double settingsIconSize;
  final Color qrIconColor;
  final double qrIconSize;
  final Widget searchIconActive;
  final Widget mapIconActive;
  final Widget profileIconActive;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FirebaseStorageServices _fs = FirebaseStorageServices();
  final UserProfileInfo userProfileInfo = UserProfileInfo();

  void onTapNavigator(context, index) {
    if (index == 0) {
      Navigator.pushNamed(context, ProfileSearch.id);
    } else if (index == 1) {
      Navigator.pushNamed(context, MapHomeScreen.id);
    } else if (index == 2) {
      Navigator.pushNamed(context, ProfileScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Color backArrowColor = Colors.black;
    // double backArrowSize = 35;
    var size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButtonLocation: floatingActionButtonLocation,
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: SizedBox(
          height: deviceHeight * .10,
          child: BottomNavigationBar(
            elevation: 60,
            currentIndex: index,
            type: BottomNavigationBarType.fixed,
            // iconSize: kinactiveIconSize,
            // unselectedItemColor: kinactiveIconColor,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            // selectedIconTheme: IconThemeData(size: kactiveIcon),
            items: [
              BottomNavigationBarItem(
                  icon:
                      // Stack(
                      //   alignment: AlignmentDirectional.topStart,
                      //   clipBehavior: Clip.none,
                      //   children: [
                      Icon(Icons.person_search,
                          color: kinactiveIconColor, size: kinactiveIconSize),
                  //     Positioned(
                  //       top: -7,
                  //       left: -7,
                  //       child: Container(
                  //         height: 20,
                  //         width: 20,
                  //         decoration: BoxDecoration(
                  //           color: Colors.red,
                  //           borderRadius: BorderRadius.all(
                  //             Radius.circular(30),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  label: 'Search',
                  activeIcon: searchIconActive,
                  backgroundColor: Colors.white),
              BottomNavigationBarItem(
                  icon: Icon(MyFlutterApp.discovretmapicon,
                      color: kinactiveIconColor, size: kinactiveIconSize),
                  label: 'Map',
                  activeIcon: mapIconActive,
                  backgroundColor: Colors.white),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_sharp,
                      color: kinactiveIconColor, size: kinactiveIconSize),
                  label: 'Profile',
                  activeIcon: profileIconActive,
                  backgroundColor: Colors.white),
            ],
            onTap: (index) {
              // setState(() {
              onTapNavigator(context, index);
              // });
            },
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_sharp,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            iconSize: 30,
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Icon(DiscMapOutline.disc_map_outline1,
                      color: Colors.black, size: kactiveIconSize),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'iscovret',
                      style: GoogleFonts.markoOne(
                        textStyle: TextStyle(
                            fontSize: kinactiveIconSize,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.qr_code_rounded,
                      color: qrIconColor,
                      size: qrIconSize,
                    ),
                    onPressed: () {
                      // setState(() {
                      Navigator.pushNamed(context, QrCodeScreen.id);
                      // });
                      // onTapNavigator(index);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      // Typicons.cog_outline,
                      Icons.settings,
                      color: settingsIconColor,
                      size: settingsIconSize,
                    ),
                    onPressed: () {
                      // setState(() {
                      Navigator.pushNamed(context, SettingsScreen.id);
                      // });
                      // onTapNavigator(index);
                    },
                  )
                ],
              ),
            )
          ],
        ),
        body: body);
  }
}

// import 'package:discovret1_0/Components/background_screen.dart';
// import 'package:discovret1_0/Map/map_home_screen.dart';
// import 'package:discovret1_0/Profile/profile_home_screen.dart';
// import 'package:discovret1_0/ProfileSearch/profile_search_home_screen.dart';
// import 'package:discovret1_0/QR%20Scanner/qr_code_home_screen.dart';
// import 'package:discovret1_0/Settings/settings_home_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:discovret1_0/Constants/discovret_constants.dart';
// import 'package:discovret1_0/Components/icons.dart';
// import 'package:fluttericon/typicons_icons.dart';
// import 'package:google_fonts/google_fonts.dart';

// class DiscovretScaffold extends StatefulWidget {
//   DiscovretScaffold(
//       {@required this.body,
//       @required this.index,
//       @required this.settingsIconColor,
//       @required this.settingsIconSize,
//       @required this.qrIconColor,
//       @required this.qrIconSize,
//       @required this.searchIconActive,
//       @required this.mapIconActive,
//       @required this.profileIconActive});

//   final Widget body;
//   final int index;
//   final Color settingsIconColor;
//   final double settingsIconSize;
//   final Color qrIconColor;
//   final double qrIconSize;
//   final Widget searchIconActive;
//   final Widget mapIconActive;
//   final Widget profileIconActive;

//   @override
//   _DiscovretScaffoldState createState() => _DiscovretScaffoldState(
//       body: body,
//       index: index,
//       settingsIconColor: settingsIconColor,
//       settingsIconSize: settingsIconSize,
//       searchIconActive: searchIconActive,
//       mapIconActive: mapIconActive,
//       qrIconColor: qrIconColor,
//       qrIconSize: qrIconSize,
//       profileIconActive: profileIconActive);
// }

// class _DiscovretScaffoldState extends State<DiscovretScaffold> {
//   _DiscovretScaffoldState(
//       {@required this.body,
//       @required this.index,
//       @required this.settingsIconColor,
//       @required this.settingsIconSize,
//       @required this.qrIconColor,
//       @required this.qrIconSize,
//       @required this.searchIconActive,
//       @required this.mapIconActive,
//       @required this.profileIconActive});

//   final Widget body;
//   final int index;
//   final Color settingsIconColor;
//   final double settingsIconSize;
//   final Color qrIconColor;
//   final double qrIconSize;
//   final Widget searchIconActive;
//   final Widget mapIconActive;
//   final Widget profileIconActive;

//   Color backArrowColor = Colors.black;
//   double backArrowSize = 35;

//   void onTapNavigator(index) {
//     if (index == 0) {
//       Navigator.pushNamed(context, ProfileSearch.id);
//     } else if (index == 1) {
//       Navigator.pushNamed(context, MapHomeScreen.id);
//     } else if (index == 2) {
//       Navigator.pushNamed(context, ProfileScreen.id);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: index,
//           type: BottomNavigationBarType.fixed,
//           // iconSize: kinactiveIconSize,
//           // unselectedItemColor: kinactiveIconColor,
//           showSelectedLabels: false,
//           showUnselectedLabels: false,
//           // selectedIconTheme: IconThemeData(size: kactiveIcon),
//           items: [
//             BottomNavigationBarItem(
//                 icon:
//                     // Stack(
//                     //   alignment: AlignmentDirectional.topStart,
//                     //   clipBehavior: Clip.none,
//                     //   children: [
//                     Icon(Icons.person_search,
//                         color: kinactiveIconColor, size: kinactiveIconSize),
//                 //     Positioned(
//                 //       top: -7,
//                 //       left: -7,
//                 //       child: Container(
//                 //         height: 20,
//                 //         width: 20,
//                 //         decoration: BoxDecoration(
//                 //           color: Colors.red,
//                 //           borderRadius: BorderRadius.all(
//                 //             Radius.circular(30),
//                 //           ),
//                 //         ),
//                 //       ),
//                 //     ),
//                 //   ],
//                 // ),
//                 label: 'Search',
//                 activeIcon: searchIconActive,
//                 backgroundColor: Colors.white),
//             BottomNavigationBarItem(
//                 icon: Icon(MyFlutterApp.discovretmapicon,
//                     color: kinactiveIconColor, size: kinactiveIconSize),
//                 label: 'Map',
//                 activeIcon: mapIconActive,
//                 backgroundColor: Colors.white),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.account_circle_sharp,
//                     color: kinactiveIconColor, size: kinactiveIconSize),
//                 label: 'Profile',
//                 activeIcon: profileIconActive,
//                 backgroundColor: Colors.white),
//           ],
//           onTap: (index) {
//             // setState(() {
//             onTapNavigator(index);
//             // });
//           },
//         ),
//         appBar: AppBar(
//           leading: IconButton(
//             icon: Icon(
//               Icons.arrow_back_sharp,
//               color: Colors.black,
//             ),
//             onPressed: () {
//               backArrowColor = kDiscovretGreen;
//               backArrowSize = kactiveIconSize;
//               Navigator.pop(context);
//             },
//             iconSize: 30,
//             color: Colors.black,
//           ),
//           backgroundColor: Colors.white,
//           title: Row(
//             children: [
//               Icon(DiscMapOutline.disc_map_outline1,
//                   color: Colors.black, size: 30),
//               FittedBox(
//                 fit: BoxFit.contain,
//                 child: Text(
//                   'iscovret',
//                   style: GoogleFonts.markoOne(
//                     textStyle: TextStyle(
//                         fontSize: 27,
//                         letterSpacing: 1,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 15),
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: Icon(
//                       Icons.qr_code_rounded,
//                       color: qrIconColor,
//                       size: qrIconSize,
//                     ),
//                     onPressed: () {
//                       // setState(() {
//                       Navigator.pushNamed(context, QrCodeScanner.id);
//                       // });
//                       // onTapNavigator(index);
//                     },
//                   ),
//                   IconButton(
//                     icon: Icon(
//                       // Typicons.cog_outline,
//                       Icons.settings,
//                       color: settingsIconColor,
//                       size: settingsIconSize,
//                     ),
//                     onPressed: () {
//                       // setState(() {
//                       Navigator.pushNamed(context, SettingsScreen.id);
//                       // });
//                       // onTapNavigator(index);
//                     },
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//         body: body);
//   }
// }
