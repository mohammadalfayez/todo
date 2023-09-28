import 'package:flutter/material.dart';
import 'package:todo/screens/loginscreen.dart';
import 'package:todo/screens/signupscreen.dart';

class AuthenticateScreen extends StatefulWidget {
  const AuthenticateScreen({super.key});

  @override
  State<AuthenticateScreen> createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {
  bool showSignIn = true;

  void toggleSignIn(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
     if(showSignIn == true){
      return LoginScreen(toggleSignIn: toggleSignIn);
     }
     else {
      return SignUpPage(toggleSignIn:toggleSignIn);
     }
  }
}