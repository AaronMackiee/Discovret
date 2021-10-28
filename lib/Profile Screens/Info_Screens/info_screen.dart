import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discovret1_0/Components/background_screen.dart';
import 'package:discovret1_0/Components/discovret_scaffold.dart';
import 'package:discovret1_0/Components/widgets.dart';
import 'package:discovret1_0/FirebaseServices/auth_service.dart';
import 'package:discovret1_0/Provider Services/profile_info_provider.dart';
import 'package:discovret1_0/Provider Services/profile_settings_provider.dart';
import 'package:discovret1_0/FirebaseServices/db_models.dart';
import 'package:discovret1_0/FirebaseServices/db_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:discovret1_0/Constants/discovret_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:discovret1_0/Components/icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_search/dropdown_search.dart';

class ProfileInfo extends StatefulWidget {
  static const String id = 'ProfileInfoScreen';
  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  final FirebaseFirestore _db1 = FirebaseFirestore.instance;
  final FirestoreService _db = FirestoreService();
  AuthService _auth = AuthService();
  bool addButtonPressed1 = false;
  bool addButtonVisible1 = true;
  bool addButtonPressed2 = false;
  bool addButtonVisible2 = true;
  bool addButtonPressed3 = false;
  bool addButtonVisible3 = true;
  bool addButtonPressed4 = false;
  bool addButtonVisible4 = true;
  bool addButtonPressed5 = false;
  bool addButtonVisible5 = true;
  bool addButtonPressed6 = false;
  bool addButtonVisible6 = true;

  List<String>? newItems;

  @override
  void initState() {
    super.initState();
  }

  void getDbData() async {
    var user = _auth.getUser!;
    // final data = await _db.collection("User Profiles").where(user.uid).get();
    var data =
        await _db1.collection('UserProfileSearchInfo').doc(user.uid).get();
  }

  Widget? addListItemWidget(
      {bool? addItem, Widget? nullWidget, Widget? unNullWidget}) {
    if (addItem == false) {
      return nullWidget;
    } else
      return unNullWidget;
  }

  Widget? addButtonVisibleWidget(
      {bool? buttonVisible, Widget? nullWidget, Widget? unNullWidget}) {
    if (buttonVisible == false) {
      return nullWidget;
    } else
      return unNullWidget;
  }

  @override
  Widget build(BuildContext context) {
    final UserProfileInfo userProfileInfo =
        Provider.of<UserProfileInfo>(context);
    final UserProfileSettings userProfileSettings =
        Provider.of<UserProfileSettings>(context);
    final DbUserProfileInfo dbUserProfileInfo =
        Provider.of<DbUserProfileInfo>(context);
    String? gender = userProfileInfo.getGenderHint();
    // List<int> selectedItems = [];

    return DiscovretScaffold(
      index: 2,
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
      body: GestureDetector(
        onTap: () {
          // FocusScopeNode currentFocus = FocusScope.of(context);
          // if (!currentFocus.hasPrimaryFocus) {
          //   currentFocus.unfocus();
          // }
        },
        child: DiscovretBackground(
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                children: [
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    // child: Container(
                    //   decoration: BoxDecoration(
                    //       color: Colors.transparent,
                    //       borderRadius: BorderRadius.all(Radius.circular(30)),
                    //       border: Border.all(color: kDiscovretBlue, width: 2.5)),
                    child: Hero(
                      tag: 'Profile Info',
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.info_outline_rounded,
                          size: deviceWidth * .25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    indent: 20,
                    endIndent: 20,
                    height: 10,
                    color: kDiscovretYellow,
                    thickness: 2.5,
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Personal Info".toUpperCase(),
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 20,
                              letterSpacing: 1,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Bio:',
                            style: TextStyle(
                                fontSize: 17,
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () {
                                // print(dbUserSearchList.searchObject);
                                // // String item = 'item';
                                // // String itemheader = 'itemheader';
                                // final ref = _db1
                                //     .collection('UserDiscSearchList')
                                //     .doc(_auth.getUser!.uid);

                                // ref.update(
                                //   {
                                //     'SearchObjects': FieldValue.arrayRemove([
                                //       {
                                //         'item': 'Chuukese',
                                //         'itemHeader': 'Language'
                                //       }
                                //     ])
                                //   },
                                // );
                              },
                              style: ElevatedButton.styleFrom(
                                animationDuration: Duration(seconds: 5),
                                elevation: 5,
                                shadowColor: Colors.black,
                                primary: kDiscovretGreen,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  // side: BorderSide(
                                  //   width: 2.5,
                                  //   color: Colors.white,
                                  // ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.save_outlined,
                                      color: Colors.white),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      'Save All',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: EdgeInsets.all(10),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 15),
                        child: TextFormField(
                          maxLines: 10,
                          minLines: 1,
                          keyboardType: TextInputType.name,
                          initialValue: dbUserProfileInfo.bio,
                          textAlign: TextAlign.center,
                          onFieldSubmitted: (value) {
                            userProfileInfo.bio = value;
                            _db.updateProfileInfo(
                                field: 'Bio', value: userProfileInfo.bio);
                          },
                          // onChanged: (value) {
                          //   userProfileInfo.bio = value;
                          //   _db.updateProfileInfo(
                          //       field: 'Bio', value: userProfileInfo.bio);
                          // },
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                          decoration: InputDecoration.collapsed(
                              hintText: 'Bio',
                              hintStyle: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal)
                              // border: InputBorder.none,
                              ),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(height: 0.5),
                  Divider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                  ProfileInfoInputCardTextField(
                    value: dbUserProfileInfo.firstName,
                    textStringParent: "First Name:",
                    hintText: "First Name",
                    textStringchild: (value) {
                      dbUserProfileInfo.firstName = value;
                      // _db.updateProfileInfo(
                      //     field: 'FirstName',
                      //     value: dbUserProfileInfo.firstName);
                    },
                    onFieldSubmitted: (value) {
                      dbUserProfileInfo.firstName = value;
                      _db.updateProfileInfo(
                          field: 'FirstName',
                          value: dbUserProfileInfo.firstName);
                    },
                  ),

                  ProfileInfoInputCardTextField(
                    value: dbUserProfileInfo.lastName,
                    textStringParent: "Last Name:",
                    hintText: "Last Name",
                    textStringchild: (value) {
                      dbUserProfileInfo.lastName = value;
                      // _db.updateProfileInfo(
                      //     field: 'LastName', value: dbUserProfileInfo.lastName);
                    },
                    onFieldSubmitted: (value) {
                      dbUserProfileInfo.lastName = value;
                      _db.updateProfileInfo(
                          field: 'LastName', value: dbUserProfileInfo.lastName);
                    },
                  ),

                  ProfileInfoInputCardDropDownInt(
                    textStringParent: 'Age:',
                    list: userProfileInfo.listAge,
                    valueText: dbUserProfileInfo.age,
                    onChangedText: (value) {
                      dbUserProfileInfo.age = value;
                      _db.updateProfileInfo(
                          field: 'Age', value: dbUserProfileInfo.age);
                    },
                  ),

                  ProfileInfoInputCardDropDownStr(
                    textStringParent: 'Biological Sex:',
                    list: userProfileInfo.listSex,
                    valueText: dbUserProfileInfo.sex,
                    onChangedText: (value) {
                      dbUserProfileInfo.sex = value;
                      _db.updateProfileInfo(
                          field: 'BiologicalSex', value: dbUserProfileInfo.sex);
                    },
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                  ProfileInfoInputCardTextField(
                    textStringParent: "Gender:",
                    hintText: "$gender",
                    textStringchild: (valueGender) {
                      userProfileInfo.gender = valueGender;
                    },
                  ),

                  ProfileInfoInputCardDropDownStr(
                    textStringParent: 'Interested In:',
                    list: userProfileInfo.listInterestedIn,
                    valueText: dbUserProfileInfo.interestedIn,
                    onChangedText: (value) {
                      dbUserProfileInfo.interestedIn = value;
                      _db.updateProfileInfo(
                          field: 'InterestedIn',
                          value: dbUserProfileInfo.interestedIn);
                    },
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                  ProfileInfoInputCardDropDownStr(
                    textStringParent: 'Relationship\nStatus:',
                    list: userProfileInfo.listRelationshipStatus,
                    valueText: dbUserProfileInfo.relationshipStatus,
                    onChangedText: (value) {
                      dbUserProfileInfo.relationshipStatus = value;
                      _db.updateProfileInfo(
                          field: 'RelationshipStatus',
                          value: dbUserProfileInfo.relationshipStatus);
                    },
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                  ProfileInfoInputCardDropDownStr(
                    textStringParent: 'First Language:',
                    list: userProfileInfo.listLanguages,
                    valueText: dbUserProfileInfo.firstLanguage,
                    onChangedText: (value) {
                      dbUserProfileInfo.firstLanguage = value;
                      _db.updateProfileInfo(
                          field: 'FirstLanguage',
                          value: dbUserProfileInfo.firstLanguage);
                    },
                  ),
                  SizedBox(height: 20),
                  Divider(color: kDiscovretYellow, thickness: 7),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Search Info".toUpperCase(),
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 20,
                              letterSpacing: 1,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  SearchInfoInputCard(
                    listViewWidget: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dbUserProfileInfo.languages!.length,
                        itemBuilder: (context, index) {
                          String item = dbUserProfileInfo.languages![index];
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 15, top: 3, bottom: 3),
                            child: Text(
                              item,
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 15),
                            ),
                          );
                        }),
                    itemList: addButtonPressed1,
                    buttonVisible: addButtonVisible1,
                    textStringParent: "Other Languages Spoken:",
                    onPressedAddButton: () {
                      userProfileInfo
                          .clearList(userProfileInfo.listOtherLanguages);
                      setState(() {
                        addButtonPressed1 = true;
                        addButtonVisible1 = false;
                      });
                    },
                    onPressedClearAll: () {
                      _db.deleteProfileInfoList(
                          field: 'Languages',
                          values: userProfileInfo.listOtherLanguages);
                    },
                    hint: 'Languages',
                    searchHint: 'Languages',
                    selectedValues: userProfileInfo.listOtherLanguages,
                    list: userProfileInfo.listLanguages,
                    onChanged: (value) async {
                      userProfileInfo.listOtherLanguages = value;
                      // userProfileInfo.setNewList(
                      //     selectedItems: userProfileInfo.listSelectedLanguages,
                      //     inputList: userProfileInfo.listLanguages,
                      //     userInfoList: userProfileInfo.listOtherLanguages);
                      await _db.updateProfileInfoList(
                          field: 'Languages',
                          value: userProfileInfo.listOtherLanguages);
                      setState(() {
                        addButtonPressed1 = false;
                        addButtonVisible1 = true;
                      });
                    },
                  ),
                  SearchInfoSettingsSwitch(
                    selectedValueDiscSearch:
                        userProfileSettings.infoLanguagesVisibleDiscSearch,
                    selectedValueFriend:
                        userProfileSettings.infoLanguagesVisibleFriends,
                    onChangedDiscSearch: (value) {
                      userProfileSettings.infoLanguagesVisibleDiscSearch =
                          value;
                    },
                    onChangedFriend: (value) {
                      userProfileSettings.infoLanguagesVisibleFriends = value;
                    },
                  ),
                  SearchInfoInputCard(
                    listViewWidget: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dbUserProfileInfo.countriesLivedIn!.length,
                        itemBuilder: (context, index) {
                          String item =
                              dbUserProfileInfo.countriesLivedIn![index];
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 15, top: 3, bottom: 3),
                            child: Text(
                              item,
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 15),
                            ),
                          );
                        }),
                    itemList: addButtonPressed2,
                    buttonVisible: addButtonVisible2,
                    onPressedAddButton: () {
                      userProfileInfo
                          .clearList(userProfileInfo.listCountriesLivedIn);
                      setState(() {
                        addButtonPressed2 = true;
                        addButtonVisible2 = false;
                      });
                    },
                    onPressedClearAll: () {
                      _db.deleteProfileInfoList(
                          field: 'CountriesLivedIn',
                          values: userProfileInfo.listCountriesLivedIn);
                    },
                    textStringParent: "Countries Lived In:",
                    hint: 'Countries',
                    searchHint: 'Countries',
                    selectedValues: userProfileInfo.listCountriesLivedIn,
                    list: userProfileInfo.listCountries,
                    onChanged: (value) async {
                      userProfileInfo.listCountriesLivedIn = value;
                      // userProfileInfo.setNewList(
                      //     selectedItems:
                      //         userProfileInfo.listSelectedCountriesLivedIn,
                      //     inputList: userProfileInfo.listCountries,
                      //     userInfoList: userProfileInfo.listCountriesLivedIn);
                      await _db.updateProfileInfoList(
                          field: 'CountriesLivedIn',
                          value: userProfileInfo.listCountriesLivedIn);
                      setState(() {
                        addButtonPressed2 = false;
                        addButtonVisible2 = true;
                      });
                    },
                  ),
                  SearchInfoSettingsSwitch(
                    selectedValueDiscSearch:
                        userProfileSettings.infoCountriesVisibleDiscSearch,
                    selectedValueFriend:
                        userProfileSettings.infoCountriesVisibleFriends,
                    onChangedDiscSearch: (value) {
                      userProfileSettings.infoCountriesVisibleDiscSearch =
                          value;
                    },
                    onChangedFriend: (value) {
                      userProfileSettings.infoCountriesVisibleFriends = value;
                    },
                  ),
                  SearchInfoInputCard(
                    listViewWidget: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dbUserProfileInfo.culturalHeritage!.length,
                        itemBuilder: (context, index) {
                          String item =
                              dbUserProfileInfo.culturalHeritage![index];
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 15, top: 3, bottom: 3),
                            child: Text(
                              item,
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 15),
                            ),
                          );
                        }),
                    itemList: addButtonPressed3,
                    buttonVisible: addButtonVisible3,
                    onPressedAddButton: () {
                      userProfileInfo.clearList(userProfileInfo.listCultures);
                      setState(() {
                        addButtonPressed3 = true;
                        addButtonVisible3 = false;
                      });
                    },
                    onPressedClearAll: () {
                      _db.deleteProfileInfoList(
                          field: 'CulturalHeritage',
                          values: userProfileInfo.listCultures);
                    },
                    textStringParent: "Cultural Heritage:",
                    hint: 'Cultures',
                    searchHint: 'Cultures',
                    selectedValues: userProfileInfo.listCultures,
                    list: userProfileInfo.listWorldCultures,
                    onChanged: (value) async {
                      userProfileInfo.listCultures = value;
                      // userProfileInfo.setNewList(
                      //     selectedItems: userProfileInfo.listSelectedCultures,
                      //     inputList: userProfileInfo.listWorldCultures,
                      //     userInfoList: userProfileInfo.listCultures);
                      await _db.updateProfileInfoList(
                          field: 'CulturalHeritage',
                          value: userProfileInfo.listCultures);
                      setState(() {
                        addButtonPressed3 = false;
                        addButtonVisible3 = true;
                      });
                    },
                  ),
                  SearchInfoSettingsSwitch(
                    selectedValueDiscSearch:
                        userProfileSettings.infoCulturesVisibleDiscSearch,
                    selectedValueFriend:
                        userProfileSettings.infoCulturesVisibleFriends,
                    onChangedDiscSearch: (value) {
                      userProfileSettings.infoCulturesVisibleDiscSearch = value;
                    },
                    onChangedFriend: (value) {
                      userProfileSettings.infoCulturesVisibleFriends = value;
                    },
                  ),

                  SearchInfoInputCard(
                    listViewWidget: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dbUserProfileInfo.religion!.length,
                        itemBuilder: (context, index) {
                          String item = dbUserProfileInfo.religion![index];
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 15, top: 3, bottom: 3),
                            child: Text(
                              item,
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 15),
                            ),
                          );
                        }),
                    itemList: addButtonPressed4,
                    buttonVisible: addButtonVisible4,
                    onPressedAddButton: () {
                      userProfileInfo
                          .clearList(userProfileInfo.selectedReligions);
                      setState(() {
                        addButtonPressed4 = true;
                        addButtonVisible4 = false;
                      });
                    },
                    onPressedClearAll: () {
                      _db.deleteProfileInfoList(
                          field: 'Religion',
                          values: userProfileInfo.selectedReligions);
                    },
                    textStringParent: "Religions Practiced:",
                    hint: 'Religions',
                    searchHint: 'Religions',
                    selectedValues: userProfileInfo.selectedReligions,
                    list: userProfileInfo.listWorldReligions,
                    onChanged: (value) async {
                      userProfileInfo.selectedReligions = value;
                      // userProfileInfo.setNewListOne(
                      //     selectedItems: userProfileInfo.selectedReligions,
                      //     inputList: userProfileInfo.listWorldReligions,
                      //     userInfoList: userProfileInfo.religions);
                      // userProfileInfo.addReligion(userProfileInfo.religions);
                      await _db.updateProfileInfoList(
                          field: 'Religion',
                          value: userProfileInfo.selectedReligions);
                      setState(() {
                        addButtonPressed4 = false;
                        addButtonVisible4 = true;
                      });
                    },
                  ),

                  SearchInfoSettingsSwitch(
                    selectedValueDiscSearch:
                        userProfileSettings.infoReligionVisibleDiscSearch,
                    selectedValueFriend:
                        userProfileSettings.infoReligionVisibleFriends,
                    onChangedDiscSearch: (value) {
                      userProfileSettings.infoReligionVisibleDiscSearch = value;
                    },
                    onChangedFriend: (value) {
                      userProfileSettings.infoReligionVisibleFriends = value;
                    },
                  ),

                  SearchInfoInputCard(
                    listViewWidget: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dbUserProfileInfo.hobbiesInterest!.length,
                        itemBuilder: (context, index) {
                          String item =
                              dbUserProfileInfo.hobbiesInterest![index];
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 15, top: 3, bottom: 3),
                            child: Text(
                              item,
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 15),
                            ),
                          );
                        }),
                    itemList: addButtonPressed5,
                    buttonVisible: addButtonVisible5,
                    onPressedAddButton: () {
                      userProfileInfo.clearList(userProfileInfo.listInterest);
                      setState(() {
                        addButtonPressed5 = true;
                        addButtonVisible5 = false;
                      });
                    },
                    onPressedClearAll: () {
                      _db.deleteProfileInfoList(
                          field: 'HobbiesInterest',
                          values: userProfileInfo.listInterest);
                    },
                    textStringParent: "Hobbies/Interest:",
                    hint: 'Hobbies/Interest',
                    searchHint: 'Hobbies/Interest',
                    selectedValues: userProfileInfo.listInterest,
                    list: userProfileInfo.listHobbiesInterest,
                    onChanged: (value) async {
                      userProfileInfo.listInterest = value;
                      // userProfileInfo.setNewList(
                      //     selectedItems: userProfileInfo.listSelectedInterest,
                      //     inputList: userProfileInfo.listHobbiesInterest,
                      //     userInfoList: userProfileInfo.listInterest);
                      await _db.updateProfileInfoList(
                          field: 'HobbiesInterest',
                          value: userProfileInfo.listInterest);
                      setState(() {
                        addButtonPressed5 = false;
                        addButtonVisible5 = true;
                      });
                    },
                  ),
                  SearchInfoSettingsSwitch(
                    selectedValueDiscSearch:
                        userProfileSettings.infoInterestVisibleDiscSearch,
                    selectedValueFriend:
                        userProfileSettings.infoInterestVisibleFriends,
                    onChangedDiscSearch: (value) {
                      userProfileSettings.infoInterestVisibleDiscSearch = value;
                    },
                    onChangedFriend: (value) {
                      userProfileSettings.infoInterestVisibleFriends = value;
                    },
                  ),
                  Divider(
                    color: Colors.blueGrey,
                  ),
                  SearchInfoInputCard(
                    listViewWidget: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dbUserProfileInfo.mentoringIn!.length,
                        itemBuilder: (context, index) {
                          String item = dbUserProfileInfo.mentoringIn![index];
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 15, top: 3, bottom: 3),
                            child: Text(
                              item,
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 15),
                            ),
                          );
                        }),
                    itemList: addButtonPressed6,
                    buttonVisible: addButtonVisible6,
                    onPressedAddButton: () {
                      userProfileInfo
                          .clearList(userProfileInfo.listMentoringIn);
                      setState(() {
                        addButtonPressed6 = true;
                        addButtonVisible6 = false;
                      });
                    },
                    onPressedClearAll: () {
                      _db.deleteProfileInfoList(
                          field: 'MentoringIn',
                          values: userProfileInfo.listMentoringIn);
                    },
                    textStringParent: "Mentoring Others In:",
                    hint: 'Mentor Topics',
                    searchHint: 'Mentor Topics',
                    selectedValues: userProfileInfo.listMentoringIn,
                    list: userProfileInfo.listMentorTopics,
                    onChanged: (value) async {
                      userProfileInfo.listMentoringIn = value;
                      // userProfileInfo.setNewList(
                      //     selectedItems:
                      //         userProfileInfo.listSelectedMentoringIn,
                      //     inputList: userProfileInfo.listMentorTopics,
                      //     userInfoList: userProfileInfo.listMentoringIn);
                      await _db.updateProfileInfoList(
                          field: 'MentoringIn',
                          value: userProfileInfo.listMentoringIn);
                      setState(() {
                        addButtonPressed6 = false;
                        addButtonVisible6 = true;
                      });
                    },
                  ),
                  SearchInfoSettingsSwitch(
                    selectedValueDiscSearch:
                        userProfileSettings.infoMentoringInVisibleDiscSearch,
                    selectedValueFriend:
                        userProfileSettings.infoMentoringInVisibleFriends,
                    onChangedDiscSearch: (value) {
                      userProfileSettings.infoMentoringInVisibleDiscSearch =
                          value;
                    },
                    onChangedFriend: (value) {
                      userProfileSettings.infoMentoringInVisibleFriends = value;
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// DropdownButton<String>(
//                   onTap: () {
//                     print(userProfileInfo.sex);
//                   },
//                   value: userProfileInfo.sex,
//                   // hint: Text('Sex'),
//                   elevation: 16,
//                   isExpanded: true,
//                   style: const TextStyle(fontSize: 17, color: Colors.blueGrey),
//                   // underline: Container(
//                   //   height: 2,
//                   //   color: Colors.deepPurpleAccent,
//                   // ),
//                   onChanged: (String newValue) {
//                     setState(() {
//                       userProfileInfo.sex = newValue;
//                     });
//                   },
//                   items: userProfileInfo.listSex
//                       .map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                 ),
