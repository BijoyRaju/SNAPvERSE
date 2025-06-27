import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:snapverese/firebase_options.dart';
import 'package:snapverese/view/login/login_screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}