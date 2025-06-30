import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:snapverese/widgets/common.dart';
import 'package:snapverese/widgets/login_screen_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
          child: AppBar(
            backgroundColor: Colors.black,
            title: customText("Edit Profile", 24, fontWeight: FontWeight.w500, color: Colors.white),
            foregroundColor: Colors.white,
            centerTitle: true,
            elevation: 4,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage('assets/images/profile.png'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 18,
                        child: IconButton(onPressed: (){}, icon: Icon(Icons.edit),color: Colors.white,)
                      ),
                    ),
                  ],
                ),
              ),
              Gap(30),
              customText("Name", 16, fontWeight: FontWeight.w500),
              Gap(8),
              loginTextField("",nameController),
              Gap(20),
              customText("Email", 16, fontWeight: FontWeight.w500),
              Gap(8),
              loginTextField("",emailController),
              Gap(20),
              customText("Phone", 16, fontWeight: FontWeight.w500),
              Gap(8),
              loginTextField("",phoneController),
              Gap(20),
              customText("Bio", 16, fontWeight: FontWeight.w500),
              Gap(8),
              loginTextField("",bioController),
              Gap(30),
              loginButton("Save", updateUserData, null)
            ],
          ),
        ),
    );
  }

  Future<void> fetchUserData()async{
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if(uid != null){
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if(userDoc.exists){
        final data = userDoc.data()!;
        nameController.text = data['name'] ?? '';
        emailController.text = data['email'] ?? '';
        phoneController.text = data['phone'] ?? '';
        bioController.text = data['bio'] ?? '';
      }
    }
  }

    void updateUserData() async{
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if(uid != null){
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'name' : nameController.text.trim(),
        'email' : emailController.text.trim(),
        'phone' : phoneController.text.trim(),
        'bio' : bioController.text.trim()
      });

      await Supabase.instance.client.from('users').update({
        'name' : nameController.text.trim(),
        'email' : emailController.text.trim(),
        'phone' : phoneController.text.trim(),
        'bio' : bioController.text.trim()
      }).eq('uid', uid);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Profile updated successfully")));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    bioController.dispose();
    super.dispose();
  }
}
