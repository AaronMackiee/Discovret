class FriendObject {
  List<dynamic>? allFriends;
  List<dynamic>? allBusinesses;
  List<dynamic>? allPlaces;
  String? uid;
  String firstName;
  String lastName;
  String sex;
  String firstLanguage;
  String interestedIn;
  String relationshipStatus;
  String gender;
  int age;
  String? bio;
  int profileAccuracyRating;
  int reviewCount;
  int safetyRating;
  String profilePicture;
  List<dynamic>? userPictures;
  int totalVisits;
  int visitsThisYear;
  int? daysTillExp;
  List<dynamic>? languages;
  List<dynamic>? countriesLivedIn;
  List<dynamic>? culturalHeritage;
  List<dynamic>? religion;
  List<dynamic>? hobbiesInterest;
  List<dynamic>? mentoringIn;

  FriendObject(
      {this.allFriends,
      this.allBusinesses,
      this.allPlaces,
      this.uid,
      required this.firstName,
      required this.lastName,
      required this.sex,
      required this.gender,
      required this.firstLanguage,
      required this.interestedIn,
      required this.relationshipStatus,
      required this.age,
      this.bio,
      required this.totalVisits,
      required this.visitsThisYear,
      required this.profileAccuracyRating,
      required this.safetyRating,
      required this.reviewCount,
      this.userPictures,
      required this.profilePicture,
      this.languages,
      this.countriesLivedIn,
      this.culturalHeritage,
      this.religion,
      this.hobbiesInterest,
      this.mentoringIn,
      this.daysTillExp});
}

// class InactiveFriendObject {
//   String? docId;
//   List<dynamic>? allFriends;
//   String? uid;
//   String firstName;
//   String lastName;
//   String sex;
//   String firstLanguage;
//   String interestedIn;
//   String relationshipStatus;
//   String gender;
//   int age;
//   String? bio;
//   String profilePicture;
//   List<dynamic>? userPictures;
//   int totalVisits;
//   int visitsThisYear;
//   int? daysTillExp;

//   InactiveFriendObject({
//       this.docId,
//       this.allFriends,
//       this.uid,
//       required this.firstName,
//       required this.lastName,
//       required this.sex,
//       required this.firstLanguage,
//       required this.interestedIn,
//       required this.relationshipStatus,
//       required this.age,
//       required this.gender,
//       this.bio,
//       this.userPictures,
//       required this.profilePicture,
//       required this.totalVisits,
//       required this.visitsThisYear,
//       this.daysTillExp
//   });
// }

// class CloseFriendObject {
//   String? docId;
//   List<dynamic>? allFriends;
//   String? uid;
//   String firstName;
//   String lastName;
//   String sex;
//   String firstLanguage;
//   String interestedIn;
//   String relationshipStatus;
//   String gender;
//   int age;
//   String? bio;
//   String profilePicture;
//   List<dynamic>? userPictures;
//   int totalVisits;
//   int visitsThisYear;
//   int? daysTillExp;

//   CloseFriendObject({
//       this.docId,
//       this.allFriends,
//       this.uid,
//       required this.firstName,
//       required this.lastName,
//       required this.sex,
//       required this.firstLanguage,
//       required this.interestedIn,
//       required this.relationshipStatus,
//       required this.age,
//       required this.gender,
//       this.bio,
//       this.userPictures,
//       required this.profilePicture,
//       required this.totalVisits,
//       required this.visitsThisYear,
//       this.daysTillExp
//   });
// }

class ViewProfileFriendObject {
  final int photoCount;
  final int reviewCount;
  final int profileAccuracyRating;
  final int safetyRating;
  final String profilePhoto;
  final String firstName;
  final String lastName;
  final String? bio;
  final int? visitsThisYear;
  final int? daysTillExp;
  final String biologicalSex;
  final String? gender;
  final int age;
  final String interestedIn;
  final String relationshipStatus;
  final String firstLanguage;
  final List<dynamic> userPhotos;
  final List<dynamic> allFriends;
  final List<dynamic> allBusinesses;
  final List<dynamic> allPlaces;
  final List<dynamic>? countriedLivedIn;
  final List<dynamic>? culturalHeritage;
  final List<dynamic>? hobbiesInterest;
  final List<dynamic>? languages;
  final List<dynamic>? mentoringIn;
  final List<dynamic>? religionsPracticed;

  ViewProfileFriendObject(
      {required this.profileAccuracyRating,
      required this.photoCount,
      required this.safetyRating,
      required this.reviewCount,
      required this.userPhotos,
      required this.profilePhoto,
      required this.firstName,
      required this.lastName,
      this.bio,
      this.visitsThisYear,
      this.daysTillExp,
      required this.biologicalSex,
      this.gender,
      required this.age,
      required this.interestedIn,
      required this.relationshipStatus,
      required this.firstLanguage,
      required this.allFriends,
      required this.allBusinesses,
      required this.allPlaces,
      this.countriedLivedIn,
      this.culturalHeritage,
      this.hobbiesInterest,
      this.languages,
      this.mentoringIn,
      this.religionsPracticed});
}
