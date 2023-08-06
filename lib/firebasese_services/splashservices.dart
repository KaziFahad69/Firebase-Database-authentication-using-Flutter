
import 'dart:async';
import 'package:agunbase/ui/auth/loginscreen.dart';
import 'package:agunbase/ui/posts/postscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SplashServices{

  void isLogin(BuildContext context){
  final auth = FirebaseAuth.instance;
  final user = auth.currentUser;

  if(user != null){
    Timer(Duration(seconds: 3),
    ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PostScreen()))
    );
  }else{
    Timer(Duration(seconds: 3),
    ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()))
    );
  }
  }
}