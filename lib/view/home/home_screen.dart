import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:snapverese/view/home/add_post/add_post_dialog.dart';
import 'package:snapverese/view/home/notification/notification_screen.dart';
import 'package:snapverese/widgets/common.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customText("SNAPvERSE", 24,fontWeight: FontWeight.w500),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddPostDialog()));
          }, icon: Icon(Icons.add),iconSize: 28),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
          }, icon: Icon(Icons.notifications),iconSize: 28)
        ],
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsetsGeometry.all(8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CircleAvatar(radius: 35),
                Gap(15),
                CircleAvatar(radius: 35),
                Gap(15),
                CircleAvatar(radius: 35),
                Gap(15),
                CircleAvatar(radius: 35),
                Gap(15),
                CircleAvatar(radius: 35),
                Gap(15),
                CircleAvatar(radius: 35),
                Gap(15),
                CircleAvatar(radius: 35),
                Gap(15),
                CircleAvatar(radius: 35),
                Gap(15),
                CircleAvatar(radius: 35),
                Gap(15),
                CircleAvatar(radius: 35),
                Gap(15),
              ],
            ),
          ),)
        ],
      ),
    );
  }
}