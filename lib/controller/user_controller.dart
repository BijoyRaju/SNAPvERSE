import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapverese/models/users_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserController extends ChangeNotifier {
  final List<UsersModel> _allUsers = [];
  List<UsersModel> _filteredUsers = [];

  List<UsersModel> get filteredUsers => _filteredUsers;

  Future<void> fetchUsers(BuildContext context) async {
    try {
      final response = await Supabase.instance.client
          .from('users')
          .select('uid,name,profile_image,email,phone,bio,created_at');

      final data = response as List;
      _allUsers
        ..clear()
        ..addAll(data.map((e) => UsersModel.fromJson(e)));

      _filteredUsers = []; 
      notifyListeners();
    } catch (e) {
      log("Search error: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Something went wrong: $e")),
        );
      }
    }
  }

  void searchUsers(String query) {
    _filteredUsers = _allUsers
        .where((user) =>
            user.name.toLowerCase().contains(query.trim().toLowerCase()))
        .toList();
    notifyListeners();
  }


  Future<String?> uploadProfileImageToSupabase(ImageSource source)async{
    try{
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);
      if(pickedFile == null)return null;

      final uid = FirebaseAuth.instance.currentUser?.uid;
      if(uid == null)return null;

      final file = File(pickedFile.path);
      final fileBytes = await file.readAsBytes();
      final fileName = 'profile_$uid.jpg';

      await Supabase.instance.client.storage
        .from('profile-image') 
        .uploadBinary(fileName, fileBytes, fileOptions: const FileOptions(upsert: true));

      final imageUrl = Supabase.instance.client.storage
        .from('profile-image')
        .getPublicUrl(fileName);

      await Supabase.instance.client
        .from('users')
        .update({'profile_image': imageUrl})
        .eq('uid', uid);

      return imageUrl;
     }catch(e){
      log("Uploaded image error: $e");
      return null;
    }
  }
}
