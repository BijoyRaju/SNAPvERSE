import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:snapverese/controller/auth_controller.dart';
import 'package:snapverese/view/login/login_screen.dart';
import 'package:snapverese/view/settings/about/about_screen.dart';
import 'package:snapverese/view/settings/account_and_privacy/account_and_privacy_screen.dart';
import 'package:snapverese/view/settings/edit_profile/edit_profile_screen.dart';
import 'package:snapverese/view/settings/language/language_screen.dart';
import 'package:snapverese/view/settings/snapverse_help/snapverese_help_screen.dart';
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
    // Language
    customProfileCard("Language", Icons.language,(){
      Navigator.push(context, MaterialPageRoute(builder: (context) => LanguageScreen()));
    }),
    customProfileCard("Friends", Icons.co_present_outlined,(){}),
    Gap(15),
    customText("Preferences", 24,fontWeight: FontWeight.w700),
    Gap(15),

    // Account & Privacy
    customProfileCard("Account & Privacy", Icons.privacy_tip_rounded,(){
      Navigator.push(context, MaterialPageRoute(builder: (context) => AccountAndPrivacyScreen()));
    }),

    // Help
    customProfileCard("SNAPvERESE Help", Icons.help_outline,(){
      Navigator.push(context, MaterialPageRoute(builder: (context) => SnapvereseHelpScreen()));
    }),

    // About
    customProfileCard("About", Icons.info_outline,(){
      Navigator.push(context, MaterialPageRoute(builder: (context) => AboutScreen()));
    }),

    Gap(15),
    loginButton("Log Out", ()async{
      final authController = Provider.of<AuthController>(context,listen: false);
      await authController.signOut();
      if(context.mounted){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Logout Successfull")));
      }
    }, null)
  ],
),

    );
  }
}