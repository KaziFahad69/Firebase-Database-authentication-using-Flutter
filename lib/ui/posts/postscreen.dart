import 'package:agunbase/ui/auth/loginscreen.dart';
import 'package:agunbase/ui/posts/add_post_screen.dart';
import 'package:agunbase/ui/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: (){
          auth.signOut().then((value){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
          }).onError((error, stackTrace) {
            Utils().toastMessage(error.toString());
          });
        }, icon: Icon(Icons.logout_outlined))],
        automaticallyImplyLeading: false,
        title: Text('Posts'), centerTitle: true,backgroundColor: Colors.blue,),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddPostScreen()));
        }, child: Icon(Icons.add),),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(" Posts Page ")
        ],
      ),),
    );
  }
}