import 'package:discovret1_0/Constants/discovret_constants.dart';
import 'package:discovret1_0/Components/icons.dart';
import 'package:discovret1_0/FirebaseServices/auth_service.dart';
import 'package:discovret1_0/FirebaseServices/db_models.dart';
import 'package:discovret1_0/FirebaseServices/db_services.dart';
import 'package:discovret1_0/FirebaseServices/f_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import '../Components/background_screen.dart';
import '../Components/discovret_scaffold.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:discovret1_0/Provider Services/account_info_provider.dart';
import 'package:discovret1_0/Provider Services/profile_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';
import 'package:location/location.dart' as LocationPackage;

enum AppBarIcon { settings, map, account_profile }

class MapHomeScreen extends StatefulWidget {
  static const String id = 'MapHomeScreen';
  @override
  _MapHomeScreenState createState() => _MapHomeScreenState();
}

class _MapHomeScreenState extends State<MapHomeScreen>
    with SingleTickerProviderStateMixin {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final Firestore _db = Firestore.instance;
  // User loggedInUser;

  MapPolygon _createMapCircle() {
    double radiusInMeters = 2000;
    GeoCircle geoCircle =
        GeoCircle(GeoCoordinates(52.530932, 13.384915), radiusInMeters);

    GeoPolygon geoPolygon = GeoPolygon.withGeoCircle(geoCircle);
    Color fillColor = Color.fromARGB(160, 0, 144, 138);
    MapPolygon mapPolygon = MapPolygon(geoPolygon, fillColor);

    return mapPolygon;
  }

  // Location location = LocationPackage.Location() as Location;

  final FirestoreService _db = FirestoreService();
  bool showSpinner = false;

  void _onMapCreated(HereMapController hereMapController) {
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.hybridDay,
        (MapError? error) {
      if (error != null) {
        print('Map scene not loaded. MapError: ${error.toString()}');
        return;
      }

      const double distanceToEarthInMeters = 8000;
      hereMapController.camera.lookAtPointWithDistance(
          GeoCoordinates(52.530932, 13.384915), distanceToEarthInMeters);

      HereMapController.primaryLanguage;
    });
    _createMapCircle();
    var _mapScene = hereMapController.mapScene;
    var _mapPolygon = _createMapCircle();
    _mapScene.addMapPolygon(_createMapCircle());
  }

  @override
  void initState() {
    super.initState();
  }

  AnimationController? controller;

// AnimationController controller;
// @override
// void initState() {
//   super.initState();

//   controller = AnimationController(
//     upperBound: 100.0,
//     duration: Duration(seconds: 3),
//     vsync: this,
//   );
//   controller.forward();
//   controller.addListener(() {
//     setState(() {
//       controller.value;
//       print(controller.value);
//     });
//   });
// }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: showSpinner,
      progressIndicator: CircularProgressIndicator(
        color: kDiscovretGreen,
      ),
      child: DiscovretScaffold(
        index: 1,
        searchIconActive: Icon(Icons.person_search,
            color: kDiscovretYellow, size: kactiveIconSize),
        mapIconActive: Icon(MyFlutterApp.discovretmapicon,
            color: kDiscovretBlue, size: kactiveIconSize),
        profileIconActive: Icon(Icons.account_circle_sharp,
            color: kDiscovretGreen, size: kactiveIconSize),
        settingsIconColor: kinactiveIconColor,
        settingsIconSize: kinactiveIconSize,
        qrIconColor: kinactiveIconColor,
        qrIconSize: kinactiveIconSize,
        body: Container(
          child:
              DiscovretBackground(child: HereMap(onMapCreated: _onMapCreated)),
        ),
      ),
    );
  }
}

