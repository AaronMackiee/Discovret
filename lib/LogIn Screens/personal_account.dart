import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discovret1_0/Components/icons.dart';
import 'package:discovret1_0/Components/widgets.dart';
import 'package:discovret1_0/LogIn%20Screens/user_image_widget.dart';
import 'package:discovret1_0/Map Screens/map_home_screen.dart';
import 'package:discovret1_0/Provider Services/account_info_provider.dart';
import 'package:discovret1_0/FirebaseServices/auth_service.dart';
import 'package:discovret1_0/Provider Services/profile_info_provider.dart';
import 'package:discovret1_0/Profile Screens/Photo_Screen/add_photo.dart';
import 'package:discovret1_0/FirebaseServices/f_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_circular_text/circular_text.dart';
import 'package:flutter_circular_text/circular_text/model.dart';
import 'package:flutter_circular_text/circular_text/widget.dart';
import 'package:discovret1_0/Constants/discovret_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_password_strength/flutter_password_strength.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'login_screen.dart';

class PersonalAccount extends StatefulWidget {
  static const String id = 'PersonalAccountScreen';

  @override
  _PersonalAccountState createState() => _PersonalAccountState();
}

class _PersonalAccountState extends State<PersonalAccount>
    with TickerProviderStateMixin {
  TabController? _nestedTabController;
  int _selectedIndex = 0;
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorageServices _fS = FirebaseStorageServices();
  String? email;
  String? password;
  bool showSpinner = false;
  TextEditingController textController = TextEditingController();
  RegExp digitValidator = RegExp(
      '[0123456789!@#%^&*()-=_+;":,./<>?abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ]');
  // bool isANumber = true;

  var _numberFormPicture = GlobalKey<FormState>();
  var _numberFormAccount = GlobalKey<FormState>();
  var _numberFormProfile = GlobalKey<FormState>();
  var _numberFormTerms = GlobalKey<FormState>();
  var _numberFormPrivacy = GlobalKey<FormState>();
  RegExp _numberRegex = RegExp("[0-9]+");
  RegExp _specialCharactersRegex = RegExp("[!@#%^&*()-=_+;':,./<>?}]");
  bool _confirmPasswordVisible = false;
  bool _passwordVisible = false;
  bool isValidFormAccount = false;
  bool isValidFormProfile = false;
  bool isValidFormTerms = false;
  bool isValidFormPrivacy = false;
  bool isValidFormPicture = false;
  bool hasProfilePicture = false;

  String imageUrl = '';
  var imagefile;

  // @override
  // bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _nestedTabController = new TabController(length: 5, vsync: this);
  }

  // bool isChecked = false;
  // bool isChecked1 = false;

  // void setValidator(valid) {
  //   setState(() {
  //     isANumber = valid;
  //   });
  // }

  void checkPictureFormState() {
    if (_numberFormPicture.currentState!.validate()) {
      setState(() {
        isValidFormPicture = true;
      });
    } else {
      setState(() {
        isValidFormPicture = false;
      });
    }
  }

  void checkAccountFormState() {
    if (_numberFormAccount.currentState!.validate()) {
      setState(() {
        isValidFormAccount = true;
      });
    } else {
      setState(() {
        isValidFormAccount = false;
      });
    }
  }

  void checkProfileFormState() {
    if (_numberFormProfile.currentState!.validate()) {
      setState(() {
        isValidFormProfile = true;
      });
    } else {
      setState(() {
        isValidFormProfile = false;
      });
    }
  }

  void checkProfileFormTerms() {
    if (_numberFormTerms.currentState!.validate()) {
      setState(() {
        isValidFormTerms = true;
      });
    } else {
      setState(() {
        isValidFormTerms = false;
      });
    }
  }

  void checkProfileFormPrivacy() {
    if (_numberFormPrivacy.currentState!.validate()) {
      setState(() {
        isValidFormPrivacy = true;
      });
    } else {
      setState(() {
        isValidFormPrivacy = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserProfileInfo userProfileInfo =
        Provider.of<UserProfileInfo>(context);
    final UserAccountInfo userAccountInfo =
        Provider.of<UserAccountInfo>(context);
    // final User user = Provider.of<User>(context);
    AuthService auth = AuthService();
    // String uid;
    var size = MediaQuery.of(context).size;
    // String profilePhoto = userProfileInfo.profilePicture!;

    Widget? nullSafetyWidget(
        {String? photo, Widget? nullWidget, Widget? unNullWidget}) {
      if (photo == null) {
        return nullWidget;
      } else
        return unNullWidget;
    }

    // void getCurrentUserAndPush(context) async {
    //   try {
    //     final User? user = await auth.getUser;
    //     if (user != null) {
    //       Navigator.pushReplacementNamed(context, MapHomeScreen.id);
    //     } else {
    //       Navigator.pushReplacementNamed(context, LogIn.id);
    //     }
    //   } catch (e) {
    //     print(e);
    //   }
    // }

    return Scaffold(
      body: LoadingOverlay(
        isLoading: showSpinner,
        progressIndicator: CircularProgressIndicator(
          color: kDiscovretGreen,
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.1, 0.5, 0.7, 0.9],
              colors: [
                Color(0xFF0045FF),
                Color(0xC20044FF),
                Color(0x7C0044FF),
                Color(0x330044FF),
              ],
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(DiscMapOutline.disc_map_outline1,
                            color: Colors.white, size: 44),
                        Text(
                          'iscovret',
                          style: GoogleFonts.markoOne(
                            textStyle: TextStyle(
                                fontSize: 40,
                                letterSpacing: 5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                  child: GestureDetector(
                    onHorizontalDragEnd: (value) {},
                    child: Container(
                      height: 1000,
                      width: double.infinity,
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: _nestedTabController,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Form(
                              key: _numberFormTerms,
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  border: Border.all(
                                      color: Color(0xFFECC84B), width: 2.5),
                                ),
                                child: ListView(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          'Terms & Conditions',
                                          style: TextStyle(
                                              letterSpacing: 5,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Text(
                                        'First let me recognize that Polaris is a collaborative business and we like to have visibility within the company where our values are recognized with our decision and that they are important to our partners and the extensions of our business. This is why I would consider Polaris staying in the United States. For starters there is the quickness and ease of collaboration between design engineers and technical staff in manufacturing plants. Also, based on pro forma financials, it has the lowest initial costs and highest profit. Our biggest concern is that our economy is slowing down, which means we shouldn’t be making a big investment right now. Our demand for Side-by-Side is forecasted to flatline which means there’s a likelihood that a new manufacturing plant for Side-by-Side wouldn’t help our profits. There are concerns about staying in America which would be the manufacturing talent gap caused by the concern from young students because of the location of our Polaris manufacturing sites in a small town with only Polaris as the only big company. But currently we don’t need to hire any new employees because of the economic slowdown. Once the economy looks promising again, that is when I would maybe consider moving on of the sites closer to our distribution centers.',
                                        style: TextStyle(
                                            letterSpacing: 0,
                                            fontSize: 13.5,
                                            // fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    // CheckboxFormField(
                                    //   title: Text(
                                    //     'Are you at least eighteen years\nor older?',
                                    //     style: TextStyle(
                                    //         letterSpacing: 0,
                                    //         fontSize: 14,
                                    //         fontWeight: FontWeight.bold,
                                    //         color: Colors.black),
                                    //   ),
                                    //   initialValue:
                                    //       userAccountInfo.eighteenPlus,
                                    //   onSaved: (bool value) {
                                    //     userAccountInfo.eighteenPlus = value;
                                    //   },
                                    //   validator: (inputValue) {
                                    //     if (inputValue = null) {
                                    //       return "Field is Required";
                                    //     }
                                    //     return null;
                                    //   },
                                    // ),
                                    FormField<bool>(
                                      builder: (ageState) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: kclearContainer,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Center(
                                                        child: Text(
                                                          'Are you at least eighteen years\nor older?',
                                                          style: TextStyle(
                                                              letterSpacing: 0,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                      Transform.scale(
                                                        scale: 1.5,
                                                        child: Checkbox(
                                                          value: userAccountInfo
                                                              .eighteenPlus,
                                                          onChanged:
                                                              (bool? value) {
                                                            // toggleCheckboxAge(value);
                                                            userAccountInfo
                                                                    .eighteenPlus =
                                                                value;
                                                          },
                                                          checkColor:
                                                              Colors.white,
                                                          focusColor:
                                                              kDiscovretGreen,
                                                          activeColor:
                                                              kDiscovretGreen,
                                                          tristate: false,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  //display error in matching theme
                                                  Column(
                                                    children: [
                                                      Divider(
                                                        color: Colors.blueGrey,
                                                        thickness: 2,
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          ageState.errorText ??
                                                              '',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .errorColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      //output from validation will be displayed in state.errorText (above)
                                      validator: (value) {
                                        if (!userAccountInfo.eighteenPlus!) {
                                          return 'You Must be Eighteen Years or Older ';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    SizedBox(height: 10),
                                    FormField<bool>(
                                      builder: (state) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: kclearContainer,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Center(
                                                        child: Text(
                                                          'Do you accept all terms of this\nagreement?',
                                                          style: TextStyle(
                                                              letterSpacing: 0,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                      Transform.scale(
                                                        scale: 1.5,
                                                        child: Checkbox(
                                                          value: userAccountInfo
                                                              .termsAgreement,
                                                          onChanged:
                                                              (bool? value) {
                                                            // toggleCheckboxAge(value);
                                                            userAccountInfo
                                                                    .termsAgreement =
                                                                value;
                                                          },
                                                          checkColor:
                                                              Colors.white,
                                                          focusColor:
                                                              kDiscovretGreen,
                                                          activeColor:
                                                              kDiscovretGreen,
                                                          tristate: false,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  //display error in matching theme
                                                  Column(
                                                    children: [
                                                      Divider(
                                                        color: Colors.blueGrey,
                                                        thickness: 2,
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          state.errorText ?? '',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .errorColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      //output from validation will be displayed in state.errorText (above)
                                      validator: (value) {
                                        if (!userAccountInfo.termsAgreement!) {
                                          return 'Terms Agreement Must be Accepted';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 17, vertical: 15),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 40,
                                              margin: const EdgeInsets.all(5),
                                              child: ElevatedButton(
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
                                                  primary: kDiscovretGreen,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                ),
                                                child: Icon(Icons
                                                    .arrow_back_ios_new_rounded),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 40,
                                              margin: const EdgeInsets.all(5),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  checkProfileFormTerms();
                                                  if (isValidFormTerms ==
                                                      true) {
                                                    _nestedTabController!
                                                        .animateTo(
                                                            _selectedIndex +=
                                                                1);
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: kDiscovretGreen,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                ),
                                                child: Icon(Icons
                                                    .arrow_forward_ios_rounded),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Form(
                              key: _numberFormPrivacy,
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  border: Border.all(
                                      color: Color(0xFFECC84B), width: 2.5),
                                ),
                                child: ListView(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          'Privacy & Security',
                                          style: TextStyle(
                                              letterSpacing: 5,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Text(
                                        'First let me recognize that Polaris is a collaborative business and we like to have visibility within the company where our values are recognized with our decision and that they are important to our partners and the extensions of our business. This is why I would consider Polaris staying in the United States. For starters there is the quickness and ease of collaboration between design engineers and technical staff in manufacturing plants. Also, based on pro forma financials, it has the lowest initial costs and highest profit. Our biggest concern is that our economy is slowing down, which means we shouldn’t be making a big investment right now. Our demand for Side-by-Side is forecasted to flatline which means there’s a likelihood that a new manufacturing plant for Side-by-Side wouldn’t help our profits. There are concerns about staying in America which would be the manufacturing talent gap caused by the concern from young students because of the location of our Polaris manufacturing sites in a small town with only Polaris as the only big company. But currently we don’t need to hire any new employees because of the economic slowdown. Once the economy looks promising again, that is when I would maybe consider moving on of the sites closer to our distribution centers.',
                                        style: TextStyle(
                                            letterSpacing: 0,
                                            fontSize: 13.5,
                                            // fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    FormField<bool>(
                                      builder: (statePrivacy) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: kclearContainer,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Center(
                                                        child: Text(
                                                          'Do you accept all terms of this\nagreement?',
                                                          style: TextStyle(
                                                              letterSpacing: 0,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                      Transform.scale(
                                                        scale: 1.5,
                                                        child: Checkbox(
                                                          value: userAccountInfo
                                                              .privacyAgreement,
                                                          onChanged:
                                                              (bool? value) {
                                                            // toggleCheckboxAge(value);
                                                            userAccountInfo
                                                                    .privacyAgreement =
                                                                value;
                                                          },
                                                          checkColor:
                                                              Colors.white,
                                                          focusColor:
                                                              kDiscovretGreen,
                                                          activeColor:
                                                              kDiscovretGreen,
                                                          tristate: false,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  //display error in matching theme
                                                  Column(
                                                    children: [
                                                      Divider(
                                                        color: Colors.blueGrey,
                                                        thickness: 2,
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          statePrivacy
                                                                  .errorText ??
                                                              '',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .errorColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      //output from validation will be displayed in state.errorText (above)
                                      validator: (value) {
                                        if (!userAccountInfo
                                            .privacyAgreement!) {
                                          return 'Privacy Agreement Must be Accepted';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 17, vertical: 15),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 40,
                                              margin: const EdgeInsets.all(5),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  _nestedTabController!
                                                      .animateTo(
                                                          _selectedIndex -= 1);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: kDiscovretGreen,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                ),
                                                child: Icon(Icons
                                                    .arrow_back_ios_new_rounded),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 40,
                                              margin: const EdgeInsets.all(5),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  checkProfileFormPrivacy();
                                                  if (isValidFormPrivacy ==
                                                      true) {
                                                    _nestedTabController!
                                                        .animateTo(
                                                            _selectedIndex +=
                                                                1);
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: kDiscovretGreen,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                ),
                                                child: Icon(Icons
                                                    .arrow_forward_ios_rounded),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Form(
                              key: _numberFormProfile,
                              autovalidateMode: AutovalidateMode.disabled,
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  border: Border.all(
                                      color: Color(0xFFECC84B), width: 2.5),
                                ),
                                child: ListView(
                                  addAutomaticKeepAlives: true,
                                  cacheExtent: 20,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          'Profile Info',
                                          style: TextStyle(
                                              letterSpacing: 5,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 15,
                                    // ),

                                    // SizedBox(
                                    //   height: deviceWidth * .30,
                                    //   width: deviceWidth * .30,
                                    //   child: RawMaterialButton(
                                    //     fillColor: Colors.white,
                                    //     shape: CircleBorder(),
                                    //     child: Icon(Icons.add_a_photo,
                                    //         size: deviceWidth * .20 - 20,
                                    //         color: kDiscovretGreen),
                                    //     onPressed: () {
                                    //       Navigator.pushNamed(
                                    //           context, AddProfilePhoto.id);
                                    //     },
                                    //   ),
                                    // ),
                                    // SizedBox(
                                    //   height: 10,
                                    // ),
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Center(
                                    //     child: Text(
                                    //       'Profile Picture',
                                    //       style: TextStyle(
                                    //           letterSpacing: 5,
                                    //           fontSize: 17,
                                    //           fontWeight: FontWeight.normal,
                                    //           color: Colors.white),
                                    //     ),
                                    //   ),
                                    // ),
                                    SizedBox(height: 20),
                                    HeaderSpacer(header: 'First Name'),
                                    TextFormCard(
                                      hintText: 'First Name',
                                      value: userProfileInfo.firstName,
                                      onChanged: (value) {
                                        userProfileInfo.firstName = value;
                                      },
                                    ),
                                    HeaderSpacer(header: 'Last Name'),
                                    TextFormCard(
                                      hintText: 'Last Name',
                                      value: userProfileInfo.lastName,
                                      onChanged: (value) {
                                        userProfileInfo.lastName = value;
                                      },
                                    ),
                                    HeaderSpacer(header: 'Age'),
                                    DropDownFormCardInt(
                                      value: userProfileInfo.age,
                                      onChanged: (int? newValue) {
                                        userProfileInfo.age = newValue;
                                      },
                                      hintText: 'Age',
                                      list: userProfileInfo.listAge,
                                    ),
                                    HeaderSpacer(header: 'Biological Sex'),
                                    DropDownFormCardStr(
                                      value: userProfileInfo.sex,
                                      onChanged: (String? newValue) {
                                        userProfileInfo.sex = newValue;
                                      },
                                      hintText: 'Sex',
                                      list: userProfileInfo.listSex,
                                    ),
                                    HeaderSpacer(header: 'Interested In'),
                                    DropDownFormCardStr(
                                      value: userProfileInfo.interestedIn,
                                      onChanged: (String? newValue) {
                                        userProfileInfo.interestedIn = newValue;
                                      },
                                      hintText: 'Interested In',
                                      list: userProfileInfo.listInterestedIn,
                                    ),
                                    HeaderSpacer(header: 'Relationship Status'),
                                    DropDownFormCardStr(
                                      value: userProfileInfo.relationshipStatus,
                                      onChanged: (String? newValue) {
                                        userProfileInfo.relationshipStatus =
                                            newValue;
                                      },
                                      hintText: 'Relationship Status',
                                      list: userProfileInfo
                                          .listRelationshipStatus,
                                    ),
                                    HeaderSpacer(header: 'First Language'),
                                    DropDownFormCardStr(
                                      value: userProfileInfo.firstLanguage,
                                      onChanged: (String? newValue) {
                                        userProfileInfo.firstLanguage =
                                            newValue;
                                      },
                                      hintText: 'First Language',
                                      list: userProfileInfo.listLanguages,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 17, vertical: 15),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 40,
                                              margin: const EdgeInsets.all(5),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  _nestedTabController!
                                                      .animateTo(
                                                          _selectedIndex -= 1);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: kDiscovretGreen,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                ),
                                                child: Icon(Icons
                                                    .arrow_back_ios_new_rounded),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 40,
                                              margin: const EdgeInsets.all(5),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  print(imageUrl);
                                                  checkProfileFormState();
                                                  if (isValidFormProfile ==
                                                      true) {
                                                    _nestedTabController!
                                                        .animateTo(
                                                            _selectedIndex +=
                                                                1);
                                                  } else {}
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: kDiscovretGreen,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                ),
                                                child: Icon(Icons
                                                    .arrow_forward_ios_rounded),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Form(
                              key: _numberFormAccount,
                              autovalidateMode: AutovalidateMode.always,
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  border: Border.all(
                                      color: Color(0xFFECC84B), width: 2.5),
                                ),
                                child: ListView(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          'Account Info',
                                          style: TextStyle(
                                              letterSpacing: 5,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    HeaderSpacer(header: 'Email'),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            validator: (inputValue) {
                                              if (inputValue!.isEmpty) {
                                                return "Field is Required";
                                              }
                                              return null;
                                            },
                                            initialValue: userAccountInfo.email,
                                            onChanged: (value) {
                                              email = value;
                                              userAccountInfo.email = value;
                                            },
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 17),
                                            decoration: InputDecoration(
                                              labelText: '',
                                              labelStyle:
                                                  TextStyle(fontSize: 1),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              errorStyle:
                                                  TextStyle(color: Colors.red),
                                              hintText: "Email",
                                              // border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        margin: EdgeInsets.all(5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                    HeaderSpacer(header: 'Password'),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Card(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                validator: (inputValue) {
                                                  if (inputValue!.isEmpty) {
                                                    return "Field is Required";
                                                  } else if (userAccountInfo
                                                              .passwordStrength !=
                                                          'Okay' &&
                                                      userAccountInfo
                                                              .passwordStrength !=
                                                          'Strong') {
                                                    return "Required Password Strength: Okay";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                initialValue:
                                                    userAccountInfo.password,
                                                onChanged: (value) {
                                                  userAccountInfo.password =
                                                      value;
                                                  password = value;
                                                },
                                                // 0123456789!@#%^&*()-=_+;":,./<>?abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
                                                keyboardType:
                                                    TextInputType.text,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(
                                                          '[0123456789!@#%^&*()-=_+;":,./<>?abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ]')),
                                                ],
                                                obscureText: !_passwordVisible,
                                                // maxLength: 40,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.blueGrey,
                                                    fontSize: 17),
                                                decoration: InputDecoration(
                                                  hintText: 'Password',
                                                  // helperText: 'Password',
                                                  labelText: "",
                                                  labelStyle:
                                                      TextStyle(fontSize: 11),
                                                  suffixIcon: IconButton(
                                                      color: Colors.blueGrey,
                                                      icon: Icon(
                                                        _passwordVisible
                                                            ? Icons.visibility
                                                            : Icons
                                                                .visibility_off,
                                                        semanticLabel:
                                                            _passwordVisible
                                                                ? 'hide password'
                                                                : 'show password',
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          _passwordVisible ^=
                                                              true;
                                                          //print("Icon button pressed! state: $_passwordVisible"); //Confirmed that the _passwordVisible is toggled each time the button is pressed.
                                                        });
                                                      }),
                                                  errorStyle: TextStyle(
                                                      color: Colors.red),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    horizontal: 10,
                                                  ),

                                                  // border: OutlineInputBorder(
                                                  //     gapPadding: 3),
                                                  // errorText: isANumber
                                                  //     ? null
                                                  //     : "Please enter a number",
                                                  // hintText: "",
                                                  // border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15),
                                              child: FlutterPasswordStrength(
                                                password:
                                                    userAccountInfo.password,
                                                radius: 15,
                                                height: 15,
                                                width: double.infinity,
                                                strengthCallback:
                                                    (strenghtValue) {
                                                  if (strenghtValue == 0) {
                                                    userAccountInfo
                                                        .passwordStrength = "";
                                                  } else if (strenghtValue <
                                                          0.25 &&
                                                      strenghtValue > 0) {
                                                    userAccountInfo
                                                            .passwordStrength =
                                                        'Very Weak';
                                                  } else if (strenghtValue <
                                                          0.50 &&
                                                      strenghtValue > 0.25) {
                                                    userAccountInfo
                                                            .passwordStrength =
                                                        'Weak';
                                                  } else if (strenghtValue <
                                                          0.75 &&
                                                      strenghtValue > 0.50) {
                                                    userAccountInfo
                                                            .passwordStrength =
                                                        'Okay';
                                                  } else if (strenghtValue <
                                                          1 &&
                                                      strenghtValue > 0.75) {
                                                    userAccountInfo
                                                            .passwordStrength =
                                                        'Strong';
                                                  }
                                                },
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                                'Password Strength: ${userAccountInfo.passwordStrength}'),
                                            SizedBox(height: 5),
                                          ],
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                    HeaderSpacer(header: 'Confirm Password'),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            initialValue:
                                                userAccountInfo.confirmPassword,
                                            onChanged: (value) {
                                              userAccountInfo.confirmPassword =
                                                  value;
                                            },
                                            validator: (inputValue) {
                                              if (inputValue!.isEmpty) {
                                                return "Field is Required";
                                              } else if (inputValue !=
                                                  userAccountInfo.password) {
                                                return "Password Doesn't Match";
                                              } else {
                                                return null;
                                              }
                                            },
                                            keyboardType: TextInputType.text,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(
                                                      '[0123456789!@#%^&*()-=_+;":,./<>?abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ]')),
                                              // FilteringTextInputFormatter.allow(
                                              //     RegExp('[a-z]+'))
                                            ],
                                            obscureText:
                                                !_confirmPasswordVisible,
                                            // maxLength: 40,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 17),
                                            decoration: InputDecoration(
                                              labelText: '',
                                              labelStyle:
                                                  TextStyle(fontSize: 11),
                                              suffixIcon: IconButton(
                                                  color: Colors.blueGrey,
                                                  icon: Icon(
                                                    (_confirmPasswordVisible)
                                                        ? Icons.visibility
                                                        : Icons.visibility_off,
                                                    semanticLabel:
                                                        _confirmPasswordVisible
                                                            ? 'hide password'
                                                            : 'show password',
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _confirmPasswordVisible ^=
                                                          true;
                                                      //print("Icon button pressed! state: $_passwordVisible"); //Confirmed that the _passwordVisible is toggled each time the button is pressed.
                                                    });
                                                  }),
                                              hintText: "Confirm Password",
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              errorStyle:
                                                  TextStyle(color: Colors.red),
                                              // border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(
                                    //       horizontal: 17, vertical: 15),
                                    //   child: Row(
                                    //     children: [
                                    //       Expanded(
                                    //         flex: 1,
                                    //         child: Container(
                                    //           height: 40,
                                    //           margin: const EdgeInsets.all(5),
                                    //           child: ElevatedButton(
                                    //             onPressed: () {
                                    //               _nestedTabController!
                                    //                   .animateTo(
                                    //                       _selectedIndex -= 1);
                                    //             },
                                    //             style: ElevatedButton.styleFrom(
                                    //               primary: kDiscovretGreen,
                                    //               shape: RoundedRectangleBorder(
                                    //                 borderRadius:
                                    //                     BorderRadius.circular(
                                    //                         30.0),
                                    //               ),
                                    //             ),
                                    //             child: Icon(Icons
                                    //                 .arrow_back_ios_new_rounded),
                                    //           ),
                                    //         ),
                                    //       ),
                                    //       Expanded(
                                    //         flex: 3,
                                    //         child: Container(
                                    //           height: 40,
                                    //           margin: const EdgeInsets.all(5),
                                    // child: ElevatedButton(
                                    //   onPressed: () async {
                                    //     checkAccountFormState();
                                    //     if (isValidFormAccount ==
                                    //         true) {
                                    //       userProfileInfo
                                    //               .profilePicture =
                                    //           'assets/profile1.jpg';
                                    //       setState(() {
                                    //         showSpinner = true;
                                    //       });
                                    //       try {
                                    //         final UserCredential?
                                    //             newUser =
                                    //             await _auth.createUserWithEmailAndPassword(
                                    //                 email:
                                    //                     userAccountInfo
                                    //                         .email!,
                                    //                 password:
                                    //                     userAccountInfo
                                    //                         .password!);

                                    //         if (newUser != null) {
                                    //           _db
                                    //               .collection(
                                    //                   'UserAccountInfo')
                                    //               .add({
                                    //             'Email':
                                    //                 userAccountInfo
                                    //                     .email,
                                    //             'AgeAggreement':
                                    //                 userAccountInfo
                                    //                     .eighteenPlus,
                                    //             'TermsAggreement':
                                    //                 userAccountInfo
                                    //                     .termsAgreement,
                                    //             'PrivacyAgreement':
                                    //                 userAccountInfo
                                    //                     .privacyAgreement
                                    //           });
                                    //         }
                                    //         final User? user =
                                    //             await auth
                                    //                 .getCurrentUser();
                                    //         if (user != null) {
                                    //           _db
                                    //               .collection(
                                    //                   'UserProfileInfo')
                                    //               .doc(user.uid)
                                    //               .set(
                                    //                   {
                                    //                 'Bio': null,
                                    //                 'FirstName':
                                    //                     userProfileInfo
                                    //                         .firstName,
                                    //                 'LastName':
                                    //                     userProfileInfo
                                    //                         .lastName,
                                    //                 'Age':
                                    //                     userProfileInfo
                                    //                         .age,
                                    //                 'BiologicalSex':
                                    //                     userProfileInfo
                                    //                         .sex,
                                    //                 'InterestedIn':
                                    //                     userProfileInfo
                                    //                         .interestedIn,
                                    //                 'RelationshipStatus':
                                    //                     userProfileInfo
                                    //                         .relationshipStatus,
                                    //                 'FirstLanguage':
                                    //                     userProfileInfo
                                    //                         .firstLanguage,
                                    //                 'Uid': user.uid,
                                    //               },
                                    //                   SetOptions(
                                    //                       merge:
                                    //                           true));

                                    //           _db
                                    //               .collection(
                                    //                   'UserProfileSearchInfo')
                                    //               .doc(user.uid)
                                    //               .set({
                                    //             'Languages':
                                    //                 FieldValue
                                    //                     .arrayUnion(
                                    //                         []),
                                    //             'CountriesLivedIn':
                                    //                 FieldValue
                                    //                     .arrayUnion(
                                    //                         []),
                                    //             'CulturalHeritage':
                                    //                 FieldValue
                                    //                     .arrayUnion(
                                    //                         []),
                                    //             'Religion': FieldValue
                                    //                 .arrayUnion([]),
                                    //             'HobbiesInterest':
                                    //                 FieldValue
                                    //                     .arrayUnion(
                                    //                         []),
                                    //             'MentoringIn':
                                    //                 FieldValue
                                    //                     .arrayUnion(
                                    //                         []),
                                    //           });
                                    //           _db
                                    //               .collection(
                                    //                   'UserDiscSearchList')
                                    //               .doc(user.uid)
                                    //               .set(
                                    //                   {
                                    //                 'SearchObjects':
                                    //                     FieldValue
                                    //                         .arrayUnion(
                                    //                             [])
                                    //               },
                                    //                   SetOptions(
                                    //                       merge:
                                    //                           true));

                                    //           Navigator
                                    //               .pushReplacementNamed(
                                    //                   context,
                                    //                   MapHomeScreen
                                    //                       .id);
                                    //         }
                                    //         setState(() {
                                    //           showSpinner = false;
                                    //         });
                                    //       } catch (e) {
                                    //         print(e);
                                    //       }

                                    //       print(email);
                                    //       print(password);
                                    //     } else {}
                                    //   },
                                    //   style: ElevatedButton.styleFrom(
                                    //     primary: kDiscovretGreen,
                                    //     shape: RoundedRectangleBorder(
                                    //       borderRadius:
                                    //           BorderRadius.circular(
                                    //               30.0),
                                    //     ),
                                    //   ),
                                    //   child: SubjectIconTextWhite(
                                    //     text: 'Register',
                                    //     fontSize: 17,
                                    //   ),
                                    // ),
                                    //   ),
                                    // ),
                                    //     ],
                                    //   ),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 17, vertical: 15),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 40,
                                              margin: const EdgeInsets.all(5),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  _nestedTabController!
                                                      .animateTo(
                                                          _selectedIndex -= 1);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: kDiscovretGreen,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                ),
                                                child: Icon(Icons
                                                    .arrow_back_ios_new_rounded),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 40,
                                              margin: const EdgeInsets.all(5),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  checkAccountFormState();
                                                  if (isValidFormAccount ==
                                                      true) {
                                                    _nestedTabController!
                                                        .animateTo(
                                                            _selectedIndex +=
                                                                1);
                                                  } else {}
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: kDiscovretGreen,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                ),
                                                child: Icon(Icons
                                                    .arrow_forward_ios_rounded),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 50),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Form(
                              key: _numberFormPicture,
                              autovalidateMode: AutovalidateMode.disabled,
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  border: Border.all(
                                      color: Color(0xFFECC84B), width: 2.5),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          'Profile Picture',
                                          style: TextStyle(
                                              letterSpacing: 5,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    UserImage(onFileChanged: (file) {
                                      setState(() {
                                        this.imagefile = file;
                                      });
                                    }),
                                    FormField<bool>(
                                      builder: (statePicture) {
                                        return Column(
                                          children: <Widget>[
                                            // Row(
                                            //   mainAxisAlignment:
                                            //       MainAxisAlignment
                                            //           .spaceBetween,
                                            //   children: [
                                            //     Transform.scale(
                                            //       scale: 0.5,
                                            //       child: Checkbox(
                                            //         value: hasProfilePicture,
                                            //         onChanged: (bool? value) {
                                            //           // toggleCheckboxAge(value);
                                            //           hasProfilePicture =
                                            //               value!;
                                            //         },
                                            //         checkColor:
                                            //             Colors.transparent,
                                            //         focusColor:
                                            //             Colors.transparent,
                                            //         activeColor:
                                            //             Colors.transparent,
                                            //         tristate: false,
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),
                                            //display error in matching theme
                                            Column(
                                              children: [
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    statePicture.errorText ??
                                                        '',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .errorColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        );
                                      },
                                      //output from validation will be displayed in state.errorText (above)
                                      validator: (value) {
                                        if (!userAccountInfo
                                            .hasProfilePicture!) {
                                          return 'Please select a profile picture';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 20,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 17, vertical: 15),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              height: 40,
                                              margin: const EdgeInsets.all(5),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  _nestedTabController!
                                                      .animateTo(
                                                          _selectedIndex -= 1);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: kDiscovretGreen,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                ),
                                                child: Icon(Icons
                                                    .arrow_back_ios_new_rounded),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Container(
                                              height: 40,
                                              margin: const EdgeInsets.all(5),
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  if (imagefile != null) {
                                                    userAccountInfo
                                                            .hasProfilePicture =
                                                        true;
                                                  } else {
                                                    userAccountInfo
                                                            .hasProfilePicture =
                                                        false;
                                                  }
                                                  print(isValidFormPicture);
                                                  checkPictureFormState();

                                                  // checkAccountFormState();
                                                  if (isValidFormPicture ==
                                                      true) {
                                                    // userProfileInfo
                                                    //         .profilePicture =
                                                    //     'assets/profile1.jpg';
                                                    setState(() {
                                                      showSpinner = true;
                                                    });
                                                    try {
                                                      final UserCredential?
                                                          newUser =
                                                          await _auth.createUserWithEmailAndPassword(
                                                              email:
                                                                  userAccountInfo
                                                                      .email!,
                                                              password:
                                                                  userAccountInfo
                                                                      .password!);

                                                      if (newUser != null) {
                                                        _db
                                                            .collection(
                                                                'UserAccountInfo')
                                                            .add({
                                                          'Email':
                                                              userAccountInfo
                                                                  .email,
                                                          'AgeAggreement':
                                                              userAccountInfo
                                                                  .eighteenPlus,
                                                          'TermsAggreement':
                                                              userAccountInfo
                                                                  .termsAgreement,
                                                          'PrivacyAgreement':
                                                              userAccountInfo
                                                                  .privacyAgreement
                                                        });
                                                      }
                                                      final User? user =
                                                          await auth
                                                              .getCurrentUser();
                                                      if (user != null) {
                                                        final String
                                                            currentDateNow =
                                                            DateTime.now()
                                                                .toIso8601String();
                                                        await _fS.uploadUserPhoto(
                                                            path:
                                                                imagefile.path,
                                                            currentTime:
                                                                currentDateNow);
                                                        final imageUrl = await _fS
                                                            .downloadUserPhoto(
                                                                currentTime:
                                                                    currentDateNow);
                                                        userProfileInfo
                                                                .profilePicture =
                                                            imageUrl;
                                                            
                                                        _db
                                                            .collection(
                                                                'UserProfileInfo')
                                                            .doc(user.uid)
                                                            .set(
                                                                {
                                                              'Bio': '',
                                                              'Uid': _auth
                                                                  .currentUser!
                                                                  .uid,
                                                              'FirstName':
                                                                  userProfileInfo
                                                                      .firstName,
                                                              'LastName':
                                                                  userProfileInfo
                                                                      .lastName,
                                                              'Age':
                                                                  userProfileInfo
                                                                      .age,
                                                              'BiologicalSex':
                                                                  userProfileInfo
                                                                      .sex,
                                                              'Gender':
                                                                  userProfileInfo
                                                                      .gender,
                                                              'InterestedIn':
                                                                  userProfileInfo
                                                                      .interestedIn,
                                                              'RelationshipStatus':
                                                                  userProfileInfo
                                                                      .relationshipStatus,
                                                              'FirstLanguage':
                                                                  userProfileInfo
                                                                      .firstLanguage,
                                                              'ProfilePicture':
                                                                  userProfileInfo
                                                                      .profilePicture,
                                                              'UserPictures':
                                                                  FieldValue
                                                                      .arrayUnion([
                                                                userProfileInfo
                                                                    .profilePicture
                                                              ]),
                                                              'AllFriends':
                                                                  FieldValue
                                                                      .arrayUnion(
                                                                          []),
                                                              'Confirmations':
                                                                  FieldValue
                                                                      .arrayUnion(
                                                                          []),
                                                              'ActiveFriends':
                                                                  FieldValue
                                                                      .arrayUnion(
                                                                          []),
                                                            },
                                                                SetOptions(
                                                                    merge:
                                                                        true));

                                                        _db
                                                            .collection(
                                                                'UserProfileSearchInfo')
                                                            .doc(user.uid)
                                                            .set({
                                                          'Languages':
                                                              FieldValue
                                                                  .arrayUnion(
                                                                      []),
                                                          'CountriesLivedIn':
                                                              FieldValue
                                                                  .arrayUnion(
                                                                      []),
                                                          'CulturalHeritage':
                                                              FieldValue
                                                                  .arrayUnion(
                                                                      []),
                                                          'Religion': FieldValue
                                                              .arrayUnion([]),
                                                          'HobbiesInterest':
                                                              FieldValue
                                                                  .arrayUnion(
                                                                      []),
                                                          'MentoringIn':
                                                              FieldValue
                                                                  .arrayUnion(
                                                                      []),
                                                        });
                                                        _db
                                                            .collection(
                                                                'UserDiscSearchList')
                                                            .doc(user.uid)
                                                            .set(
                                                                {
                                                              'SearchObjects':
                                                                  FieldValue
                                                                      .arrayUnion(
                                                                          [])
                                                            },
                                                                SetOptions(
                                                                    merge:
                                                                        true));

                                                        Navigator
                                                            .pushReplacementNamed(
                                                                context,
                                                                MapHomeScreen
                                                                    .id);
                                                      }
                                                      setState(() {
                                                        showSpinner = false;
                                                      });
                                                    } catch (e) {
                                                      print(e);
                                                    }

                                                    // print(email);
                                                    // print(password);
                                                  } else {}

                                                  // checkPictureFormState();
                                                  // if (isValidFormPicture ==
                                                  //     true) {
                                                  //   _fS.uploadProfilePhoto(
                                                  //       imagefile.path);
                                                  // }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: kDiscovretGreen,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                ),
                                                child: SubjectIconTextWhite(
                                                  text: 'Register',
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 50,
                          width: 40,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: IconButton(
                              color: Colors.white,
                              iconSize: 25,
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFF0B9320),
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 2.5,
                                blurRadius: 2.5,
                              ),
                            ],
                            // border: Border.all(color: Color(0xFFECC84B), width: 2.5),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Container(
                            width: 300,
                            height: 80,
                            child: Center(
                              child: IgnorePointer(
                                child: TabBar(
                                  onTap: (value) {
                                    if (_selectedIndex <= 5) {}
                                  },
                                  physics: NeverScrollableScrollPhysics(),
                                  labelStyle: TextStyle(fontSize: 12),
                                  controller: _nestedTabController,
                                  indicatorColor: kDiscovretGreen,
                                  labelColor: Colors.black,
                                  indicatorPadding: EdgeInsets.only(bottom: 1),
                                  labelPadding: EdgeInsets.all(10),
                                  indicatorSize: TabBarIndicatorSize.label,
                                  unselectedLabelColor: Colors.black,
                                  unselectedLabelStyle: TextStyle(fontSize: 8),
                                  isScrollable: true,
                                  tabs: <Widget>[
                                    Tab(
                                      iconMargin: EdgeInsets.only(bottom: 1),
                                      text: 'Terms &\nConditions',
                                      icon: Icon(
                                        Icons.note_outlined,
                                        color: Colors.black,
                                        size: 18,
                                      ),
                                    ),
                                    Tab(
                                      iconMargin: EdgeInsets.only(bottom: 1),
                                      text: "Privacy & \nSecurity",
                                      icon: Icon(
                                        Icons.privacy_tip_outlined,
                                        color: Colors.black,
                                        size: 18,
                                      ),
                                    ),
                                    Tab(
                                      iconMargin: EdgeInsets.only(bottom: 1),
                                      text: "Profile\nInfo",
                                      icon: Icon(Icons.account_circle_outlined,
                                          size: 18, color: Colors.black),
                                    ),
                                    Tab(
                                      iconMargin: EdgeInsets.only(bottom: 1),
                                      text: "Account\nInfo",
                                      icon: Icon(Icons.person_outline_outlined,
                                          size: 18, color: Colors.black),
                                    ),
                                    Tab(
                                      iconMargin: EdgeInsets.only(bottom: 1),
                                      text: "Profile\nPicture",
                                      icon: Icon(Icons.camera_alt_outlined,
                                          size: 18, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              border: Border.all(
                                  color: Color(0xFFECC84B), width: 2.5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
