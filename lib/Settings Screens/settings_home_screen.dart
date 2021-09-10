import 'package:discovret1_0/Components/widgets.dart';
import 'package:discovret1_0/Login Screens/login_screen.dart';
import 'package:discovret1_0/Provider%20Services/profile_settings_provider.dart';
import 'package:discovret1_0/FirebaseServices/auth_service.dart';
import 'package:discovret1_0/Settings Screens/privacy_security.dart';
import 'package:discovret1_0/Settings Screens/terms_conditions.dart';
import 'package:flutter/material.dart';
import 'package:discovret1_0/Constants/discovret_constants.dart';
import 'package:discovret1_0/Components/icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../Components/discovret_scaffold.dart';
import '../Components/background_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SettingsScreen extends StatefulWidget {
  static const String id = 'SettingsScreen';
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AuthService auth = AuthService();
  bool val = false;
  void signOutAlert(context) {
    Alert(
      context: context,
      image: Icon(
        Icons.person_outline,
        color: Colors.black,
      ),
      title: "Sign Out",
      desc: "Are you sure you want to sign out?",
      buttons: [
        DialogButton(
          color: kDiscovretGreen,
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            auth.signOut();
            Navigator.pushReplacementNamed(context, LogIn.id);
          },
          width: 120,
        ),
        DialogButton(
          color: kDiscovretGreen,
          child: Text(
            "No",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    final UserProfileSettings userProfileSettings =
        Provider.of<UserProfileSettings>(context);
    return DiscovretScaffold(
      index: 2,
      searchIconActive: Icon(Icons.person_search,
          color: kinactiveIconColor, size: kinactiveIconSize),
      mapIconActive: Icon(MyFlutterApp.discovretmapicon,
          color: kinactiveIconColor, size: kinactiveIconSize),
      profileIconActive: Icon(Icons.account_circle_sharp,
          color: kinactiveIconColor, size: kinactiveIconSize),
      settingsIconColor: kDiscovretGreen,
      settingsIconSize: kactiveIconSize,
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
              child: Text(
                "Settings".toUpperCase(),
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 25,
                    letterSpacing: 1,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SettingsHeader(
                title: 'Account', icontype: Icons.person_outline_rounded),
            SettingsHeaderChildArrow(title: 'Change Password', ontap: null),
            SettingsHeaderChildArrow(
                title: 'Language',
                ontap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Container(
                          color: Color(0xff757575),
                          child: Container(
                            padding: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  'Add Task',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.lightBlueAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            SettingsHeaderChildArrow(
                title: 'Privacy & Security',
                ontap: () {
                  Navigator.pushNamed(context, PrivacySecurity.id);
                }),
            SettingsHeaderChildArrow(
                title: 'Terms & Conditions',
                ontap: () {
                  Navigator.pushNamed(context, TermsConditions.id);
                }),
            SettingsHeaderChildArrow(
              title: 'More Info',
              ontap: () {
                showAboutDialog(
                    applicationName: 'Discovret',
                    context: context,
                    applicationVersion: '1.0',
                    applicationLegalese: 'Discovret LLC.',
                    applicationIcon: Container(
                      height: 40.0,
                      width: 40.0,
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Image.asset("assets/Disc_Map_NoBorders.png"),
                      ),
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                            colors: [Color(0xFF0045FF), Colors.white],
                            stops: [-1.5, 2.0],
                            radius: 1.5,
                            focalRadius: 2.0,
                            tileMode: TileMode.clamp),
                        shape: BoxShape.circle,
                      ),
                    ));
              },
            ),
            SettingsHeaderChildArrow(
                title: 'Sign out',
                ontap: () {
                  setState(() {
                    signOutAlert(context);
                  });
                }),
            SettingsHeader(
                title: 'Map', icontype: DiscMapOutline.disc_map_outline1),
            SettingsHeaderChildSwitch(
              title: 'Enable Location',
              switchValue: userProfileSettings.mapEnableLocation,
              onChanged: (value) {
                userProfileSettings.mapEnableLocation = value;
              },
            ),
            SettingsHeaderChildSwitch(
              title: 'Enable close friends to\nview your location',
              switchValue: userProfileSettings.mapLocationViewCloseFriends,
              onChanged: (value) {
                userProfileSettings.mapLocationViewCloseFriends = value;
              },
            ),
            SettingsHeaderChildSwitch(
              title: 'Enable active friends to\nview your location',
              switchValue: userProfileSettings.mapLocationViewActiveFriends,
              onChanged: (value) {
                userProfileSettings.mapLocationViewActiveFriends = value;
              },
            ),
            SettingsHeader(
                title: 'Wallet',
                icontype: Icons.account_balance_wallet_outlined),
            SettingsHeaderChildSwitch(
              title: 'Enable pin password to\nget inside wallet',
              switchValue: userProfileSettings.walletPinEnabled,
              onChanged: (value) {
                userProfileSettings.walletPinEnabled = value;
              },
            ),
            SettingsHeader(
                title: 'Profile', icontype: Icons.account_circle_outlined),
            SettingsHeaderChildSwitch(
              title: 'Allow friends to view \nyour friends list.',
              switchValue: userProfileSettings.profileFriendListView,
              onChanged: (value) {
                userProfileSettings.profileFriendListView = value;
              },
            ),
            SettingsHeader(
                title: 'Notifications',
                icontype: Icons.notifications_active_outlined),
            SettingsHeaderChildSwitch(
              title: 'Entering inside Discovret\nlocations',
              switchValue:
                  userProfileSettings.notificationsEnteringDiscLocations,
              onChanged: (value) {
                userProfileSettings.notificationsEnteringDiscLocations = value;
              },
            ),
            SettingsHeaderChildSwitch(
              title: 'Matched person inside\nDiscovret locations',
              switchValue: userProfileSettings.notifcationsMatchedPerson,
              onChanged: (value) {
                userProfileSettings.notifcationsMatchedPerson = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}
