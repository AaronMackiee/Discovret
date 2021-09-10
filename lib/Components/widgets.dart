import 'dart:io';
import 'dart:typed_data';

import 'package:discovret1_0/Components/icons.dart';
import 'package:discovret1_0/Constants/discovret_constants.dart';
import 'package:discovret1_0/Provider Services/profile_info_provider.dart';
import 'package:discovret1_0/Profile Screens/FriendsList%20Screen/view_friend_profile.dart';
import 'package:discovret1_0/Profile Screens/Photo_Screen/add_photo.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_circular_text/circular_text.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
// import 'package:searchable_dropdown/searchable_dropdown.dart';

enum ButtonAnswer { yes, no }

class ProfileInfoCard extends StatelessWidget {
  ProfileInfoCard({required this.cardBody, required this.onpress});

  final Widget cardBody;
  final Function onpress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress as void Function()?,
      child: Container(
        child: cardBody,
        height: 110,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.5), //color of shadow
          //     spreadRadius: 5, //spread radius
          //     blurRadius: 7, // blur radius
          //     offset: Offset(0, 2), // changes position of shadow
          //     //first paramerter of offset is left-right
          //     //second parameter is top to down
          //   ),
          //you can set more BoxShadow() here
          // ],
          color: kclearContainer,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}

class PictureGridTile extends StatelessWidget {
  PictureGridTile(
      {this.cardimage,
      this.onpress,
      this.onPressedDelete,
      this.onPressedProfile,
      this.color,
      this.iconWidget});

  final ImageProvider<Object>? cardimage;
  final Function? onpress;
  final Function? onPressedDelete;
  final Function? onPressedProfile;
  final Color? color;
  final Widget? iconWidget;

  @override
  Widget build(BuildContext context) {
    final UserProfileInfo userProfileInfo =
        Provider.of<UserProfileInfo>(context);
    return Container(
      height: kpictureCardHeight,
      margin: EdgeInsets.all(2.5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: GestureDetector(
          onTap: onpress as void Function()?,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: kpictureCardHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    image: cardimage!,
                    fit: BoxFit.cover,
                  ),
                ),
                constraints: BoxConstraints.expand(),
              ),
              iconWidget!,
            ],
          ),
        ),
      ),
    );
  }
}

class AddPictureCard extends StatelessWidget {
  // final Function onpress;

  // AddPictureCard({this.onpress});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2.5),
      height: kpictureCardHeight,
      decoration: BoxDecoration(
        color: kclearContainer,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            constraints: BoxConstraints(minHeight: 40, minWidth: 40),
            onPressed: () {
              Navigator.pushNamed(context, AddProfilePhoto.id);
            },
            fillColor: kDiscovretGreen,
            shape: CircleBorder(),
            child: Icon(Icons.add_a_photo_sharp, size: 20, color: Colors.white),
          )
        ],
      ),
    );
  }
}

class CircularHeaderBox extends StatelessWidget {
  CircularHeaderBox({required this.textString, required this.color});
  final String textString;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 75),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          border: Border.all(color: kDiscovretYellow, width: 2.5),
        ),
        height: 35,
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                textString,
                style: GoogleFonts.shortStack(
                  textStyle: TextStyle(
                      fontSize: 18,
                      letterSpacing: 2.75,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileInfoInputCardTextField extends StatelessWidget {
  ProfileInfoInputCardTextField(
      {this.textStringParent,
      this.textStringchild,
      this.hintText,
      this.value,
      this.onEditingComplete,
      this.onFieldSubmitted,
      this.onSaved});

  final String? textStringParent;
  final Function? textStringchild;
  final String? hintText;
  final String? value;
  final Function? onEditingComplete;
  final Function? onSaved;
  final Function? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Container(
                height: 45,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                  child: Text(textStringParent!,
                      style: TextStyle(
                          fontSize: 17,
                          letterSpacing: 3,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
              ),
              Expanded(
                child: Container(
                  height: 50,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Center(
                      child: TextFormField(
                        onSaved: onSaved as void Function(String?)?,
                        onFieldSubmitted:
                            onFieldSubmitted as void Function(String)?,
                        onEditingComplete:
                            onEditingComplete as void Function()?,
                        initialValue: value,
                        textAlign: TextAlign.center,
                        onChanged: textStringchild as void Function(String)?,
                        style: TextStyle(color: Colors.blueGrey, fontSize: 17),
                        decoration: InputDecoration.collapsed(
                          hintText: '$hintText',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.white,
          thickness: 1,
        ),
      ],
    );
  }
}

class ProfileInfoInputCardDropDownStr extends StatelessWidget {
  ProfileInfoInputCardDropDownStr(
      {this.textStringParent, this.onChangedText, this.valueText, this.list});

  final String? textStringParent;
  final Function? onChangedText;
  final String? valueText;
  final List<String>? list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Container(
            height: 45,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
              child: Text(
                textStringParent!,
                style: TextStyle(
                    fontSize: 17,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 50,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton<String>(
                  value: valueText,
                  // hint: Text('$hintText'),
                  elevation: 16,
                  isExpanded: true,
                  style: const TextStyle(fontSize: 17, color: Colors.blueGrey),
                  // underline: Container(
                  //   height: 2,
                  //   color: Colors.deepPurpleAccent,
                  // ),
                  onChanged: onChangedText as void Function(String?)?,
                  items: list!.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileInfoInputCardDropDownInt extends StatelessWidget {
  ProfileInfoInputCardDropDownInt(
      {this.textStringParent, this.onChangedText, this.valueText, this.list});

  final String? textStringParent;
  final Function? onChangedText;
  final int? valueText;
  final List<int>? list;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Container(
                height: 45,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                  child: Text(
                    textStringParent!,
                    style: TextStyle(
                        fontSize: 17,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 50,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: DropdownButton<int>(
                      value: valueText,
                      // hint: Text('$hintText'),
                      elevation: 16,
                      isExpanded: true,
                      style:
                          const TextStyle(fontSize: 17, color: Colors.blueGrey),
                      // underline: Container(
                      //   height: 2,
                      //   color: Colors.deepPurpleAccent,
                      // ),
                      onChanged: onChangedText as void Function(int?)?,
                      items: list!.map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text('$value'),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.white,
          thickness: 1,
        ),
      ],
    );
  }
}

class ClearInfoInputCard extends StatelessWidget {
  ClearInfoInputCard({this.textStringParent, this.textStringchild});

  final String? textStringParent;
  final String? textStringchild;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 45,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
            child: Text(
              textStringParent!,
              style: TextStyle(
                  fontSize: 17,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 50,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  textStringchild!,
                  style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// class SearchInfoInputCard extends StatelessWidget {
//   SearchInfoInputCard(
//       {this.textStringParent,
//       this.list,
//       this.onChanged,
//       this.selectedValues,
//       this.hint,
//       this.searchHint});

//   final String textStringParent;
//   final String hint;
//   final String searchHint;
//   final Function onChanged;
//   final List<String> list;
//   final List<int> selectedValues;

//   @override
//   Widget build(BuildContext context) {
//     // final UserProfileInfo userProfileInfo =
//     //     Provider.of<UserProfileInfo>(context);
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 10),
//               child: Text(
//                 textStringParent,
//                 style: TextStyle(
//                     fontSize: 17,
//                     letterSpacing: 2,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black),
//               ),
//             ),
//           ],
//         ),
//         Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           margin: EdgeInsets.all(10),
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 5),
//               child: SearchableDropdown.multiple(
//                 items: list.map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(
//                       value,
//                       style: TextStyle(color: Colors.blueGrey),
//                     ),
//                   );
//                 }).toList(),
//                 selectedItems: selectedValues,
//                 hint: "$hint",
//                 searchHint: "$searchHint",
//                 onChanged: onChanged,
//                 isExpanded: true,
//                 clearIcon: Icon(Icons.clear_all),
//                 icon: Icon(Icons.arrow_drop_down_circle),
//                 // label: "Label for multi",
//                 underline: Container(
//                   // height: 1.0,
//                   decoration: BoxDecoration(
//                       border: Border(
//                           bottom:
//                               BorderSide(color: Colors.blueGrey, width: 0.2))),
//                 ),
//                 iconDisabledColor: Colors.black,
//                 iconEnabledColor: Colors.grey[700],
//                 // closeButton: (selectedItems, context) {
//                 //   Navigator.pop(context);
//                 //   return ("Not on list?");
//                 // },
//                 closeButton: null,
//                 doneButton: (selectedItemsDone, context) {
//                   return (ElevatedButton(
//                     style: ElevatedButton.styleFrom(primary: kDiscovretGreen),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: Text("Save"),
//                   ));
//                 },

//                 displayItem: (item, selected) {
//                   return (Row(
//                     children: [
//                       selected
//                           ? Icon(
//                               Icons.check,
//                               color: kDiscovretGreen,
//                             )
//                           : Icon(
//                               Icons.check_box_outline_blank,
//                               color: Colors.blueGrey,
//                             ),
//                       SizedBox(width: 7),
//                       Expanded(
//                         child: item,
//                       ),
//                     ],
//                   ));
//                 },
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class SearchInfoInputCardOneOutput extends StatelessWidget {
//   SearchInfoInputCardOneOutput(
//       {this.textStringParent,
//       this.list,
//       this.onChanged,
//       this.selectedValues,
//       this.hint,
//       this.searchHint});

//   final String textStringParent;
//   final String hint;
//   final String searchHint;
//   final Function onChanged;
//   final List<String> list;
//   final String selectedValues;

//   @override
//   Widget build(BuildContext context) {
//     // final UserProfileInfo userProfileInfo =
//     //     Provider.of<UserProfileInfo>(context);
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 10),
//               child: Text(
//                 textStringParent,
//                 style: TextStyle(
//                     fontSize: 17,
//                     letterSpacing: 2,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black),
//               ),
//             ),
//           ],
//         ),
//         Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           margin: EdgeInsets.all(10),
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 5),
//               child: SearchableDropdown.single(
//                 items: list.map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(
//                       value,
//                       style: TextStyle(color: Colors.blueGrey),
//                     ),
//                   );
//                 }).toList(),
//                 value: selectedValues,
//                 hint: "$hint",
//                 searchHint: "$searchHint",
//                 onChanged: onChanged,
//                 isExpanded: true,
//                 clearIcon: Icon(Icons.clear_all),
//                 icon: Icon(Icons.arrow_drop_down_circle),
//                 // label: "Label for multi",
//                 underline: Container(
//                   // height: 1.0,
//                   decoration: BoxDecoration(
//                       border: Border(
//                           bottom:
//                               BorderSide(color: Colors.blueGrey, width: 0.2))),
//                 ),
//                 iconDisabledColor: Colors.black,
//                 iconEnabledColor: Colors.grey[700],
//                 closeButton: null,
//                 doneButton: (selectedItemsDone, context) {
//                   return (ElevatedButton(
//                     style: ElevatedButton.styleFrom(primary: kDiscovretGreen),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: Text("Save"),
//                   ));
//                 },

//                 displayItem: (item, selected) {
//                   return (Row(
//                     children: [
//                       selected
//                           ? Icon(
//                               Icons.check,
//                               color: kDiscovretGreen,
//                             )
//                           : Icon(
//                               Icons.check_box_outline_blank,
//                               color: Colors.blueGrey,
//                             ),
//                       SizedBox(width: 7),
//                       Expanded(
//                         child: item,
//                       ),
//                     ],
//                   ));
//                 },
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class DiscSearchDropDownList extends StatelessWidget {
//   DiscSearchDropDownList(
//       {this.list,
//       this.onChangedList,
//       this.selectedValue,
//       this.hint,
//       this.searchHint,
//       this.ontapAdd,
//       this.icon,
//       this.iconText});

//   final String hint;
//   final String searchHint;
//   final Function onChangedList;
//   final List<String> list;
//   final String selectedValue;
//   final Function ontapAdd;
//   final Widget icon;
//   final String iconText;

//   @override
//   Widget build(BuildContext context) {
//     // final UserProfileInfo userProfileInfo =
//     //     Provider.of<UserProfileInfo>(context);
//     return Container(
//       child: Column(
//         children: [
//           SizedBox(height: 25),
//           Row(
//             children: [
//               Container(
//                 height: 90,
//                 width: 90,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30.0),
//                   color: kclearContainer,
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(5.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 7),
//                         child: icon,
//                       ),
//                       FittedBox(
//                           fit: BoxFit.scaleDown,
//                           child: Text(
//                             '$iconText',
//                             style: TextStyle(fontSize: 13),
//                           )),
//                     ],
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 8),
//                   child: Container(
//                     height: 90,
//                     width: 1000,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10.0),
//                       color: Colors.white,
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SearchableDropdown.single(
//                           items: list
//                               .map<DropdownMenuItem<String>>((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(
//                                 value,
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             );
//                           }).toList(),
//                           value: selectedValue,
//                           hint: "$hint",
//                           searchHint: "$searchHint",
//                           onChanged: onChangedList,
//                           isExpanded: true,
//                           clearIcon: Icon(Icons.clear),
//                           icon: Icon(Icons.arrow_drop_down_circle),
//                           // label: "Label for multi",
//                           underline: Container(
//                             // height: 1.0,
//                             decoration: BoxDecoration(
//                                 border: Border(
//                                     bottom: BorderSide(
//                                         color: Colors.blueGrey, width: 0.2))),
//                           ),
//                           iconDisabledColor: Colors.black,
//                           iconEnabledColor: Colors.grey[700],
//                           closeButton: null,
//                           doneButton: (selectedItemsDone, context) {
//                             return (ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                   primary: kDiscovretGreen),
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               child: Text("Save"),
//                             ));
//                           },

//                           displayItem: (item, selected) {
//                             return (Row(
//                               children: [
//                                 selected
//                                     ? Icon(
//                                         Icons.check,
//                                         color: kDiscovretGreen,
//                                       )
//                                     : Icon(
//                                         Icons.check_box_outline_blank,
//                                         color: Colors.blueGrey,
//                                       ),
//                                 SizedBox(width: 7),
//                                 Expanded(
//                                   child: item,
//                                 ),
//                               ],
//                             ));
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 15),
//           ElevatedButton(
//             onPressed: ontapAdd,
//             style: ElevatedButton.styleFrom(
//               animationDuration: Duration(seconds: 5),
//               elevation: 5,
//               shadowColor: Colors.black,
//               primary: kDiscovretGreen,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(30.0),
//                 // side: BorderSide(
//                 //   width: 2.5,
//                 //   color: Colors.white,
//                 // ),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.add, color: Colors.white),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 8),
//                   child: Text(
//                     'Add',
//                     style: TextStyle(
//                         color: Colors.white, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 5),
//         ],
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8.0),
//         color: Colors.transparent,
//       ),
//     );
//   }
// }

class DiscSearchDropDownList extends StatelessWidget {
  DiscSearchDropDownList(
      {this.list,
      this.onChangedList,
      this.selectedValue,
      this.hint,
      this.searchHint,
      this.ontapAdd,
      this.icon,
      this.iconText});

  final String? hint;
  final String? searchHint;
  final Function? onChangedList;
  final List<String>? list;
  final String? selectedValue;
  final Function? ontapAdd;
  final Widget? icon;
  final String? iconText;

  @override
  Widget build(BuildContext context) {
    // final UserProfileInfo userProfileInfo =
    //     Provider.of<UserProfileInfo>(context);
    return Container(
      child: Column(
        children: [
          SizedBox(height: 25),
          Row(
            children: [
              Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: kclearContainer,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 7),
                        child: icon,
                      ),
                      FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '$iconText',
                            style: TextStyle(fontSize: 13),
                          )),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Container(
                    height: 85,
                    width: 1000,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownSearch(
                            mode: Mode.BOTTOM_SHEET,
                            onChanged: onChangedList as void Function(String?)?,
                            dropdownSearchDecoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  left: 15, right: 2, top: 5, bottom: 2),
                            ),
                            showSearchBox: true,
                            showSelectedItems: true,
                            showClearButton: true,
                            searchFieldProps: TextFieldProps(
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.search_outlined,
                                    color: Colors.blueGrey,
                                  ),
                                  hintText: searchHint),
                            ),
                            items: list,
                            hint: hint,
                            // label: hint,
                            dropdownSearchTextAlignVertical:
                                TextAlignVertical.center,
                            // label: hint,
                            selectedItem: selectedValue)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          ElevatedButton(
            onPressed: ontapAdd as void Function()?,
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
                Icon(Icons.add, color: Colors.white),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    'Add',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.transparent,
      ),
    );
  }
}

class InfoOutputCard extends StatelessWidget {
  final String? textStringParent;
  final String? textStringchild;

  const InfoOutputCard({Key? key, this.textStringParent, this.textStringchild})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 20,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
            child: Text(
              textStringParent!,
              style: TextStyle(
                  fontSize: kTextSize16,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 25,
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  textStringchild!,
                  style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FriendTypeCard extends StatelessWidget {
  final String? assetImage;
  final Function? onpress;
  final String? headerText;
  final String? discCoinDesc;
  final int? friendCount;

  const FriendTypeCard(
      {Key? key,
      this.assetImage,
      this.onpress,
      this.discCoinDesc,
      this.friendCount,
      this.headerText});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onpress as void Function()?,
        child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: kclearContainer,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: AssetImage(assetImage!),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 30,
                          ),
                          Text(
                            '$friendCount',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              // fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                FittedBox(
                    fit: BoxFit.scaleDown,
                    child: SubjectIconText(
                        text: headerText, fontSize: kTextSize15)),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DiscCoin(
                      size: 37,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(discCoinDesc!),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SubjectIconText extends StatelessWidget {
  final String? text;
  final double? fontSize;

  const SubjectIconText({Key? key, this.text, this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
          fontSize: fontSize,
          letterSpacing: 2,
          fontWeight: FontWeight.bold,
          color: Colors.black),
    );
  }
}

class SubjectIconTextWhite extends StatelessWidget {
  final String? text;
  final double? fontSize;

  const SubjectIconTextWhite({Key? key, this.text, this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
          fontSize: fontSize,
          letterSpacing: 2,
          fontWeight: FontWeight.bold,
          color: Colors.white),
    );
  }
}

class AllFriendsListCard extends StatelessWidget {
  final String? firstName;
  final String? lastName;
  final String? profilePicture;
  final Function? onPressedProfile;
  final Function? onPressedDelete;

  AllFriendsListCard(
      {this.firstName,
      this.lastName,
      this.profilePicture,
      this.onPressedProfile,
      this.onPressedDelete});

  void setAlert(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Remove",
      desc:
          "Are you sure you want to remove this friend.\nIt will cost you 0.25 disc coin.",
      buttons: [
        DialogButton(
          color: kDiscovretGreen,
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: onPressedDelete as void Function()?,
          width: 120,
        ),
        DialogButton(
          color: kDiscovretGreen,
          child: Text(
            "No",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: kclearContainer,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: ListTile(
          title: SubjectIconText(
            text: '$firstName $lastName',
            fontSize: kTextSize16,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          tileColor: kclearContainer,
          leading: GestureDetector(
            onTap: onPressedProfile as void Function()?,
            child: Container(
              height: 60,
              width: 60,
              child: CircleAvatar(
                backgroundImage: NetworkImage(profilePicture!),
              ),
            ),
          ),
          isThreeLine: false,
          dense: true,
          trailing: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                icon: Icon(
                  Icons.person_remove_alt_1,
                  size: 30,
                  color: Colors.red,
                ),
                onPressed: () {
                  setAlert(context);
                }),
          ),
        ),
      ),
    );
  }
}

class CloseFriendListCard extends StatefulWidget {
  @override
  _CloseFriendListCardState createState() => _CloseFriendListCardState();
}

class _CloseFriendListCardState extends State<CloseFriendListCard> {
  void setAlert(context) {
    Alert(
      context: context,
      // type: AlertType.error,
      type: AlertType.none,
      image: Image.asset("assets\Disc_Map_NoBorders.png"),
      title: "Remove",
      desc:
          "Are you sure you want to remove this friend.\nIt will cost you 0.25 disc coin.",
      buttons: [
        DialogButton(
          color: kDiscovretGreen,
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: kclearContainer,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: ListTile(
          title: SubjectIconText(
            text: 'Aaron Mackie',
            fontSize: kTextSize16,
          ),
          subtitle: Text(
            'Days Till Inactive: 320\nVisits This Year: 7',
            maxLines: 3,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          tileColor: kclearContainer,
          leading: Container(
            height: 60,
            width: 60,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.pushNamed(context, ViewProfileFriend.id);
                });
              },
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/Profile.jpg'),
              ),
            ),
          ),
          isThreeLine: true,
          dense: true,
          trailing: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                icon: Icon(
                  Icons.person_remove_alt_1,
                  size: 30,
                  color: Colors.red,
                ),
                onPressed: () {
                  setState(() {
                    setAlert(context);
                  });
                }),
          ),
        ),
      ),
    );
  }
}

class ActiveFriendsListCard extends StatelessWidget {
  final String? firstName;
  final String? lastName;
  final String? profilePicture;
  final Function? onPressedProfile;
  final Function? onPressedDelete;
  final int? daysTillExp;
  final int? visitsThisYear;

  ActiveFriendsListCard(
      {this.firstName,
      this.lastName,
      this.profilePicture,
      this.onPressedProfile,
      this.onPressedDelete,
      this.daysTillExp,
      this.visitsThisYear});

  void setAlert(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Remove",
      desc:
          "Are you sure you want to remove this friend.\nIt will cost you 0.25 disc coin.",
      buttons: [
        DialogButton(
          color: kDiscovretGreen,
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: onPressedDelete as void Function()?,
          width: 120,
        ),
        DialogButton(
          color: kDiscovretGreen,
          child: Text(
            "No",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: kclearContainer,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: ListTile(
          title: SubjectIconText(
            text: '$firstName $lastName',
            fontSize: kTextSize16,
          ),
          subtitle: Text(
            'Days Till Inactive: $daysTillExp\nVisits This Year: $visitsThisYear',
            style: TextStyle(
                // color: kDiscovretGreen,
                ),
            maxLines: 3,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          tileColor: kclearContainer,
          leading: GestureDetector(
            onTap: onPressedProfile as void Function()?,
            child: Container(
              height: 60,
              width: 60,
              child: CircleAvatar(
                backgroundImage: AssetImage(profilePicture!),
              ),
            ),
          ),
          isThreeLine: true,
          dense: true,
          trailing: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                icon: Icon(
                  Icons.person_remove_alt_1,
                  size: 30,
                  color: Colors.red,
                ),
                onPressed: () {
                  setAlert(context);
                }),
          ),
        ),
      ),
    );
  }
}

class InactiveFriendsListCard extends StatefulWidget {
  @override
  _InactiveFriendsListCardState createState() =>
      _InactiveFriendsListCardState();
}

class _InactiveFriendsListCardState extends State<InactiveFriendsListCard> {
  void setAlert(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Remove",
      desc: "Are you sure you want to remove this friend.",
      buttons: [
        DialogButton(
          color: kDiscovretGreen,
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: kclearContainer,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: ListTile(
          title: SubjectIconText(
            text: 'Aaron Mackie',
            fontSize: kTextSize16,
          ),
          subtitle: Text(
            'Days Inactive: 57',
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          // tileColor: Colors.white,
          leading: Container(
            height: 60,
            width: 60,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/Profile.jpg'),
            ),
          ),
          dense: true,
          trailing: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                icon: Icon(
                  Icons.person_remove_alt_1,
                  size: 30,
                  color: Colors.red,
                ),
                onPressed: () {
                  setAlert(context);
                }),
          ),
        ),
      ),
    );
  }
}

class FriendConfirmationListCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          child: ListTile(
            title: SubjectIconText(
              text: 'Aaron Mackie',
              fontSize: kTextSize16,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            tileColor: kclearContainer,
            leading: Container(
              height: 60,
              width: 60,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/Profile.jpg'),
              ),
            ),
            dense: true,
            trailing: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  icon: Icon(
                    Icons.person_add_alt_1,
                    size: 30,
                    color: kDiscovretGreen,
                  ),
                  onPressed: null),
            ),
          ),
        ),
      ),
    );
  }
}

class ConfirmationsAvatar extends StatelessWidget {
  final Function? onTap;
  final String? profileImage;

  const ConfirmationsAvatar({this.onTap, this.profileImage});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 50,
        child: GestureDetector(
          onTap: onTap as void Function()?,
          child: CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('$profileImage'),
          ),
        ),
      ),
    );
  }
}

class MutualFriendAvatar extends StatelessWidget {
  final String profileImage;
  final String firstName;
  final String lastName;
  final dynamic onPressed;

  const MutualFriendAvatar(
      {Key? key,
      required this.profileImage,
      required this.firstName,
      required this.lastName,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        child: Column(
          children: [
            InkWell(
              onTap: onPressed,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 50,
                child: GestureDetector(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(profileImage),
                  ),
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  firstName,
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  lastName,
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SettingsHeader extends StatelessWidget {
  final String title;
  final IconData icontype;

  const SettingsHeader({required this.title, required this.icontype});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Container(
                // decoration: BoxDecoration(
                //   color: kclearContainer,
                //   borderRadius: BorderRadius.all(Radius.circular(30)),
                // ),
                child: Icon(icontype, color: kDiscovretYellow, size: 27),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SubjectIconText(
                  text: title,
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
        Divider(
          indent: 20,
          endIndent: 20,
          color: Colors.white,
          thickness: 2,
        ),
      ],
    );
  }
}

class SettingsHeaderChildArrow extends StatelessWidget {
  final String title;
  final Function? ontap;

  const SettingsHeaderChildArrow(
      {Key? key, required this.title, required this.ontap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap as void Function()?,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 17),
            ),
            Icon(Icons.arrow_right_rounded, color: Colors.white, size: 24),
          ],
        ),
      ),
    );
  }
}

class SettingsHeaderChildSwitch extends StatelessWidget {
  final String? title;
  final Function? onChanged;
  final bool? switchValue;

  const SettingsHeaderChildSwitch(
      {Key? key, this.title, this.onChanged, this.switchValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title!,
            style: TextStyle(fontSize: 17),
          ),
          Switch(
              activeColor: kDiscovretGreen,
              value: switchValue!,
              onChanged: onChanged as void Function(bool)?)
        ],
      ),
    );
  }
}

class SearchInfoSettingsSwitch extends StatelessWidget {
  SearchInfoSettingsSwitch(
      {this.selectedValueDiscSearch,
      this.onChangedDiscSearch,
      this.selectedValueFriend,
      this.onChangedFriend});

  final bool? selectedValueDiscSearch;
  final Function? onChangedDiscSearch;
  final bool? selectedValueFriend;
  final Function? onChangedFriend;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  children: [
                    Icon(Icons.person_search_outlined, color: kDiscovretYellow),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Hide from discovret search',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                  splashRadius: 25.0,
                  activeColor: kDiscovretGreen,
                  value: selectedValueDiscSearch!,
                  onChanged: onChangedDiscSearch as void Function(bool)?)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  children: [
                    Icon(
                      Icons.people_outline,
                      color: kDiscovretYellow,
                      // size: 19,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        'Hide from friends & matches',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                  splashRadius: 25.0,
                  activeColor: kDiscovretGreen,
                  value: selectedValueFriend!,
                  onChanged: onChangedFriend as void Function(bool)?),
            ],
          ),
        ),
        Divider(color: Colors.white, thickness: 1),
      ],
    );
  }
}

class ComplimentCard1 extends StatelessWidget {
  final String? compliment;
  final Function? ontap;

  const ComplimentCard1({Key? key, this.compliment, this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: ontap as void Function()?,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage('assets/profile13.jpg'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Aaron Mackie',
                            // textAlign: TextAlign.left,
                            style: TextStyle(
                                // fontSize: kProfileIconTextSize,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: kTextSize15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.delete_outlined, color: Colors.red),
                    onPressed: null)
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(compliment!),
            ),
          ],
        ),
      ),
    );
  }
}

class ComplimentCard extends StatefulWidget {
  final String compliment;

  ComplimentCard({required this.compliment});
  @override
  _ComplimentCardState createState() => _ComplimentCardState(compliment);
}

class _ComplimentCardState extends State<ComplimentCard> {
  final String compliment;

  _ComplimentCardState(this.compliment);

  void setAlert(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Delete",
      desc: "Are you sure you want to delete this compliment.",
      buttons: [
        DialogButton(
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        ),
        DialogButton(
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
    return Card(
      margin: EdgeInsets.all(10),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage('assets/profile13.jpg'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Aaron Mackie',
                            // textAlign: TextAlign.left,
                            style: TextStyle(
                                // fontSize: kProfileIconTextSize,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: kTextSize15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.delete_outlined, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        setAlert(context);
                      });
                    })
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(compliment),
            ),
          ],
        ),
      ),
    );
  }
}

class FriendTypeInfoCard extends StatefulWidget {
  final String stringText;

  FriendTypeInfoCard(this.stringText);
  @override
  _FriendTypeInfoCardState createState() =>
      _FriendTypeInfoCardState(stringText);
}

class _FriendTypeInfoCardState extends State<FriendTypeInfoCard> {
  final String stringText;

  _FriendTypeInfoCardState(this.stringText);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () {
          // setAlert(context);
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                // padding: EdgeInsets.only(
                //     bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DiscCoin(
                            size: 37,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: SubjectIconText(
                              text: 'Crypto Rewards Info',
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 30,
                        thickness: 5,
                        color: kDiscovretYellow,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: Text(
                          'Discovered Friend',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: kDiscovretBlue),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Newly confirmed friend = 0.25 Disc coin',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                      ),
                      Divider(
                        height: 10,
                        thickness: 0.5,
                        color: Colors.blueGrey,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Close Friend',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: kDiscovretBlue),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          '5 visits per year = 1 Disc coin',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                      ),
                      Divider(
                        height: 10,
                        thickness: 0.5,
                        color: Colors.blueGrey,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Active Friend',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: kDiscovretBlue),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          '1 visit per year = 0.25 Disc',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                      ),
                      Divider(
                        height: 10,
                        thickness: 0.5,
                        color: Colors.blueGrey,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Inactive Friend',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: kDiscovretBlue),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          '1 year with no visit = - 0.25 Disc coin',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                      ),
                      //
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: kclearContainer,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.info_outline,
                  size: 30,
                  color: kDiscovretGreen,
                ),
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          stringText,
                          // textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: kTextSize15,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                      ),
                    ),
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

class DiscCoin extends StatelessWidget {
  final double? size;

  const DiscCoin({Key? key, this.size}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Image.asset("assets/Disc_Map2.png"),
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
    );
  }
}

// class SearchTabDropDown extends StatefulWidget {
//   @override
//   _SearchTabDropDownState createState() => _SearchTabDropDownState();
// }

// class _SearchTabDropDownState extends State<SearchTabDropDown> {
//   @override
//   Widget build(BuildContext context) {
//     var selectedValue;
//     var items;
//     return Container(
//       child: Row(
//         children: [
//           Container(
//             height: 90,
//             width: 90,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(30.0),
//               color: kclearContainer,
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(5.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 7),
//                     child: Icon(Icons.language_outlined, size: 25),
//                   ),
//                   Text('Languages')
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 8),
//               child: Container(
//                 height: 90,
//                 width: 1000,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10.0),
//                   color: Colors.white,
//                 ),
//                 child: SearchableDropdown.single(
//                   items: items,
//                   value: selectedValue,
//                   hint: "Language",
//                   searchHint: "Language",
//                   onChanged: (value) {
//                     setState(() {
//                       selectedValue = value;
//                     });
//                   },
//                   isExpanded: true,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8.0),
//         color: Colors.transparent,
//       ),
//     );
//   }
// }

class MySearchListTile extends StatelessWidget {
  final String? textHeader;
  final String? textSubHeader;
  final Function? onDelete;

  const MySearchListTile({this.textHeader, this.textSubHeader, this.onDelete});

  Widget? get leadingIcon {
    if (textHeader == 'Language') {
      return Icon(Icons.language_outlined, size: 35, color: Colors.black);
    } else if (textHeader == "Culture") {
      return Icon(Icons.flag, size: 35, color: Colors.black);
    } else if (textHeader == "Religion") {
      return FaIcon(FontAwesomeIcons.prayingHands,
          size: 25, color: Colors.black);
    } else if (textHeader == "Interest") {
      return Icon(Icons.directions_run_rounded, size: 35, color: Colors.black);
    } else if (textHeader == "Mentor") {
      return Icon(FontAwesome5.chalkboard_teacher,
          size: 25, color: Colors.black);
    }
  }

  void setAlert(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Delete",
      desc: "Are you sure you want to delete this search item",
      buttons: [
        DialogButton(
          color: kDiscovretGreen,
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: onDelete as void Function()?,
          width: 120,
        ),
        DialogButton(
          color: kDiscovretGreen,
          child: Text(
            "No",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: kclearContainer,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: ListTile(
          title: SubjectIconText(
            text: textHeader,
            fontSize: kTextSize16,
          ),
          subtitle: Text(textSubHeader!),
          contentPadding: EdgeInsets.only(left: 15, right: 10),
          tileColor: kclearContainer,
          leading: leadingIcon,
          dense: true,
          trailing: Padding(
            padding: const EdgeInsets.only(right: 0),
            child: IconButton(
                icon: Icon(
                  Icons.remove_circle_outline_rounded,
                  size: 30,
                  color: Colors.red,
                ),
                onPressed: () {
                  setAlert(context);
                }),
          ),
        ),
      ),
    );
  }
}

class MySearchList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProfileInfo userProfileInfo =
        Provider.of<UserProfileInfo>(context);
    return ListView.builder(itemBuilder: (context, index) {
      final searchItem = userProfileInfo.listDiscSearch[index];
      return MySearchListTile(
        textHeader: searchItem.itemHeader,
        textSubHeader: searchItem.item,
        onDelete: () {
          // userProfileInfo.deleteSearchItem(searchItem);
        },
      );
    });
  }
}

class FriendConfirmationCard extends StatelessWidget {
  final String fullName;
  final String picture;
  final Widget child;
  final Function onTapConfirm;

  var selectedValue;

  FriendConfirmationCard({
    required this.fullName,
    required this.picture,
    required this.child,
    required this.onTapConfirm,
  });

  // Color yesButton = Colors.transparent;
  // Color noButton = Colors.transparent;
  // List<String> list = ['Yes', 'No'];
  // List<bool> selectionList = List.generate(2, (_) => false);

  bool isValidFormReview = false;
  var _numberFormReview = GlobalKey<FormState>();

  void checkProfileFormReview() {
    if (_numberFormReview.currentState!.validate()) {
      isValidFormReview = true;
    } else {
      isValidFormReview = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Container(
              alignment: Alignment.centerLeft,
              child: child,
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: Container(
              height: 1000,
              width: deviceWidth,
              margin: EdgeInsets.only(
                right: 5,
                left: 5,
              ),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                border: Border.all(color: kDiscovretYellow, width: 2.5),
              ),
              child: ListView(
                children: [
                  //   Container(
                  //   child: child,
                  // ),
                  SizedBox(height: 10),
                  Container(
                    width: deviceWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: CircleAvatar(
                            radius: deviceWidth * 0.06,
                            backgroundImage: NetworkImage(picture),
                          ),
                        ),
                        Container(
                          width: deviceHeight * 0.30,
                          height: 40,
                          margin: EdgeInsets.all(5),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              fullName,
                              style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'Syne Mono',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      width: deviceWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'Safety Rating:',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: DropDownFormCardStr(
                              value: selectedValue,
                              hintText:
                                  'Was $fullName\nsafe to meet and talk to?',
                              onChanged: (value) {
                                selectedValue = value;
                              },
                              list: ['Yes', 'No'],
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'Profile Accuracy Rating:',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: DropDownFormCardStr(
                              value: selectedValue,
                              hintText:
                                  'Did $fullName\nmatch his profile description?',
                              onChanged: (value) {
                                selectedValue = value;
                              },
                              list: ['Yes', 'No'],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          child: Image(
                            fit: BoxFit.contain,
                            image: AssetImage("assets/Disc_Map2.png"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Uplift',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: 25,
                                color: Color(0xFFECC84B),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: EdgeInsets.all(11),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: TextField(
                          maxLines: 100,
                          minLines: 1,
                          keyboardType: TextInputType.name,
                          textAlign: TextAlign.center,
                          onChanged: (value) {},
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 17,
                              fontWeight: FontWeight.normal),
                          decoration: InputDecoration.collapsed(
                              hintText:
                                  'Optional: Give an Uplifting Compliment',
                              hintStyle: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal)
                              // border: InputBorder.none,
                              ),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(height: 5),
                  // Center(
                  //   child: Text(
                  //     onErrorText,
                  //     style: TextStyle(
                  //         fontSize: 13,
                  //         color: Colors.red,
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: onTapConfirm as void Function(),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                        height: 35,
                        width: double.infinity,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: kDiscovretGreen,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: Center(
                          child: Text(
                            'Confirm',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DiscCultureLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.center,
      children: [
        CircularText(
          children: [
            // TextItem(
            //   text: Text(
            //     'Discovret'.toUpperCase(),
            //     style: TextStyle(
            //         letterSpacing: 5,
            //         fontSize: 40,
            //         color: Colors.white,
            //         fontWeight: FontWeight.bold),
            //   ),
            //   space: 12,
            //   startAngle: -90,
            //   startAngleAlignment: StartAngleAlignment.center,
            //   direction: CircularTextDirection.clockwise,
            // ),
            TextItem(
              text: Text(
                "Discover > Understand > Uplift".toUpperCase(),
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: size.height * 0.024,
                    color: Color(0xFFECC84B),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              space: size.height * .00999,
              startAngle: 89,
              startAngleAlignment: StartAngleAlignment.center,
              direction: CircularTextDirection.anticlockwise,
            ),
          ],
          radius: size.height * .13,
          position: CircularTextPosition.outside,
          backgroundPaint: Paint()..color = Colors.transparent,
        ),
        Positioned(
          top: 1,
          child: Row(
            children: [
              Icon(MyFlutterApp.discovretmapicon,
                  color: Colors.white, size: size.height * .06),
              Text(
                'iscovret',
                style: GoogleFonts.markoOne(
                  textStyle: TextStyle(
                      fontSize: size.height * .05,
                      letterSpacing: 5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 25,
          child: Container(
            height: size.height * .13,
            width: size.height * .13,
            child: Hero(
              tag: 'Discover1',
              child: Image(
                fit: BoxFit.contain,
                image: AssetImage("assets/Disc_Map_NoBorders.png"),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ViewUserPhoto extends StatelessWidget {
  final String? imageString;
  final Function? onPressedDelete;
  final Function? onPressedProfile;

  const ViewUserPhoto(
      {this.imageString, this.onPressedDelete, this.onPressedProfile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            color: Colors.blueGrey,
            child: Center(
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Image(
                      image: NetworkImage('$imageString'),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 11, right: 0, top: 11),
                          child: IconButton(
                            icon: Icon(Icons.account_box),
                            color: Colors.white,
                            onPressed: onPressedProfile as void Function()?,
                            iconSize: 30,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 11, right: 10, left: 4, top: 11),
                          child: IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.white,
                            onPressed: onPressedDelete as void Function()?,
                            iconSize: 30,
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
        // Container(
        //   color: kDiscovretGreen,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: IconButton(
        //           icon: Icon(Icons.account_box),
        //           color: Colors.white,
        //           onPressed: () {},
        //           iconSize: 30,
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(11.0),
        //         child: IconButton(
        //           icon: Icon(Icons.delete),
        //           color: Colors.white,
        //           onPressed: () {},
        //           iconSize: 30,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

class ViewFriendPhoto extends StatelessWidget {
  final String? imageString;

  const ViewFriendPhoto({this.imageString});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            color: Colors.blueGrey,
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Image(
                  image: NetworkImage('$imageString'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TextFormCard extends StatelessWidget {
  const TextFormCard({this.hintText, this.onChanged, this.value});

  final Function? onChanged;
  final String? hintText;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: TextFormField(
          initialValue: value,
          keyboardType: TextInputType.name,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(
                '[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ]')),
          ],
          textAlign: TextAlign.start,
          validator: (inputValue) {
            if (inputValue!.isEmpty) {
              return "Field is Required";
            }
            return null;
          },
          onChanged: onChanged as void Function(String)?,
          style: TextStyle(color: Colors.blueGrey, fontSize: 16),
          decoration: InputDecoration(
            labelText: '',
            labelStyle: TextStyle(fontSize: 1),
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            errorStyle: TextStyle(color: Colors.red),
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}

class DropDownFormCardInt extends StatelessWidget {
  const DropDownFormCardInt(
      {this.value, this.hintText, this.onChanged, this.list});

  final int? value;
  final String? hintText;
  final Function? onChanged;
  final List<int>? list;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: DropdownButtonFormField<int>(
          validator: (inputValue) {
            if (inputValue == null) {
              return "Field is Required";
            }
            return null;
          },
          value: value,
          elevation: 16,
          isExpanded: true,
          style: TextStyle(color: Colors.blueGrey, fontSize: 17),
          decoration: InputDecoration(
            labelText: '',
            labelStyle: TextStyle(fontSize: 1),
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            errorStyle: TextStyle(color: Colors.red),
          ),
          onChanged: onChanged as void Function(int?)?,
          items: list!.map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text('$value'),
            );
          }).toList(),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}

class DropDownFormCardStr extends StatelessWidget {
  const DropDownFormCardStr(
      {this.value, this.hintText, this.onChanged, this.list});

  final String? value;
  final String? hintText;
  final Function? onChanged;
  final List<String>? list;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: DropdownButtonFormField<String>(
          validator: (inputValue) {
            if (inputValue == null) {
              return "Field is Required";
            }
            return null;
          },
          value: value,
          elevation: 16,
          isExpanded: true,
          style: TextStyle(color: Colors.blueGrey, fontSize: 17),
          decoration: InputDecoration(
            // labelText: '',
            // labelStyle: TextStyle(fontSize: 1),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 13),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            errorStyle: TextStyle(color: Colors.red),
          ),
          onChanged: onChanged as void Function(String?)?,
          items: list!.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}

class HeaderSpacer extends StatelessWidget {
  const HeaderSpacer({Key? key, this.header}) : super(key: key);

  final String? header;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Text(
        header!,
        style: TextStyle(
          letterSpacing: 5,
          fontSize: 15,
          color: Colors.white,
        ),
      ),
    );
  }
}

// class SearchInfoInputCard extends StatelessWidget {
//   final String textStringParent;
//   final String hint;
//   final String searchHint;
//   final Function onChanged;
//   final List<String> list;
//   final List<int> selectedValues;
//   final Widget listViewWidget;
//   final bool buttonVisible;
//   final Function onPressedAddButton;
//   final Function onPressedClearAll;
//   final bool itemList;

//   const SearchInfoInputCard(
//       {Key key,
//       this.textStringParent,
//       this.hint,
//       this.searchHint,
//       this.onChanged,
//       this.list,
//       this.selectedValues,
//       this.listViewWidget,
//       this.buttonVisible,
//       this.onPressedAddButton,
//       this.onPressedClearAll,
//       this.itemList})
//       : super(key: key);

//   Widget addListItemWidget(
//       {bool addItem, Widget nullWidget, Widget unNullWidget}) {
//     if (addItem == false) {
//       return nullWidget;
//     } else
//       return unNullWidget;
//   }

//   Widget addButtonVisibleWidget(
//       {bool buttonVisible, Widget nullWidget, Widget unNullWidget}) {
//     if (buttonVisible == false) {
//       return nullWidget;
//     } else
//       return unNullWidget;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//       margin: const EdgeInsets.all(10),
//       child: Column(
//         children: [
//           SizedBox(height: 15),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 10),
//                 child: Text(
//                   textStringParent,
//                   style: TextStyle(
//                       fontSize: 17,
//                       letterSpacing: 2,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 10),
//           listViewWidget,
//           SizedBox(height: 10),
//           Divider(
//             thickness: 1,
//             color: Colors.blueGrey,
//             indent: 10,
//             endIndent: 10,
//           ),
//           addButtonVisibleWidget(
//             buttonVisible: buttonVisible,
//             nullWidget: SizedBox(height: 0),
//             unNullWidget: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   TextButton(
//                       onPressed: onPressedClearAll,
//                       child: Text('Clear All',
//                           style: TextStyle(color: Colors.red))),
//                   ElevatedButton.icon(
//                       style: ElevatedButton.styleFrom(
//                         primary: kDiscovretGreen,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30.0),
//                         ),
//                       ),
//                       onPressed: onPressedAddButton,
//                       icon: Icon(Icons.add),
//                       label: Text(
//                         'add',
//                       )),
//                 ],
//               ),
//             ),
//           ),
//           addListItemWidget(
//             addItem: itemList,
//             nullWidget: SizedBox(height: 0),
//             unNullWidget: Card(
//               color: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               margin: EdgeInsets.all(10),
//               child: Center(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 5),
//                   child: SearchableDropdown.multiple(
//                     items: list.map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(
//                           value,
//                           style: TextStyle(color: Colors.blueGrey),
//                         ),
//                       );
//                     }).toList(),
//                     selectedItems: selectedValues,
//                     hint: "$hint",
//                     searchHint: "$searchHint",
//                     onChanged: onChanged,
//                     isExpanded: true,
//                     clearIcon: Icon(Icons.cancel_outlined),
//                     icon: Icon(Icons.arrow_drop_down_circle),
//                     // label: "Label for multi",
//                     underline: Container(
//                       // height: 1.0,
//                       decoration: BoxDecoration(
//                           border: Border(
//                               bottom: BorderSide(
//                                   color: Colors.blueGrey, width: 0.2))),
//                     ),
//                     iconDisabledColor: Colors.black,
//                     iconEnabledColor: Colors.grey[700],
//                     // closeButton: (selectedItems, context) {
//                     //   Navigator.pop(context);
//                     //   return ("Not on list?");
//                     // },
//                     closeButton: null,
//                     doneButton: (selectedItemsDone, context) {
//                       return (ElevatedButton(
//                         style:
//                             ElevatedButton.styleFrom(primary: kDiscovretGreen),
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: Text("Save"),
//                       ));
//                     },

//                     displayItem: (item, selected) {
//                       return (Row(
//                         children: [
//                           selected
//                               ? Icon(
//                                   Icons.check,
//                                   color: kDiscovretGreen,
//                                 )
//                               : Icon(
//                                   Icons.check_box_outline_blank,
//                                   color: Colors.blueGrey,
//                                 ),
//                           SizedBox(width: 7),
//                           Expanded(
//                             child: item,
//                           ),
//                         ],
//                       ));
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class SearchInfoInputCard extends StatelessWidget {
  final String? textStringParent;
  final String? hint;
  final String? searchHint;
  final Function? onChanged;
  final List<String>? list;
  final List<String>? selectedValues;
  final Widget? listViewWidget;
  final bool? buttonVisible;
  final Function? onPressedAddButton;
  final Function? onPressedClearAll;
  final bool? itemList;

  const SearchInfoInputCard(
      {Key? key,
      this.textStringParent,
      this.hint,
      this.searchHint,
      this.onChanged,
      this.list,
      this.selectedValues,
      this.listViewWidget,
      this.buttonVisible,
      this.onPressedAddButton,
      this.onPressedClearAll,
      this.itemList})
      : super(key: key);

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
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  textStringParent!,
                  style: TextStyle(
                      fontSize: 17,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          listViewWidget!,
          SizedBox(height: 10),
          Divider(
            thickness: 1,
            color: Colors.black54,
            indent: 10,
            endIndent: 10,
          ),
          addButtonVisibleWidget(
            buttonVisible: buttonVisible,
            nullWidget: SizedBox(height: 0),
            unNullWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: onPressedClearAll as void Function()?,
                      child: Text('Clear All',
                          style: TextStyle(color: Colors.red))),
                  SizedBox(
                    height: 30,
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.black,
                          animationDuration: Duration(seconds: 5),
                          elevation: 5,
                          primary: kDiscovretGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: onPressedAddButton as void Function()?,
                        icon: Icon(Icons.add),
                        label: Text(
                          'Add',
                        )),
                  ),
                ],
              ),
            ),
          )!,
          addListItemWidget(
            addItem: itemList,
            nullWidget: SizedBox(height: 0),
            unNullWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: DropdownSearch<String>.multiSelection(
                  mode: Mode.BOTTOM_SHEET,
                  onChange: onChanged as void Function(List<String>)?,
                  dropdownSearchDecoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 15,
                          right: 2,
                          top: (selectedValues!.isEmpty) ? 5 : 35,
                          bottom: 2),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                  showSearchBox: true,
                  showSelectedItems: true,
                  showClearButton: true,
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search_outlined,
                          color: Colors.blueGrey,
                        ),
                        hintText: searchHint),
                  ),
                  items: list,
                  hint: hint,
                  label: hint,
                  dropdownSearchTextAlignVertical: TextAlignVertical.center,
                  // label: hint,
                  selectedItems: selectedValues!),
            ),
          )!,
        ],
      ),
    );
  }
}

class SearchInfoInputCardOneOutput extends StatelessWidget {
  final String? textStringParent;
  final String? hint;
  final String? searchHint;
  final Function? onChanged;
  final List<String>? list;
  final String? selectedValues;
  final Widget? listViewWidget;
  final bool? buttonVisible;
  final Function? onPressedAddButton;
  final Function? onPressedClearAll;
  final bool? itemList;

  const SearchInfoInputCardOneOutput(
      {Key? key,
      this.textStringParent,
      this.hint,
      this.searchHint,
      this.onChanged,
      this.list,
      this.selectedValues,
      this.listViewWidget,
      this.buttonVisible,
      this.onPressedAddButton,
      this.onPressedClearAll,
      this.itemList})
      : super(key: key);

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
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  textStringParent!,
                  style: TextStyle(
                      fontSize: 17,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          listViewWidget!,
          SizedBox(height: 10),
          Divider(
            thickness: 1,
            color: Colors.black54,
            indent: 10,
            endIndent: 10,
          ),
          addButtonVisibleWidget(
            buttonVisible: buttonVisible,
            nullWidget: SizedBox(height: 0),
            unNullWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: onPressedClearAll as void Function()?,
                      child: Text('Clear All',
                          style: TextStyle(color: Colors.red))),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: kDiscovretGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: onPressedAddButton as void Function()?,
                      icon: Icon(Icons.add),
                      label: Text(
                        'Add',
                      )),
                ],
              ),
            ),
          )!,
          addListItemWidget(
            addItem: itemList,
            nullWidget: SizedBox(height: 0),
            unNullWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: DropdownSearch<String>(
                  mode: Mode.BOTTOM_SHEET,
                  onChanged: onChanged as void Function(String?)?,
                  dropdownSearchDecoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 15,
                          right: 2,
                          top: (selectedValues!.isEmpty) ? 5 : 35,
                          bottom: 2),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                  showSearchBox: true,
                  showSelectedItems: true,
                  showClearButton: true,
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search_outlined,
                          color: Colors.blueGrey,
                        ),
                        hintText: searchHint),
                  ),
                  items: list,
                  hint: hint,
                  label: hint,
                  dropdownSearchTextAlignVertical: TextAlignVertical.center,
                  // label: hint,
                  selectedItem: selectedValues),
            ),
          )!,
        ],
      ),
    );
  }
}

class SearchInfoTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile();
  }
}

class AppRoundImage extends StatelessWidget {
  final ImageProvider provider;
  final double height;
  final double width;

  const AppRoundImage(this.provider,
      {required this.height, required this.width});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(300),
      child: Image(
        image: provider,
        height: height,
        width: width,
      ),
    );
  }

  factory AppRoundImage.url(String url,
      {required double height, required double width}) {
    return AppRoundImage(NetworkImage(url), height: height, width: width);
  }

  factory AppRoundImage.memory(Uint8List data,
      {required double height, required double width}) {
    return AppRoundImage(
      MemoryImage(data),
      height: height,
      width: width,
    );
  }
}

class AppRoundImageFile extends StatelessWidget {
  final File file;
  final double height;
  final double width;

  const AppRoundImageFile(
      {required this.file, required this.height, required this.width});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: Image.file(file, height: height, width: width),
    );
  }
}

// class ModalQrScreen extends StatelessWidget {
//   // const ModalQrScreen({Key? key}) : super(key: key);

//   @override
//   Future<dynamic> Widget; build(BuildContext context) {
//     return showModalBottomSheet(
//                     context: context,
//                     isScrollControlled: true,
//                     builder: (context) => SingleChildScrollView(
//                       child: Container(
//                         padding: EdgeInsets.only(
//                             bottom: MediaQuery.of(context).viewInsets.bottom),
//                         child: Container(
//                           color: Color(0xff757575),
//                           child: Container(
//                             padding: EdgeInsets.all(20.0),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(20.0),
//                                 topRight: Radius.circular(20.0),
//                               ),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: <Widget>[
//                                 Text(
//                                     'Barcode Type: ${(result.format)}   Data: ${result.code}')
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//   }
// }

// class SearchInfoInputCardOneOutput extends StatelessWidget {
//   final String textStringParent;
//   final String hint;
//   final String searchHint;
//   final Function onChanged;
//   final List<String> list;
//   final String selectedValues;
//   final Widget listViewWidget;
//   final bool buttonVisible;
//   final Function onPressedAddButton;
//   final Function onPressedClearAll;
//   final bool itemList;

//   const SearchInfoInputCardOneOutput(
//       {Key key,
//       this.textStringParent,
//       this.hint,
//       this.searchHint,
//       this.onChanged,
//       this.list,
//       this.selectedValues,
//       this.listViewWidget,
//       this.buttonVisible,
//       this.onPressedAddButton,
//       this.onPressedClearAll,
//       this.itemList})
//       : super(key: key);

//   Widget addListItemWidget(
//       {bool addItem, Widget nullWidget, Widget unNullWidget}) {
//     if (addItem == false) {
//       return nullWidget;
//     } else
//       return unNullWidget;
//   }

//   Widget addButtonVisibleWidget(
//       {bool buttonVisible, Widget nullWidget, Widget unNullWidget}) {
//     if (buttonVisible == false) {
//       return nullWidget;
//     } else
//       return unNullWidget;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//       margin: const EdgeInsets.all(10),
//       child: Column(
//         children: [
//           SizedBox(height: 15),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 10),
//                 child: Text(
//                   textStringParent,
//                   style: TextStyle(
//                       fontSize: 17,
//                       letterSpacing: 2,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 10),
//           listViewWidget,
//           SizedBox(height: 10),
//           Divider(
//             thickness: 1,
//             color: Colors.blueGrey,
//             indent: 10,
//             endIndent: 10,
//           ),
//           addButtonVisibleWidget(
//             buttonVisible: buttonVisible,
//             nullWidget: SizedBox(height: 0),
//             unNullWidget: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   TextButton(
//                       onPressed: onPressedClearAll,
//                       child: Text('Clear All',
//                           style: TextStyle(color: Colors.red))),
//                   ElevatedButton.icon(
//                       style: ElevatedButton.styleFrom(
//                         primary: kDiscovretGreen,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30.0),
//                         ),
//                       ),
//                       onPressed: onPressedAddButton,
//                       icon: Icon(Icons.add),
//                       label: Text(
//                         'add',
//                       )),
//                 ],
//               ),
//             ),
//           ),
//           addListItemWidget(
//             addItem: itemList,
//             nullWidget: SizedBox(height: 0),
//             unNullWidget: Card(
//               color: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               margin: EdgeInsets.all(10),
//               child: Center(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 5),
//                   child: SearchableDropdown.single(
//                     items: list.map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(
//                           value,
//                           style: TextStyle(color: Colors.blueGrey),
//                         ),
//                       );
//                     }).toList(),
//                     value: selectedValues,
//                     hint: "$hint",
//                     searchHint: "$searchHint",
//                     onChanged: onChanged,
//                     isExpanded: true,
//                     clearIcon: Icon(Icons.clear_all),
//                     icon: Icon(Icons.arrow_drop_down_circle),
//                     // label: "Label for multi",
//                     underline: Container(
//                       // height: 1.0,
//                       decoration: BoxDecoration(
//                           border: Border(
//                               bottom: BorderSide(
//                                   color: Colors.blueGrey, width: 0.2))),
//                     ),
//                     iconDisabledColor: Colors.black,
//                     iconEnabledColor: Colors.grey[700],
//                     closeButton: null,
//                     doneButton: (selectedItemsDone, context) {
//                       return (ElevatedButton(
//                         style:
//                             ElevatedButton.styleFrom(primary: kDiscovretGreen),
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: Text("Save"),
//                       ));
//                     },

//                     displayItem: (item, selected) {
//                       return (Row(
//                         children: [
//                           selected
//                               ? Icon(
//                                   Icons.check,
//                                   color: kDiscovretGreen,
//                                 )
//                               : Icon(
//                                   Icons.check_box_outline_blank,
//                                   color: Colors.blueGrey,
//                                 ),
//                           SizedBox(width: 7),
//                           Expanded(
//                             child: item,
//                           ),
//                         ],
//                       ));
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }