
import 'package:discovret1_0/Constants/discovret_constants.dart';
import 'package:discovret1_0/QR%20Scanner Screens/qr_code_home_screen.dart';
import 'package:discovret1_0/Settings Screens/settings_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'icons.dart';


// Widget appBar = getAppBar();

class DiscovretAppBar extends StatelessWidget {
  @override
  DiscovretAppBar({
    required this.settingsIconColor,
      required this.settingsIconSize,
      required this.qrIconColor,
      required this.qrIconSize,});
      
  final Color settingsIconColor;
  final double settingsIconSize;
  final Color qrIconColor;
  final double qrIconSize;

  @override
  Widget build(
    BuildContext context,
  ) {
    return AppBar(
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
        );
  }
}


//  Navigator.pushNamed(context, 'SettingsScreen');

// selectedIcon == AppBarIcon.settings
//     ? kappIconColorGreen
//     : kinactiveAppIconColor,
