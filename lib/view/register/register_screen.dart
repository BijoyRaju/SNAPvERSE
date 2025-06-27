import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:snapverese/service/auth_service.dart';
import 'package:snapverese/view/login/login_screen.dart';
import 'package:snapverese/widgets/common.dart';
import 'package:snapverese/widgets/login_screen.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _authService = AuthService();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 10,left: 10),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: customText("REGISTER", 40,fontWeight: FontWeight.bold)),
                  Gap(80),
                  customText("Enter your name", 16,fontWeight: FontWeight.w500,color: const Color.fromARGB(255, 92, 92, 92)),
                  Gap(11),
                  loginTextField("Jhon Smith",nameController),
                  Gap(20),
                  customText("Enter your mobile number", 16,fontWeight: FontWeight.w500,color: const Color.fromARGB(255, 92, 92, 92)),
                  Gap(11),
                  loginTextField("9846284412",phoneController),
                  Gap(20),
                  customText("Enter your email", 16,fontWeight: FontWeight.w500,color: const Color.fromARGB(255, 92, 92, 92)),
                  Gap(11),
                  loginTextField("xxx@gmail.com",emailController),
                  Gap(11),
                  customText("Enter your password", 16,fontWeight: FontWeight.w500,color: const Color.fromARGB(255, 92, 92, 92)),
                  Gap(11),
                  loginTextField("**********",passwordController),
                  Gap(11),
                  customText("Re-Enter your password", 16,fontWeight: FontWeight.w500,color: const Color.fromARGB(255, 92, 92, 92)),
                  Gap(11),
                  loginTextField("**********",rePasswordController),
                  Gap(20),
                  loginButton("Sign Up",handleRegister,null),
                  Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customText("Already have an account?", 16,fontWeight: FontWeight.w500,color: const Color.fromARGB(255, 92, 92, 92)),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                          },
                          child: customText(" Sign In", 16,fontWeight: FontWeight.bold)
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ));
  }

  void handleRegister() async {
  String name = nameController.text.trim();
  String email = emailController.text.trim();
  String phone = phoneController.text.trim();
  String password = passwordController.text.trim();
  String rePassword = rePasswordController.text.trim();

  if (name.isEmpty|| email.isEmpty || phone.isEmpty || password.isEmpty || rePassword.isEmpty) {
    showSnackbar("Please fill in all fields");
    return;
  }

  if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email)) {
    showSnackbar("Enter a valid email");
    return;
  }

  if (password.length < 6) {
    showSnackbar("Password must be at least 6 characters");
    return;
  }

  if (password != rePassword) {
    showSnackbar("Passwords do not match");
    return;
  }

  // Call Firebase Auth register function here
  final result = await _authService.registerWithEmail(name: name, email: email, phone: phone, password: password);
  if(result == null){
    showSnackbar("Registration Succesfull");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }
}