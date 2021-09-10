import 'dart:io';
import 'package:discovret1_0/FirebaseServices/auth_service.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;

class FirebaseStorageServices {
  final AuthService _auth = AuthService();

  // Future<dynamic> uploadProfilePhoto(String path) async {
  //   final ref = storage.FirebaseStorage.instance
  //       .ref()
  //       .child('ProfilePhotos')
  //       .child('${_auth.getUser!.uid}');

  //   final result = await ref.putFile(File(path));
  //   // final fileUrl = await result.ref.getDownloadURL();

  //   // widget.onFileChanged((fileUrl));
  //   return result;
  // }

  Future<dynamic> uploadUserPhoto(
      {required String path, required String currentTime}) async {
    final ref = storage.FirebaseStorage.instance
        .ref()
        .child('UserPhotos')
        .child('${_auth.getUser!.uid}')
        .child(currentTime);

    final result = await ref.putFile(File(path));
    // final fileUrl = await result.ref.getDownloadURL();

    // widget.onFileChanged((fileUrl));
    return result;
  }

  // Future<String> downloadProfilePhoto() async {
  //   final ref = storage.FirebaseStorage.instance
  //       .ref()
  //       .child('ProfilePhotos')
  //       .child('${_auth.getUser!.uid}');

  //   // final result = await ref.putFile(File(path));
  //   final fileUrl = await ref.getDownloadURL();
  //   fileUrl.toString();

  //   String imageUrl = fileUrl;

  //   if (imageUrl.isEmpty) {
  //     print('string is empty');
  //   } else
  //     print(imageUrl);

  //   return imageUrl;
  // }

  Future<String> downloadUserPhoto({required String currentTime}) async {
    final ref = storage.FirebaseStorage.instance
        .ref()
        .child('UserPhotos')
        .child('${_auth.getUser!.uid}')
        .child(currentTime);

    // final result = await ref.putFile(File(path));
    final fileUrl = await ref.getDownloadURL();
    fileUrl.toString();

    String imageUrl = fileUrl;

    if (imageUrl.isEmpty) {
      print('string is empty');
    } else
      print(imageUrl);

    return imageUrl;
  }

  Future<void> fsDeleteUserPhoto({required String fsUrl}) async {
    storage.FirebaseStorage.instance.refFromURL(fsUrl).delete();
  }
}

// Future<DbUserFriendsList>? getFriendsList() {
//     final Stream<User?>? user = _auth.streamUser;
//     if (user != null) {
//       return _auth.getCurrentUser().switchMap((User? user) {
//         final path = _db.collectionGroup('UserProfileInfo');
//         Query query = path.where('FirstName', isEqualTo: 'Aaron');
//         query.snapshots().map((snapshot) {
//           Map<String, dynamic> newdata =
//               snapshot.docs.asMap() as Map<String, dynamic>;
//           return DbUserFriendsList.fromMap(data: newdata);
//         });
//       });
//     }
//   }


