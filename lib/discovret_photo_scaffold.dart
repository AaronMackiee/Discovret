import 'package:flutter/material.dart';
import 'package:discovret1_0/Constants/discovret_constants.dart';
import 'package:discovret1_0/Components/icons.dart';

class DiscovretScaffold extends StatefulWidget {
  DiscovretScaffold(
      {required this.body,
      required this.index,
      required this.settingsIconColor,
      required this.settingsIconSize,
      required this.qrIconColor,
      required this.qrIconSize,
      required this.searchIconActive,
      required this.mapIconActive,
      required this.profileIconActive});

  final Widget body;
  final int index;
  final Color settingsIconColor;
  final double settingsIconSize;
  final Color qrIconColor;
  final double qrIconSize;
  final Widget searchIconActive;
  final Widget mapIconActive;
  final Widget profileIconActive;

  @override
  _DiscovretScaffoldState createState() => _DiscovretScaffoldState(
      body: body,
      index: index,
      settingsIconColor: settingsIconColor,
      settingsIconSize: settingsIconSize,
      searchIconActive: searchIconActive,
      mapIconActive: mapIconActive,
      qrIconColor: qrIconColor,
      qrIconSize: qrIconSize,
      profileIconActive: profileIconActive);
}

class _DiscovretScaffoldState extends State<DiscovretScaffold> {
  _DiscovretScaffoldState(
      {required this.body,
      required this.index,
      required this.settingsIconColor,
      required this.settingsIconSize,
      required this.qrIconColor,
      required this.qrIconSize,
      required this.searchIconActive,
      required this.mapIconActive,
      required this.profileIconActive});

  final Widget body;
  final int index;
  final Color settingsIconColor;
  final double settingsIconSize;
  final Color qrIconColor;
  final double qrIconSize;
  final Widget searchIconActive;
  final Widget mapIconActive;
  final Widget profileIconActive;

  Color backArrowColor = Colors.black;
  double backArrowSize = 35;

  void onTapNavigator(index) {
    if (index == 0) {
      Navigator.pushNamed(context, 'SearchScreen');
    } else if (index == 1) {
      Navigator.pushNamed(context, 'MapHomeScreen');
    } else if (index == 2) {
      Navigator.pushNamed(context, 'ProfileScreen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          type: BottomNavigationBarType.fixed,
          // iconSize: kinactiveIconSize,
          // unselectedItemColor: kinactiveIconColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          // selectedIconTheme: IconThemeData(size: kactiveIcon),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.person_search,
                    color: kinactiveIconColor, size: kinactiveIconSize),
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
            setState(() {
              onTapNavigator(index);
            });
          },
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_sharp,
              color: Colors.black,
            ),
            onPressed: () {
              backArrowColor = kDiscovretGreen;
              backArrowSize = kactiveIconSize;
              Navigator.pop(context);
            },
            iconSize: 30,
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          title: Text('Discovret',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
          actions: [
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.qr_code_rounded,
                    color: qrIconColor,
                    size: qrIconSize,
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.pushNamed(context, 'QrScannerScreen');
                    });
                    // onTapNavigator(index);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: settingsIconColor,
                    size: settingsIconSize,
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.pushNamed(context, 'SettingsScreen');
                    });
                    // onTapNavigator(index);
                  },
                )
              ],
            )
          ],
        ),
        body: body);
  }
}
