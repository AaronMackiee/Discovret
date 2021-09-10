import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:discovret1_0/Components/background_screen.dart';
import 'package:discovret1_0/Components/widgets.dart';
import 'package:discovret1_0/Provider Services/profile_info_provider.dart';
import 'package:discovret1_0/FirebaseServices/auth_service.dart';
import 'package:discovret1_0/FirebaseServices/db_models.dart';
import 'package:discovret1_0/FirebaseServices/db_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:discovret1_0/Constants/discovret_constants.dart';
import 'package:discovret1_0/Components/icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Components/discovret_scaffold.dart';
// import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/elusive_icons.dart';

class ProfileSearch extends StatefulWidget {
  static const String id = 'DiscovretSearchScreen';
  @override
  _ProfileSearchState createState() => _ProfileSearchState();
}

class _ProfileSearchState extends State<ProfileSearch>
    with TickerProviderStateMixin {
  TabController? _nestedTabController;

  String? languageSelectedValue;
  String? cultureSelectedValue;
  String? religionSelectedValue;
  String? interestSelectedValue;
  String? mentorSelectedValue;
  String? ideasSelectedValue;
  String? selectedValue;
  AuthService _auth = AuthService();
  @override
  void initState() {
    super.initState();

    _nestedTabController = new TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProfileInfo userProfileInfo =
        Provider.of<UserProfileInfo>(context);
    final DbUserDiscSearchList dbUserSearchList =
        Provider.of<DbUserDiscSearchList>(context);
    final FirestoreService _db = FirestoreService();
    // final User user = Provider.of<User>(context);
    // final User user = Provider.of<User>(context);

    Widget? nullSafetyWidget(
        {int? count, Widget? nullWidget, Widget? unNullWidget}) {
      if (count == 0) {
        return nullWidget;
      } else
        return unNullWidget;
    }

    return DiscovretScaffold(
      index: 0,
      searchIconActive: Icon(Icons.person_search,
          color: kDiscovretYellow, size: kactiveIconSize),
      mapIconActive: Icon(MyFlutterApp.discovretmapicon,
          color: kDiscovretGreen, size: kactiveIconSize),
      profileIconActive: Icon(Icons.account_circle_sharp,
          color: kDiscovretGreen, size: kactiveIconSize),
      settingsIconColor: kinactiveIconColor,
      settingsIconSize: kinactiveIconSize,
      qrIconColor: kinactiveIconColor,
      qrIconSize: kinactiveIconSize,
      body: DiscovretBackground(
        child: ListView(
          children: [
            Divider(thickness: 0, color: Colors.transparent),
            Container(
              height: 70,
              width: double.infinity,
              child: TabBar(
                // indicatorPadding: const EdgeInsets.all(-5),
                // indicator: BoxDecoration(
                //     borderRadius: BorderRadius.circular(40), // Creates border
                //     color: kDiscovretGreen),
                controller: _nestedTabController,
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                labelStyle: TextStyle(fontSize: 18),
                indicatorSize: TabBarIndicatorSize.label,
                unselectedLabelStyle: TextStyle(fontSize: 13),
                isScrollable: true,
                tabs: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Tab(
                      text: "Languages",
                      icon: Icon(
                        Icons.language_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Tab(
                      text: "Cultures",
                      icon: Icon(Icons.flag_sharp, color: Color(0xC4000000)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Tab(
                      text: "Religions",
                      icon: FaIcon(
                        FontAwesomeIcons.prayingHands,
                        size: 20,
                        color: Color(0xC4000000),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Tab(
                      text: "Interests",
                      icon: Icon(
                        Icons.directions_run_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 18),
                  //   child: Container(
                  //     child: Tab(
                  //       text: "Ideas",
                  //       icon: Icon(Elusive.lightbulb,
                  //           size: 23, color: Color(0xC4000000)),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Tab(
                      text: "Mentors",
                      icon: Icon(FontAwesome5.chalkboard_teacher,
                          size: 21, color: Color(0xC4000000)),
                    ),
                  ),
                ],
              ),
            ),
            Divider(thickness: 4, color: kDiscovretYellow),
            Container(
              height: 205,
              width: double.infinity,
              margin: EdgeInsets.only(left: 15.0, right: 15.0),
              child: TabBarView(
                controller: _nestedTabController,
                children: <Widget>[
                  DiscSearchDropDownList(
                    list: userProfileInfo.listLanguages,
                    icon: Icon(
                      Icons.language,
                      size: 37,
                    ),
                    hint: 'Language',
                    searchHint: 'Language',
                    iconText: 'Language',
                    selectedValue: languageSelectedValue,
                    onChangedList: (value) {
                      languageSelectedValue = value;
                    },
                    ontapAdd: () {
                      if (languageSelectedValue != null) {
                        // userProfileInfo.addSearchitem(
                        //     selectedValue: languageSelectedValue,
                        //     textHeader: "Language");
                        _db.addSearchItem(
                            field: 'SearchObjects',
                            item: languageSelectedValue,
                            itemHeader: 'Language');
                      } else {}
                    },
                  ),
                  DiscSearchDropDownList(
                    list: userProfileInfo.listWorldCultures,
                    icon: Icon(
                      Icons.flag,
                      size: 37,
                    ),
                    hint: 'Culture',
                    searchHint: 'Culture',
                    iconText: 'Culture',
                    selectedValue: cultureSelectedValue,
                    onChangedList: (value) {
                      cultureSelectedValue = value;
                    },
                    ontapAdd: () {
                      if (cultureSelectedValue != null) {
                        _db.addSearchItem(
                            field: 'SearchObjects',
                            item: cultureSelectedValue,
                            itemHeader: 'Culture');
                      }
                    },
                  ),
                  DiscSearchDropDownList(
                    list: userProfileInfo.listWorldReligions,
                    icon: FaIcon(
                      FontAwesomeIcons.prayingHands,
                      size: 27,
                      // color: Color(0xC4000000,
                    ),
                    hint: 'Religion',
                    searchHint: 'Religion',
                    iconText: 'Religion',
                    selectedValue: religionSelectedValue,
                    onChangedList: (value) {
                      religionSelectedValue = value;
                    },
                    ontapAdd: () {
                      if (religionSelectedValue != null) {
                        _db.addSearchItem(
                            field: 'SearchObjects',
                            item: religionSelectedValue,
                            itemHeader: "Religion");
                      }
                    },
                  ),
                  DiscSearchDropDownList(
                    list: userProfileInfo.listHobbiesInterest,
                    icon: Icon(Icons.directions_run_rounded, size: 35),
                    hint: 'Interest',
                    searchHint: 'Interest',
                    iconText: 'Interest',
                    selectedValue: interestSelectedValue,
                    onChangedList: (value) {
                      interestSelectedValue = value;
                    },
                    ontapAdd: () {
                      if (interestSelectedValue != null) {
                        _db.addSearchItem(
                            itemHeader: 'Interest',
                            item: interestSelectedValue,
                            field: 'SearchObjects');
                      }
                    },
                  ),
                  // DiscSearchDropDownList(
                  //   list: userProfileInfo.listHobbiesInterest,
                  //   icon: Icon(
                  //     Elusive.lightbulb,
                  //     size: 29,
                  //   ),
                  //   hint: 'Idea',
                  //   searchHint: 'Idea',
                  //   iconText: 'Idea',
                  //   selectedValue: ideasSelectedValue,
                  //   onChangedList: (value) {
                  //     ideasSelectedValue = value;
                  //   },
                  //   ontapAdd: null,
                  // ),
                  DiscSearchDropDownList(
                    list: userProfileInfo.listMentorTopics,
                    icon: Icon(FontAwesome5.chalkboard_teacher, size: 27),
                    hint: 'Mentor',
                    searchHint: 'Mentor',
                    iconText: 'Mentor',
                    selectedValue: mentorSelectedValue,
                    onChangedList: (value) {
                      mentorSelectedValue = value;
                    },
                    ontapAdd: () {
                      if (mentorSelectedValue != null) {
                        _db.addSearchItem(
                            itemHeader: 'Mentor',
                            item: mentorSelectedValue,
                            field: 'SearchObjects');
                      }
                    },
                  ),
                ],
              ),
            ),
            Divider(thickness: 4, color: kDiscovretYellow),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: FittedBox(
                alignment: Alignment.centerLeft,
                fit: BoxFit.scaleDown,
                child: Text(
                  " My Discovret Search List:".toUpperCase(),
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: 18,
                      letterSpacing: 1,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            SizedBox(height: 15),
            nullSafetyWidget(
              count: dbUserSearchList.searchObject!.length,
              nullWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: kDiscovretIconSize - 30,
                    width: kDiscovretIconSize - 30,
                    child: Image.asset("assets/Disc_Map_NoBorders.png"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: SubjectIconTextWhite(
                      text: 'No search items at this time',
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              unNullWidget: ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  // itemCount: userProfileInfo.searchListCount,
                  itemCount: dbUserSearchList.searchObject!.length,
                  itemExtent: 75.0,
                  itemBuilder: (context, index) {
                    // final searchItem = userProfileInfo.listDiscSearch[index];
                    SearchObject searchItem =
                        dbUserSearchList.searchObject![index];
                    return MySearchListTile(
                      // textHeader: searchItem.itemHeader,
                      // textSubHeader: searchItem.item,
                      textHeader: searchItem.itemHeader,
                      textSubHeader: searchItem.item,
                      onDelete: () {
                        _db.deleteDiscSearchObject(
                            field: 'SearchObjects',
                            item: searchItem.item,
                            itemHeader: searchItem.itemHeader);
                        Navigator.pop(context);
                        // userProfileInfo.deleteSearchItem(searchItem);
                        // _db.deleteSearchItem(searchItem);
                      },
                    );
                  }),
            )!,
          ],
        ),
      ),
    );
  }
}
