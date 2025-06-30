import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:snapverese/view/settings/edit_profile/edit_profile_screen.dart';
import 'package:snapverese/widgets/common.dart';
import 'package:snapverese/widgets/login_screen_widget.dart';
import 'package:snapverese/widgets/settings_screen_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
  preferredSize: Size.fromHeight(70),
  child: ClipRRect(
    borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(24), 
    ),
    child: AppBar(
      backgroundColor: Colors.black, 
      title: customText("Settings", 24, fontWeight: FontWeight.w500, color: Colors.white),
      automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: 4,
      ),
    ),
  ),
    body: ListView(
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  children: [
    customProfileCard("Profile", Icons.edit,(){
      Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
    }),
    customProfileCard("Language", Icons.language,(){}),
    customProfileCard("Friends", Icons.co_present_outlined,(){}),
    Gap(15),
    customText("Preferences", 24,fontWeight: FontWeight.w700),
    Gap(15),
    customProfileCard("Account & Privacy", Icons.privacy_tip_rounded,(){}),
    customProfileCard("SNAPvERESE Help", Icons.help_outline,(){}),
    customProfileCard("About", Icons.info_outline,(){}),
    Gap(15),
    loginButton("Log Out", (){}, null)
  ],
),

    );
  }
}