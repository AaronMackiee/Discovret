class FriendObject {
  String? friendReview;
  String profilePhoto = 'assets/profile7.jpg';
  String firstName = 'Natalia';
  String lastName = 'Mackie';
  String bio = 'Live, Laugh, Love';
  int rating = 98;
  int visitsThisYear = 7;
  int daysTillExp = 320;
  String biologicalSex = 'Female';
  String gender = 'Female';
  int age = 29;
  String interestedIn = 'Men';
  String relationshipStatus = 'Married';
  String firstLanguage = 'Spanish';
  String onErrorText = "";
  List<MutualFriends>? listMutualFriends;
  List<String> listPhotos = [
    'assets/profile1.jpg',
    'assets/profile2.jpg',
    'assets/profile3.jpg',
    'assets/profile4.jpg',
    'assets/profile5.jpg',
    'assets/profile6.jpg',
    'assets/profile7.jpg',
    'assets/profile8.jpg',
    'assets/profile9.jpg',
    'assets/profile10.jpg',
    'assets/profile11.jpg',
    'assets/profile12.jpg',
    'assets/profile13.jpg',
    'assets/profile14.jpg',
    'assets/profile15.jpg',
  ];
}

class MutualFriends {
  String? profilePicture;
}
