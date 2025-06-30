import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthService {
  final fb.FirebaseAuth _auth = fb.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final sb.SupabaseClient supabase = sb.Supabase.instance.client;

  // Get currently logged in Firebase user
  fb.User? get currentUser => _auth.currentUser;

  /// Register user in Firebase Auth + Firestore + Supabase
  Future<String?> registerWithEmail({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      // Firebase Auth
      fb.UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = userCredential.user!.uid;

      // Save user in Firebase Firestore
      await _firestore.collection("users").doc(uid).set({
        "uid": uid,
        "name": name,
        "email": email,
        "phone": phone,
        "profileImage": "",
        "bio": "",
        "createdAt": DateTime.now().toIso8601String(),
      });

      // Save user in Supabase
      final response = await supabase.from('users').insert({
        'uid': uid,
        'name': name,
        'email': email,
        'phone': phone,
        'bio': '',
        'profile_image': '',
        'created_at': DateTime.now().toIso8601String(),
      }).select(); // <- Needed to trigger proper response

      log("Supabase insert success: $response");
      return null;
    } on fb.FirebaseAuthException catch (e) {
      log("Firebase Registration Error: $e");
      return e.message;
    } catch (e) {
      log("Unexpected Registration Error: $e");
      return "Something went wrong";
    }
  }

  /// Login using Firebase Auth
  Future<String?> loginWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on fb.FirebaseAuthException catch (e) {
      log("Firebase Login Error: $e");
      return e.message;
    }
  }

  /// Logout
  Future<void> logOut() async {
    await _auth.signOut();
  }
}
