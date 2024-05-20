

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:minichat/pages/login_screen.dart';

class SplashService{
  void islogin(BuildContext context){




Timer(const Duration(seconds: 3), ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> LogiScreen())));



  }
}
