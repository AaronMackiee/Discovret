import 'package:flutter/material.dart';
import 'package:discovret1_0/Constants/discovret_constants.dart';
import 'package:discovret1_0/Components/icons.dart';


class DiscovretNavBar extends StatefulWidget {
  DiscovretNavBar(
    {required this.index,
      required this.searchIconActive,
      required this.mapIconActive,
      required this.profileIconActive}
  );

  final int index;
  final Widget searchIconActive;
  final Widget mapIconActive;
  final Widget profileIconActive;


  @override
  _DiscovretNavBarState createState() => _DiscovretNavBarState(
      index: index,
      searchIconActive: searchIconActive,
      mapIconActive: mapIconActive,
      profileIconActive: profileIconActive);
}

class _DiscovretNavBarState extends State<DiscovretNavBar> {
     _DiscovretNavBarState(
     {required this.index,
      required this.searchIconActive,
      required this.mapIconActive,
      required this.profileIconActive});

  final int index;
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
    );
  }
}


