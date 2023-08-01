
import 'dart:async';
import 'package:agunbase/ui/auth/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SplashServices{

  void isLogin(BuildContext context){
    Timer(Duration(seconds: 3),
    ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()))
    );
  }
}