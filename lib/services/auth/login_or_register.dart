import 'package:flutter/material.dart';
import 'package:minichat/pages/login_screen.dart';
import 'package:minichat/pages/signup_screen.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showloginpage=true;


  void togglepages(){
    setState(() {
        showloginpage=!showloginpage;
  
    });
  }
  @override
  Widget build(BuildContext context) {
    
  if(showloginpage){
    return  LogiScreen(
      ontap: togglepages
      ,
      
    );
  }else{
    return  Signupscreen(
      ontap: togglepages,
    );
  }
  }
}