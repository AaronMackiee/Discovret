import 'package:discovret1_0/Components/background_screen.dart';
import 'package:discovret1_0/Components/discovret_scaffold.dart';
import 'package:discovret1_0/Components/widgets.dart';
import 'package:discovret1_0/FirebaseServices/db_models.dart';
import 'package:discovret1_0/FirebaseServices/db_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:discovret1_0/Constants/discovret_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:discovret1_0/Components/icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ComplimentsList extends StatefulWidget {
  static const String id = 'ComplimentsListScreen';
  @override
  _ComplimentsListState createState() => _ComplimentsListState();
}

Widget? nullSafetyWidget(
    {int? count, Widget? nullWidget, Widget? unNullWidget}) {
  if (count == 0) {
    return nullWidget;
  } else
    return unNullWidget;
}

class _ComplimentsListState extends State<ComplimentsList> {
  FirestoreService _dbServices = FirestoreService();
  @override
  Widget build(BuildContext context) {
    final _dbUserCompliments = Provider.of<List<ComplimentObject>>(context);
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
      body: DiscovretBackground(
        child: ListView(
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
                tag: 'Compliments',
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.thumb_up_off_alt_outlined,
                    size: deviceWidth * .20,
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
                    "My Compliments: ${_dbUserCompliments.length}"
                        .toUpperCase(),
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
            SizedBox(height: 20),
            nullSafetyWidget(
              count: _dbUserCompliments.length,
              nullWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: kDiscovretIconSize,
                    width: kDiscovretIconSize,
                    child: Image.asset("assets/Disc_Map_NoBorders.png"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: SubjectIconTextWhite(
                      text: 'No compliments at this time',
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              unNullWidget: ListView.builder(
                itemCount: _dbUserCompliments.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  final compliment = _dbUserCompliments[index];
                  return ComplimentCard(
                    compliment: compliment.compliment,
                    author: compliment.author,
                    profilePicture: compliment.profilePicture,
                    month: compliment.date.toDate().month.toString(),
                    day: compliment.date.toDate().day.toString(),
                    year: compliment.date.toDate().year.toString(),
                    onPressDelete: () {
                      _dbServices.deleteCompliment(docId: compliment.docId);
                      Navigator.pop(context);
                    },
                  );
                  // ComplimentCard(
                  //   compliment:
                  //       'kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkksssssssssssssssssssssssssssssssssssssssssssss',
                  // ),
                },
              ),
            )!
          ],
        ),
      ),
    );
  }
}


// nullSafetyWidget(
//               count: userProfileInfo.closeFriendsCount,
//               nullWidget: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     height: 40,
//                   ),
//                   Container(
//                     height: kDiscovretIconSize,
//                     width: kDiscovretIconSize,
//                     child: Image.asset("assets/Disc_Map_NoBorders.png"),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Container(
//                     child: SubjectIconTextWhite(
//                       text: 'No close friends at this time',
//                       fontSize: 16,
//                     ),
//                   ),
//                 ],
//               ),
//               unNullWidget: ListView.builder(
//               itemCount: _dbUserCompliments.length,
//               shrinkWrap: true,
//               physics: ScrollPhysics(),
//               itemBuilder: (context, index) {
//                 final compliment = _dbUserCompliments[index];
//                 return ComplimentCard(
//                   compliment: compliment.compliment,
//                   author: compliment.author,
//                   profilePicture: compliment.profilePicture,
//                   month: compliment.date.toDate().month.toString(),
//                   day: compliment.date.toDate().day.toString(),
//                   year: compliment.date.toDate().year.toString(),
//                   onPressDelete: () {
//                     _dbServices.deleteCompliment(docId: compliment.docId);
//                   },
//                 );
//                 // ComplimentCard(
//                 //   compliment:
//                 //       'kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkksssssssssssssssssssssssssssssssssssssssssssss',
//                 // ),
//               },
//             ),
//             )!