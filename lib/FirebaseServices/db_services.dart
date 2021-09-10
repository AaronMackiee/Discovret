import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discovret1_0/FirebaseServices/f_storage.dart';
import 'package:discovret1_0/Provider Services/profile_info_provider.dart';
import 'package:discovret1_0/FirebaseServices/auth_service.dart';
import 'package:discovret1_0/FirebaseServices/db_models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;

import 'globals.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final AuthService _auth = AuthService();
  final FirebaseStorageServices _fs = FirebaseStorageServices();

  // Stream<List<FriendObject>>? getFriendsList() {
  //   final path = _db.collection('UserProfileInfo');
  //   // path.where('Age', isEqualTo: 27)
  //   path.snapshots().map((snapshot) {
  //     snapshot.docs.map((docs) {
  //       Map<String, dynamic> newdata = docs.data();
  //       return FriendObject.fromMap(data: newdata);
  //     }).toList();
  //   });
  // }
  Stream<List<ConfirmationsObject>>? getConfirmationsList() {
    final Stream<User?>? user = _auth.streamUser;
    if (user != null) {
      return _auth.streamUser.switchMap((User? user) {
        return _db
            .collection('FriendConfirmations')
            .where('Uids', arrayContains: _auth.getUser!.uid)
            .snapshots()
            .map((snapshot) {
          return snapshot.docs.map((docs) {
            return ConfirmationsObject.fromMap(data: docs.data());
          }).toList();
        });
      });
    }
  }

  Stream<List<AllFriendsObject>>? getFriendsList() {
    final Stream<User?>? user = _auth.streamUser;
    if (user != null) {
      return _auth.streamUser.switchMap((User? user) {
        return _db
            .collection('UserProfileInfo')
            .where('AllFriends', arrayContains: _auth.getUser!.uid)
            .snapshots()
            .map((snapshot) {
          return snapshot.docs.map((docs) {
            return AllFriendsObject.fromMap(data: docs.data());
          }).toList();
        });
      });
    }
  }

  // Stream<List<UserDiscSearchList>> getDiscSearchList() {
  //   return _db.collection('UserDiscSearchList').snapshots().map((snapshot) {
  //     return snapshot.docs.map((docs) {
  //       return UserDiscSearchList.fromJson(docs.data());
  //     }).toList();
  //   });
  // }

  Stream<DbUserDiscSearchList>? getDiscSearchList() {
    final Stream<User?>? user = _auth.streamUser;
    if (user != null) {
      return _auth.streamUser.switchMap((User? user) {
        Document<dynamic> doc =
            Document(path: 'UserDiscSearchList/${user!.uid}');
        return doc.ref.snapshots().map((snapshot) {
          Map<String, dynamic> newdata =
              snapshot.data() as Map<String, dynamic>;
          return DbUserDiscSearchList.fromMap(data: newdata);
        });
      });
    }
  }

  Future<AddFriendObject> addFriendWithQRCode(String? friendUid) {
    Document<dynamic> doc = Document(path: 'UserProfileInfo/$friendUid');
    return doc.ref.get().then((values) {
      Map<String, dynamic> data = values.data() as Map<String, dynamic>;
      return AddFriendObject.fromMap(data: data);
    });
  }

  Stream<DbUserProfileInfo>? getUserProfileInfo() {
    final Stream<User?>? user = _auth.streamUser;
    if (user != null) {
      return _auth.streamUser.switchMap((User? user) {
        Document<dynamic> doc = Document(path: 'UserProfileInfo/${user!.uid}');
        return doc.ref.snapshots().map((snapshot) {
          Map<String, dynamic> newdata =
              snapshot.data() as Map<String, dynamic>;
          return DbUserProfileInfo.fromMap(data: newdata);
        });
      });
    }
  }

  // Stream<DbUserProfileInfo> getUserProfileInfo() {
  //   final User? user = _auth.getUser;
  //           Document<dynamic> doc = Document(path: 'UserProfileInfo/${user!.uid}');
  //           return doc.ref.snapshots().map((snapshot) {
  //             Map<String, dynamic> newdata =
  //                 snapshot.data() as Map<String, dynamic>;
  //             return DbUserProfileInfo.fromMap(data: newdata);
  //           });
  // }

  // Stream<DbUserProfileSearchInfo>? getUserProfileSearcInfo() {
  //   return _auth.authStateChanges().switchMap((User? user) {
  //         if (user != null) {
  //           Document<dynamic> doc = Document(path: 'UserProfileSearchInfo/${user.uid}');
  //           return doc.ref.snapshots().map((snapshot) {
  //             Map<String, dynamic> newdata =
  //                 snapshot.data() as Map<String, dynamic>;
  //             return DbUserProfileSearchInfo.fromMap(data: newdata);
  //           });
  //         } else {
  //           return null;
  //           // return Stream<DbUserProfileSearchInfo>.value(null);
  //         }
  //       } as Stream<DbUserProfileSearchInfo> Function(User? user));
  // }

  // Stream<DbUserProfileSearchInfo> getUserProfileSearcInfo() {
  //   final User? user = _auth.getUser;
  //   Document<dynamic> doc =
  //       Document(path: 'UserProfileSearchInfo/${user!.uid}');
  //   return doc.ref.snapshots().map((snapshot) {
  //     Map<String, dynamic> newdata = snapshot.data() as Map<String, dynamic>;
  //     return DbUserProfileSearchInfo.fromMap(data: newdata);
  //   });
  // }

  Stream<DbUserProfileSearchInfo>? getUserProfileSearcInfo() {
    final Stream<User?>? user = _auth.streamUser;
    if (user != null) {
      return _auth.streamUser.switchMap((User? user) {
        Document<dynamic> doc =
            Document(path: 'UserProfileSearchInfo/${user!.uid}');
        return doc.ref.snapshots().map((snapshot) {
          Map<String, dynamic> newdata =
              snapshot.data() as Map<String, dynamic>;
          return DbUserProfileSearchInfo.fromMap(data: newdata);
        });
      });
    }
  }

  // Stream<T> streamData() {
  //   return ref.snapshots().map((value) => Global.models[T](value.data) as T);
  // }

  // Stream<T> get documentStream {
  //   return _auth.authStateChanges().switchMap((user) {
  //     if (user != null) {
  //       Document<T> doc = Document<T>(path: '$collection/zrh1X2mrxuIwq5iy8huK');
  //       return doc.streamData();
  //     } else {
  //       return Stream<T>.value(null);
  //     }
  //   });
  // }

  Future<void> addSearchItem(
      {required String itemHeader,
      required String? item,
      required String field}) {
    List<Map<String, dynamic>> listDataMap = [];
    var dataMap = Map<String, dynamic>();
    dataMap['itemHeader'] = itemHeader;
    dataMap['item'] = item;
    listDataMap.add(dataMap);
    final ref = _db.collection('UserDiscSearchList').doc(_auth.getUser!.uid);
    return ref.update({
      field: FieldValue.arrayUnion(listDataMap),
    });
  }

  Future updateProfileInfo({required String field, required dynamic value}) {
    final ref = _db.collection('UserProfileInfo').doc(_auth.getUser!.uid);

    return ref.update({field: value});
  }

  Future updateConfirmationList(
      {required String fieldArray,required String field, required docId, required dynamic valueArray, required dynamic value}) {
        final Document<dynamic> doc = Document(path: 'FriendConfirmations/$docId');
  
    return doc.ref.update({
      fieldArray: FieldValue.arrayRemove([valueArray]),
      field: value,
    });
  }

  Future deleteDiscSearchObject(
      {required String field,
      required String? itemHeader,
      required String? item}) {
    // List<Map<String, dynamic>> listDataMap = [];
    // var dataMap = Map<String, dynamic>();
    // dataMap['itemHeader'] = itemHeader;
    // dataMap['item'] = item;
    final ref = _db.collection('UserDiscSearchList').doc(_auth.getUser!.uid);

    return ref.update(
      {
        field: FieldValue.arrayRemove([
          {'item': item, 'itemHeader': itemHeader}
        ])
      },
    );
  }

  // Future updateAllProfileInfo({Map<String, dynamic> data}) {
  //   final updateInfoRef =
  //       _db.collection('UserProfileInfo').doc(_auth.currentUser.uid);

  //   return updateInfoRef.update(data);
  // }

  Future<void> deleteSearchInfoItem(String path) {
    return _db.doc('dfd').delete();
  }

  Future updateProfileInfoList(
      {required String field, required dynamic value}) {
    final ref = _db.collection('UserProfileSearchInfo').doc(_auth.getUser!.uid);

    return ref.update(
      {
        field: FieldValue.arrayUnion(value),
      },
    );
  }

  Future updateUserPhotosList({required String field, required dynamic value}) {
    final ref = _db.collection('UserProfileInfo').doc(_auth.getUser!.uid);

    return ref.update(
      {
        field: FieldValue.arrayUnion(value),
      },
    );
  }

  Future deleteUserPhoto({required String field, required dynamic value}) {
    final ref = _db.collection('UserProfileInfo').doc(_auth.getUser!.uid);

    return ref.update(
      {
        field: FieldValue.arrayRemove([value]),
      },
    );
  }

  Future updateProfilePhoto({required String field, required dynamic value}) {
    final ref = _db.collection('UserProfileInfo').doc(_auth.getUser!.uid);

    return ref.update({field: value});
  }

  Future deleteAllProfileInfoList({required String field}) {
    final ref = _db.collection('UserProfileSearchInfo').doc(_auth.getUser!.uid);

    return ref.update(
      {
        field: FieldValue.delete(),
      },
    );
  }
}

//   String initialData() {
//     return "";
//   }

//   Future<int> get searchListCount {
//     listCount = getDiscSearchList().length;
//     return listCount;
//   }
//     Future<T> getDocument() async {
//     User user = FirebaseAuth.instance.currentUser;

//     if (user != null) {
//       Document doc = Document<T>(path: '$collection/${user.uid}');
//       return doc.getData();
//     } else {
//       return null;
//     }
//   }
// }

class Document<T> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String? path;
  late DocumentReference ref;

  Document({this.path}) {
    ref = _db.doc(path!);
  }

  Future<T> getData() {
    return ref.get().then((value) => Global.models[T](value.data) as T);
  }

  Stream<T?> streamData() {
    return ref.snapshots().map((value) => Global.models[T](value.data) as T?);
  }

  Future<void> upsert(Map data) {
    return ref.set(Map<String, dynamic>.from(data), SetOptions(merge: true));
  }
}

class Collection<T> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String? path;
  late CollectionReference ref;

  Collection({this.path}) {
    ref = _db.collection(path!);
  }

  Future<List<T?>> getData() async {
    var snapshots = await ref.get().then((snapshot) => snapshot.docs
        .map((doc) => Global.models[T](doc.data()) as T?)
        .toList());
    return snapshots;
  }

  Stream<List<T?>> streamData() {
    return ref.snapshots().map((list) =>
        list.docs.map((doc) => Global.models[T](doc.data()) as T?) as List<T?>);
  }
}

class UserData<T> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String? collection;

  UserData({this.collection});

  Stream<T> get documentStream {
    return _auth.authStateChanges().switchMap((user) {
          if (user != null) {
            Document<T> doc = Document<T>(path: '$collection/${user.uid}');
            return doc.streamData() as Stream<T>;
          } else {
            return null;
            // return Stream<T>.value(null);
          }
        } as Stream<T> Function(User?));
  }

  Future<T?> getDocument() async {
    User? user = _auth.currentUser;

    if (user != null) {
      Document doc = Document<T>(path: '$collection/${user.uid}');
      return doc.getData() as Future<T?>;
    } else {
      return null;
    }
  }

  Future<void> upsert(Map data) async {
    User user = _auth.currentUser!;
    Document<T> ref = Document(path: '$collection/${user.uid}');
    return ref.upsert(data);
  }
}
