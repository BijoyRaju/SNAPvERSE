import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapverese/controller/user_controller.dart';
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

  final userController = UserController();
  String? uploadedImageUrl;

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
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: uploadedImageUrl != null
                        ? NetworkImage(uploadedImageUrl!)
                        : const AssetImage('assets/images/profile.png') as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 18,
                      child: IconButton(
                        onPressed: pickAndUploadImage,
                        icon: const Icon(Icons.edit),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(30),
            customText("Name", 16, fontWeight: FontWeight.w500),
            const Gap(8),
            loginTextField("", nameController),
            const Gap(20),
            customText("Email", 16, fontWeight: FontWeight.w500),
            const Gap(8),
            loginTextField("", emailController),
            const Gap(20),
            customText("Phone", 16, fontWeight: FontWeight.w500),
            const Gap(8),
            loginTextField("", phoneController),
            const Gap(20),
            customText("Bio", 16, fontWeight: FontWeight.w500),
            const Gap(8),
            loginTextField("", bioController),
            const Gap(30),
            loginButton("Save", updateUserData, null)
          ],
        ),
      ),
    );
  }

  Future<void> fetchUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userDoc.exists) {
        final data = userDoc.data()!;
        nameController.text = data['name'] ?? '';
        emailController.text = data['email'] ?? '';
        phoneController.text = data['phone'] ?? '';
        bioController.text = data['bio'] ?? '';
        uploadedImageUrl = data['profile_image'] ?? null;
        setState(() {});
      }
    }
  }

  void updateUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'bio': bioController.text.trim(),
        'profile_image': uploadedImageUrl ?? '',
      });

      await Supabase.instance.client.from('users').update({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'bio': bioController.text.trim(),
        'profile_image': uploadedImageUrl ?? '',
      }).eq('uid', uid);

      showSnackBar("Profile updated successfully");
    }
  }

  void pickAndUploadImage() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () async {
                Navigator.pop(context);
                final url = await userController.uploadProfileImageToSupabase(ImageSource.camera);
                if (url != null) {
                  setState(() => uploadedImageUrl = url);
                  showSnackBar("Image uploaded from camera");
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Gallery"),
              onTap: () async {
                Navigator.pop(context);
                final url = await userController.uploadProfileImageToSupabase(ImageSource.gallery);
                if (url != null) {
                  setState(() => uploadedImageUrl = url);
                  showSnackBar("Image uploaded from gallery");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
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
