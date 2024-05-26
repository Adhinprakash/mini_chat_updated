import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minichat/pages/login_screen.dart';
import 'package:minichat/pages/screen_home.dart';
import 'package:minichat/services/auth/auth_services.dart';
import 'package:minichat/services/auth/login_or_register.dart';

class Authgateway extends StatelessWidget {
  const Authgateway({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: 
      FirebaseAuth. instance.authStateChanges()
      , builder: (context,snapshot){
        if(snapshot.hasData){
          return  ScreenHome();
        }else{
          return LoginOrRegister();
        }
      }),
    );
  }
}