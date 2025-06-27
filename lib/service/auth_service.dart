import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;


Future<String?> registerWithEmail({
  required String name,
  required String email,
  required String phone,
  required String password,
}) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await _firestore.collection("users").doc(userCredential.user!.uid).set({
      "uid": userCredential.user!.uid,
      "name": name,
      "email": email,
      "phone": phone,
      "profileImage":"",
      "bio": "",
      "createdAt": DateTime.now().toIso8601String(),
    });

    return null;
  } on FirebaseAuthException catch (e) {
    log("Error Found on registration: $e");
    return e.message;
  }
}
  Future <String?> loginWithEmail(String email,String password)async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    }on FirebaseException catch(e){
      log("Error on Login: $e");
      return e.message;
    }
  }

  Future <void> logOut()async{
    await _auth.signOut();
  }

}