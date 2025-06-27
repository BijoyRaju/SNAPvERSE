import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:snapverese/view/chat/chat_screen.dart';
import 'package:snapverese/view/explore/explore_screen.dart';
import 'package:snapverese/view/home/home_screen.dart';
import 'package:snapverese/view/profile/profile_screen.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {

  int _selectedIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _curvedNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    final List<Widget> pages = [
      HomeScreen(),
      ExploreScreen(),
      ChatScreen(),
      ProfileScreen()
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        key: _curvedNavigationKey,
        index: _selectedIndex,
        height: 65.0,
        items: const [
          Icon(Icons.home, size: 33, color: Color(0xFF002B20)),
          Icon(Icons.explore_sharp, size: 33, color: Color(0xFF002B20)),
          Icon(Icons.chat, size: 33, color: Color(0xFF002B20)),
          Icon(Icons.supervised_user_circle_sharp, size: 33, color: Color(0xFF002B20)),
        ],
        color: Colors.white,
        backgroundColor: Colors.black,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}