import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discovret1_0/Constants/discovret_constants.dart';
import 'package:discovret1_0/LogIn Screens/personal_account.dart';
import 'package:discovret1_0/LogIn Screens/business_account.dart';
import 'package:discovret1_0/FirebaseServices/auth_service.dart';
import 'package:discovret1_0/Profile Screens/Compliments/compliments_screen.dart';
import 'package:discovret1_0/Profile Screens/FriendsList%20Screen/activeFriends_List.dart';
import 'package:discovret1_0/Profile Screens/FriendsList%20Screen/closeFriends_list.dart';
import 'package:discovret1_0/Profile Screens/FriendsList%20Screen/friend_search.dart';
import 'package:discovret1_0/Profile%20Screens/FriendsList%20Screen/homeFriends_screen.dart';
import 'package:discovret1_0/Profile Screens/FriendsList%20Screen/inactiveFriends_list.dart';
import 'package:discovret1_0/Profile Screens/FriendsList%20Screen/FriendConfirmations_list.dart';
import 'package:discovret1_0/Profile Screens/FriendsList%20Screen/view_friend_profile.dart';
import 'package:discovret1_0/Profile Screens/FriendsList%20Screen/view_friend_info.dart';
import 'package:discovret1_0/Profile Screens/Info_Screens/info_screen.dart';
import 'package:discovret1_0/Profile Screens/Photo_Screen/add_photo.dart';
import 'package:discovret1_0/Profile Screens/Photo_Screen/view_photo.dart';
import 'package:discovret1_0/LogIn Screens/login_screen.dart';
import 'package:discovret1_0/Profile%20Screens/FriendsList%20Screen/all_friends_screen.dart';
import 'package:discovret1_0/QR Scanner Screens/qr_scanner_screen.dart';
import 'package:discovret1_0/Settings Screens/privacy_security.dart';
import 'package:discovret1_0/Settings Screens/terms_conditions.dart';
import 'package:discovret1_0/FirebaseServices/db_models.dart';
import 'package:discovret1_0/FirebaseServices/globals.dart';
import 'package:discovret1_0/FirebaseServices/db_services.dart';
import 'package:discovret1_0/Settings Screens/settings_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Intro Screens/launching_screen.dart';
import 'Profile Screens/Photo_Screen/photos_screen.dart';
import 'Profile Screens/Wallet_Screens/wallet_screen.dart';
import 'Map Screens/map_home_screen.dart';
import 'Provider Services/account_info_provider.dart';
import 'Provider Services/profile_info_provider.dart';
import 'Provider Services/profile_settings_provider.dart';
import 'QR Scanner Screens/qr_code_home_screen.dart';
import 'ProfileSearch Screens/profile_search_home_screen.dart';
import 'Profile Screens/profile_home_screen.dart';
import 'Profile Screens/Photo_Screen/add_photo.dart';
import 'Profile Screens/Photo_Screen/view_photo.dart';
import 'package:provider/provider.dart';
import 'QR Scanner Screens/understand_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(Discovret());
  });
}

class Discovret extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.black
    // ));
    final FirestoreService _db = FirestoreService();
    return MultiProvider(
      providers: [
        // FutureProvider<AddFriendObject>(
        //     create: (BuildContext context) => _db.addFriendWithQRCode(''),
        //     initialData:
        //       AddFriendObject(
        //         confirmations: [],
        //         activeFriends: [],
        //         gender: '',
        //         uid: '',
        //         allFriends: [],
        //         firstName: '',
        //         lastName: '',
        //         bio: '',
        //         firstLanguage: '',
        //         interestedIn: '',
        //         relationshipStatus: '',
        //         age: 0,
        //         profilePicture: '',
        //         sex: '',
        //         userPictures: [],
        //       )
        //     ),
        StreamProvider<List<AllFriendsObject>>(
            create: (BuildContext context) => _db.getFriendsList(),
            initialData: [
              AllFriendsObject(
                activeFriends: [],
                gender: '',
                uid: '',
                allFriends: [],
                firstName: '',
                lastName: '',
                bio: '',
                firstLanguage: '',
                interestedIn: '',
                relationshipStatus: '',
                age: 0,
                profilePicture: '',
                sex: '',
                userPictures: [],
              )
            ]),
        StreamProvider<List<ConfirmationsObject>>(
            create: (BuildContext context) => _db.getConfirmationsList(),
            initialData: [
              ConfirmationsObject(
                docId: '',
                uids: [],
                uid1: '',
                uid2: '',
                name1: '',
                name2: '',
                profilePicture1: '',
                profilePicture2: '',
                confirmedRequest1: false,
                confirmedRequest2: false,
              )
            ]),
        StreamProvider(
            create: (BuildContext context) => AuthService().streamUser,
            initialData: AuthService().getUser),
        StreamProvider<DbUserDiscSearchList>(
          create: (BuildContext context) => _db.getDiscSearchList(),
          initialData: DbUserDiscSearchList(searchObject: []),
        ),
        StreamProvider(
          create: (BuildContext context) => _db.getUserProfileInfo(),
          initialData: DbUserProfileInfo(
            activeFriends: [],
            gender: '',
            allFriends: [],
            uid: '',
            firstName: '',
            lastName: '',
            bio: '',
            firstLanguage: '',
            interestedIn: '',
            relationshipStatus: '',
            age: 0,
            profilePicture: '',
            sex: '',
            userPictures: [],
          ),
        ),
        StreamProvider<DbUserProfileSearchInfo>(
          create: (BuildContext context) => _db.getUserProfileSearcInfo(),
          initialData: DbUserProfileSearchInfo(
            languages: [],
            countriesLivedIn: [],
            mentoringIn: [],
            hobbiesInterest: [],
            culturalHeritage: [],
            religion: [],
          ),
        ),
        ChangeNotifierProvider(create: (_) => UserAccountInfo()),
        ChangeNotifierProvider(create: (_) => UserProfileInfo()),
        ChangeNotifierProvider(create: (_) => UserProfileSettings())
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColorLight: kDiscovretYellow,
          // inputDecorationTheme: InputDecorationTheme()
        ),
        debugShowCheckedModeBanner: false,
        //load intro screen
        title: 'Discovret',
        initialRoute: LaunchingScreen.id,
        // home: MapHomeScreen.id,
        routes: {
          LaunchingScreen.id: (context) => LaunchingScreen(),
          MapHomeScreen.id: (context) => MapHomeScreen(),
          ProfileScreen.id: (context) => ProfileScreen(),
          ProfileSearch.id: (context) => ProfileSearch(),
          SettingsScreen.id: (context) => SettingsScreen(),
          QrCodeScreen.id: (context) => QrCodeScreen(),
          ProfilePhotosScreen.id: (context) => ProfilePhotosScreen(),
          AddProfilePhoto.id: (context) => AddProfilePhoto(),
          ViewUserPhotos.id: (context) => ViewUserPhotos(),
          DiscovretWallet.id: (context) => DiscovretWallet(),
          ProfileInfo.id: (context) => ProfileInfo(),
          FriendsList.id: (context) => FriendsList(),
          FriendSearch.id: (context) => FriendSearch(),
          FriendConfirmations.id: (context) => FriendConfirmations(),
          AllFriendsList.id: (context) => AllFriendsList(),
          CloseFriendsList.id: (context) => CloseFriendsList(),
          ActiveFriendsList.id: (context) => ActiveFriendsList(),
          InactiveFriendsList.id: (context) => InactiveFriendsList(),
          ComplimentsList.id: (context) => ComplimentsList(),
          ViewProfileFriend.id: (context) => ViewProfileFriend(),
          LogIn.id: (context) => LogIn(),
          PersonalAccount.id: (context) => PersonalAccount(),
          FriendInfo.id: (context) => FriendInfo(),
          TermsConditions.id: (context) => TermsConditions(),
          PrivacySecurity.id: (context) => PrivacySecurity(),
          QrScannerScreen.id: (context) => QrScannerScreen(),
          UnderstandScreen.id: (context) => UnderstandScreen(),
        },
      ),
    );
  }
}
