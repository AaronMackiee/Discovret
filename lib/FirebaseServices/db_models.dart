import 'package:flutter/foundation.dart';

// class UserDiscSearchList {
//   final String? searchType;
//   final String? searchItem;
//   final String? uid;

//   UserDiscSearchList({this.searchType, this.searchItem, this.uid});

//   factory UserDiscSearchList.fromJson(Map<String, dynamic> parsedJson) {
//     return UserDiscSearchList(
//       uid: parsedJson['Uid'],
//       searchType: parsedJson['SearchType'] ?? "",
//       searchItem: parsedJson['SearchItem'] ?? "",
//     );
//   }
// }
class AddFriendObject {
  String? docId;
  List<dynamic>? allFriends;
  List<dynamic>? activeFriends;
  String? uid;
  String? firstName;
  String? lastName;
  String? sex;
  String? firstLanguage;
  String? interestedIn;
  String? relationshipStatus;
  String? gender;
  int? age;
  String? bio;
  String? profilePicture;
  List<dynamic>? userPictures;

  AddFriendObject(
      {
        this.docId,
        this.activeFriends,
      this.allFriends,
      this.uid,
      this.firstName,
      this.lastName,
      this.sex,
      this.firstLanguage,
      this.interestedIn,
      this.relationshipStatus,
      this.age,
      this.gender,
      this.bio,
      this.userPictures,
      this.profilePicture});

  AddFriendObject.fromMap({required Map data}) {
    docId = data['DocId'] ?? "";
    uid = data['Uid'] ?? "";
    firstName = data['FirstName'] ?? "";
    lastName = data['LastName'] ?? "";
    sex = data['Gender'] ?? "";
    gender = data['BiologicalSex'] ?? "";
    firstLanguage = data['FirstLanguage'] ?? "";
    interestedIn = data['InterestedIn'] ?? "";
    relationshipStatus = data['RelationshipStatus'] ?? "";
    age = data['Age'] ?? 0;
    bio = data['Bio'] ?? "";
    userPictures = (data['UserPictures'] as List? ?? []).toList();
    allFriends = (data['AllFriends'] as List? ?? []).toList();
    activeFriends = (data['ActiveFriends'] as List? ?? []).toList();
    profilePicture = data['ProfilePicture'] ?? "";
  }
}

class ConfirmationsObject {
  String? docId;
  List<dynamic>? uids;
  String? uid1;
  String? uid2;
  String? name1;
  String? name2;
  String? profilePicture1;
  String? profilePicture2;
  bool? confirmedRequest1;
  bool? confirmedRequest2;

  ConfirmationsObject(
      {
      required this.docId,  
      required this.uids,
      required this.uid1,
      required this.uid2,
      required this.name1,
      required this.name2,
      required this.profilePicture1,
      required this.profilePicture2,
      required this.confirmedRequest1,
      required this.confirmedRequest2});

  ConfirmationsObject.fromMap({required Map data}) {
    docId = data['DocId'] ?? "";
    uids = (data['Uids'] as List? ?? []).toList();
    uid1 = data['Uid1'] ?? "";
    uid2 = data['Uid2'] ?? "";
    profilePicture1 = data['ProfilePicture1'] ?? "";
    profilePicture2 = data['ProfilePicture2'] ?? "";
    name1 = data['Name1'] ?? "";
    name2 = data['Name2'] ?? "";
    confirmedRequest1 = data['ConfirmedRequest1'] ?? "";
    confirmedRequest2 = data['ConfirmedRequest2'] ?? "";
  }
}

class AllFriendsObject {
  List<dynamic>? allFriends;
  List<dynamic>? activeFriends;
  String? uid;
  String? firstName;
  String? lastName;
  String? sex;
  String? firstLanguage;
  String? interestedIn;
  String? relationshipStatus;
  String? gender;
  int? age;
  String? bio;
  String? profilePicture;
  List<dynamic>? userPictures;

  AllFriendsObject(
      {required this.activeFriends,
      required this.allFriends,
      required this.uid,
      required this.firstName,
      required this.lastName,
      required this.sex,
      required this.firstLanguage,
      required this.interestedIn,
      required this.relationshipStatus,
      required this.age,
      this.gender,
      this.bio,
      required this.userPictures,
      required this.profilePicture});

  AllFriendsObject.fromMap({required Map data}) {
    uid = data['Uid'] ?? "";
    firstName = data['FirstName'] ?? "";
    lastName = data['LastName'] ?? "";
    sex = data['Gender'] ?? "";
    gender = data['BiologicalSex'] ?? "";
    firstLanguage = data['FirstLanguage'] ?? "";
    interestedIn = data['InterestedIn'] ?? "";
    relationshipStatus = data['RelationshipStatus'] ?? "";
    age = data['Age'] ?? 0;
    bio = data['Bio'] ?? "";
    userPictures = (data['UserPictures'] as List? ?? []).toList();
    allFriends = (data['AllFriends'] as List? ?? []).toList();
    activeFriends = (data['ActiveFriends'] as List? ?? []).toList();
    profilePicture = data['ProfilePicture'] ?? "";
  }
}

// class DbUserFriendsList {
//   List<FriendObject>? friendObjects;

//   DbUserFriendsList({this.friendObjects});

//   factory DbUserFriendsList.fromMap({required data}) {
//     return DbUserFriendsList(
//       friendObjects: (data['FriendObjects'] as List? ?? [])
//           .map((values) => FriendObject.fromMap(values))
//           .toList(),
//     );
//   }
// }

class SearchObject {
  String? itemHeader;
  String? item;

  SearchObject({this.itemHeader, this.item});
  SearchObject.fromMap(Map data) {
    itemHeader = data['itemHeader'];
    item = data['item'];
  }
}

class DbUserDiscSearchList {
  List<SearchObject>? searchObject;

  DbUserDiscSearchList({this.searchObject});

  factory DbUserDiscSearchList.fromMap({required data}) {
    return DbUserDiscSearchList(
      searchObject: (data['SearchObjects'] as List? ?? [])
          .map((values) => SearchObject.fromMap(values))
          .toList(),
    );
  }
}

class DbUserProfileInfo {
  List<dynamic>? allFriends;
  List<dynamic>? activeFriends;
  String? uid;
  String? firstName;
  String? lastName;
  String? sex;
  String? gender;
  String? firstLanguage;
  String? interestedIn;
  String? relationshipStatus;
  int? age;
  String? bio;
  String? profilePicture;
  List<dynamic>? userPictures;

  DbUserProfileInfo(
      {this.activeFriends,
      this.allFriends,
      this.uid,
      this.firstName,
      this.lastName,
      this.sex,
      this.gender,
      this.firstLanguage,
      this.interestedIn,
      this.relationshipStatus,
      this.age,
      this.bio,
      this.userPictures,
      this.profilePicture});

  factory DbUserProfileInfo.fromMap({required Map<String, dynamic> data}) {
    return DbUserProfileInfo(
      uid: data['Uid'] ?? "",
      firstName: data['FirstName'] ?? "",
      lastName: data['LastName'] ?? "",
      sex: data['BiologicalSex'] ?? "",
      gender: data['Gender'] ?? "",
      firstLanguage: data['FirstLanguage'] ?? " ",
      interestedIn: data['InterestedIn'] ?? "",
      relationshipStatus: data['RelationshipStatus'] ?? "",
      age: data['Age'] ?? 0,
      bio: data['Bio'] ?? "",
      userPictures: (data['UserPictures'] as List? ?? []).toList(),
      allFriends: (data['AllFriends'] as List? ?? []).toList(),
      activeFriends: (data['ActiveFriends'] as List? ?? []).toList(),
      profilePicture: data['ProfilePicture'] ?? "",
    );
  }
}

class DbUserProfileSearchInfo {
  List<dynamic>? languages;
  List<dynamic>? countriesLivedIn;
  List<dynamic>? culturalHeritage;
  List<dynamic>? religion;
  List<dynamic>? hobbiesInterest;
  List<dynamic>? mentoringIn;

  DbUserProfileSearchInfo(
      {this.languages,
      this.countriesLivedIn,
      this.culturalHeritage,
      this.religion,
      this.hobbiesInterest,
      this.mentoringIn});
  factory DbUserProfileSearchInfo.fromMap(
      {required Map<String, dynamic> data}) {
    return DbUserProfileSearchInfo(
      languages: (data['Languages'] as List? ?? []).toList(),
      countriesLivedIn: (data['CountriesLivedIn'] as List? ?? []).toList(),
      culturalHeritage: (data['CulturalHeritage'] as List? ?? []).toList(),
      religion: (data['Religion'] as List? ?? []).toList(),
      hobbiesInterest: (data['HobbiesInterest'] as List? ?? []).toList(),
      mentoringIn: (data['MentoringIn'] as List? ?? []).toList(),
    );
  }
}

class FsUserPhotos {
  String? profilePhoto;

  FsUserPhotos({this.profilePhoto});
  factory FsUserPhotos.fromMap({required Map<String, dynamic> data}) {
    return FsUserPhotos(
      profilePhoto: data['UserPhotos'] ?? "",
    );
  }
}

// FriendObject(
//       {this.bio,
//       required this.profilePhoto,
//       required this.firstName,
//       required this.lastName,
//       required this.age,
//       required this.biologicalSex,
//       this.gender,
//       required this.interestedIn,
//       required this.relationshipStatus,
//       required this.firstLanguage,
//       this.otherLanguages,
//       this.countriesLivedIn,
//       this.religionsPracticed,
//       this.culturalHeritage,
//       this.hobbiesInterest,
//       this.mentoringOthersIn,
//       this.userPhotos});
//   FriendObject.fromMap(Map data) {
//     bio = data['Bio'];
//     profilePhoto = data['ProfilePhoto'] ?? "";
//     firstName = data['FirstName'] ?? "";
//     lastName = data['LastName'] ?? "";
//     age = data['Age'] ?? 0;
//     biologicalSex = data['BiologicalSex'] ?? "";
//     gender = data['Gender'] ?? "";
//     interestedIn = data['InterestedIn'] ?? "";
//     relationshipStatus = data['RelationshipStatus'] ?? "";
//     firstLanguage = data['FirstLanguage'] ?? "";
//     otherLanguages = (data['OtherLanguages'] as List? ?? []).toList();
//     countriesLivedIn = (data['CountriesLivedIn'] as List? ?? []).toList();
//     religionsPracticed = (data['ReligionsPracticed'] as List? ?? []).toList();
//     culturalHeritage = (data['CulturalHeritage'] as List? ?? []).toList();
//     hobbiesInterest = (data['HobbiesInterest'] as List? ?? []).toList();
//     mentoringOthersIn = (data['MentoringOthersIn'] as List? ?? []).toList();
//     userPhotos = (data['UserPhotos'] as List? ?? []).toList();
//   }
// }
