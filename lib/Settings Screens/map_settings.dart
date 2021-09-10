import 'package:discovret1_0/Components/widgets.dart';
import 'package:flutter/material.dart';
import 'package:discovret1_0/Constants/discovret_constants.dart';
import 'package:discovret1_0/Components/icons.dart';
import '../Components/discovret_scaffold.dart';
import '../Components/background_screen.dart';

class MapSettingsScreen extends StatefulWidget {
  @override
  _MapSettingsScreenState createState() => _MapSettingsScreenState();
}

class _MapSettingsScreenState extends State<MapSettingsScreen> {
  bool val = false;
  bool? newval;

  onSwitchValueChanged(bool newval) {
    setState(() {
      val = newval;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DiscovretScaffold(
      index: 2,
      searchIconActive: Icon(Icons.person_search,
          color: kinactiveIconColor, size: kinactiveIconSize),
      mapIconActive: Icon(MyFlutterApp.discovretmapicon,
          color: kinactiveIconColor, size: kinactiveIconSize),
      profileIconActive: Icon(Icons.account_circle_sharp,
          color: kinactiveIconColor, size: kinactiveIconSize),
      settingsIconColor: kDiscovretGreen,
      settingsIconSize: 40,
      qrIconColor: kinactiveIconColor,
      qrIconSize: kinactiveIconSize,
      body: DiscovretBackground(
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
              ),
              child: SubjectIconText(
                text: 'Settings',
                fontSize: 30,
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Icon(Icons.person_outline_rounded,
                      color: kDiscovretGreen, size: 27),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SubjectIconText(
                      text: 'Account',
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            ),
            Divider(
              indent: 20,
              endIndent: 20,
              color: Colors.blueGrey,
              thickness: 0.9,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Change Password',
                    style: TextStyle(fontSize: 17),
                  ),
                  Icon(Icons.arrow_right_rounded,
                      color: Colors.blueGrey, size: 24),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Language',
                    style: TextStyle(fontSize: 17),
                  ),
                  Icon(Icons.arrow_right_rounded,
                      color: Colors.blueGrey, size: 24),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Social',
                    style: TextStyle(fontSize: 17),
                  ),
                  Icon(Icons.arrow_right_rounded,
                      color: Colors.blueGrey, size: 24),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Map',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.arrow_drop_down_rounded,
                      color: kDiscovretGreen, size: 24),
                ],
              ),
            ),
            Divider(
              indent: 20,
              endIndent: 20,
              color: Colors.blueGrey,
              thickness: 0.9,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Entering inside Discovret\nlocations',
                    style: TextStyle(fontSize: 17),
                  ),
                  Switch.adaptive(
                      activeColor: kDiscovretYellow,
                      value: true,
                      onChanged: (bool val) {})
                ],
              ),
            ),
            Divider(
              indent: 20,
              endIndent: 20,
              color: Colors.blueGrey,
              thickness: 0.9,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Wallet',
                    style: TextStyle(fontSize: 17),
                  ),
                  Icon(Icons.arrow_right_rounded,
                      color: Colors.blueGrey, size: 24),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Privacy & Security',
                    style: TextStyle(fontSize: 17),
                  ),
                  Icon(Icons.arrow_right_rounded,
                      color: Colors.blueGrey, size: 24),
                ],
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Icon(Icons.notifications_active_outlined,
                      color: kDiscovretGreen, size: 27),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SubjectIconText(
                      text: 'Notifications',
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            ),
            Divider(
              indent: 20,
              endIndent: 20,
              color: Colors.blueGrey,
              thickness: 0.9,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Account activty',
                    style: TextStyle(fontSize: 17),
                  ),
                  Switch(
                      activeColor: kDiscovretYellow,
                      value: val,
                      onChanged: (newval) {
                        print('true');
                        onSwitchValueChanged(newval);
                      })
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Entering inside Discovret\nlocations',
                    style: TextStyle(fontSize: 17),
                  ),
                  Switch.adaptive(
                      activeColor: kDiscovretYellow,
                      value: true,
                      onChanged: (bool val) {})
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Matched person inside\nDiscovret locations',
                    style: TextStyle(fontSize: 17),
                  ),
                  Switch.adaptive(
                      activeColor: kDiscovretYellow,
                      value: true,
                      onChanged: (bool val) {})
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
