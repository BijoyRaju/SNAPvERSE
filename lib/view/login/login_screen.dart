import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:snapverese/service/auth_service.dart';
import 'package:snapverese/view/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:snapverese/view/register/register_screen.dart';
import 'package:snapverese/widgets/common.dart';
import 'package:snapverese/widgets/login_screen_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _authService = AuthService();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
      Padding(
        padding: const EdgeInsets.only(right: 10,left: 10),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: customText("LOGIN", 40,fontWeight: FontWeight.bold)),
                Gap(100),
                customText("User Name", 16,fontWeight: FontWeight.w500,color: const Color.fromARGB(255, 92, 92, 92)),
                Gap(11),
                loginTextField("xxx@gmail.com",userNameController),
                Gap(20),
                customText("Password", 16,fontWeight: FontWeight.w500,color: const Color.fromARGB(255, 92, 92, 92)),
                Gap(11),
                loginTextField("*********",passwordController),
                Gap(11),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    customText("forgot password ?", 16,fontWeight: FontWeight.w500,color: const Color.fromARGB(255, 92, 92, 92)),
                  ],
                ),
                Gap(20),
                loginButton("Login",handleLogin,null),
                Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customText("Don't have an account?", 16,fontWeight: FontWeight.w500,color: const Color.fromARGB(255, 92, 92, 92)),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                        },
                        child: customText(" Sign Up", 16,fontWeight: FontWeight.bold)),
                    ],
                  ),
                Gap(50),
                loginCustomButton("Google", (){}, 'assets/images/google.png'),
                Gap(20),
                loginCustomButton("Apple", (){}, 'assets/images/apple.png'),
              ],
            ),
          ],
        ),

      )),
    );
  }

  void handleLogin() async {
  String email = userNameController.text.trim();
  String password = passwordController.text.trim();

  if (email.isEmpty || password.isEmpty) {
    showSnackbar("Please enter email and password");
    return;
  }

  if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email)) {
    showSnackbar("Enter a valid email");
    return;
  }
  // TODO: Call Firebase Auth register function here
  final result = await _authService.loginWithEmail(email, password);
  if(result == null){
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => BottomNavigationBarScreen()));
    showSnackbar("Login successfull");
  }else{
    showSnackbar(result);
  }
}

void showSnackbar(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}


  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}