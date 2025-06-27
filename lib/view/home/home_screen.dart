import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
          IconButton(onPressed: (){}, icon: Icon(Icons.add),iconSize: 28),
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications),iconSize: 28)
        ],
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