import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  User? loggedInUser;

  User? get getUser => _auth.currentUser;
  

  getCurrentUser() async {
    try {
      final User? user = await getUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
    return loggedInUser;
  }

  Future<UserCredential> signInWithEmailPassword ({required String email, required String password}){
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Stream<User?> get streamUser => _auth.authStateChanges();

  Future<void> signOut() {
    return _auth.signOut();
  }

  Future<void> updateUserData(User user) {
    DocumentReference reportRef = _db.collection('reports').doc(user.uid);
    return reportRef.set({'uid': user.uid, 'lastActivity': DateTime.now()},
        SetOptions(merge: true));
  }
}
