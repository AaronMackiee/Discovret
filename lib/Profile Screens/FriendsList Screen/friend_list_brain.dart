class FriendProfile {
  final String? friendProfilePicture;
  final String? friendProfileName;
  final String? friendCompliment;
  String? friendReview;

  FriendProfile(
      {this.friendProfilePicture,
      this.friendProfileName,
      this.friendCompliment,
      this.friendReview});
}

class ActiveFriendsObject {
  final String? friendProfilePicture;
  final String? friendProfileName;
  final String? friendCompliment;
  final bool? friendReview;

  ActiveFriendsObject(
      {this.friendProfilePicture,
      this.friendProfileName,
      this.friendCompliment,
      this.friendReview});
}
