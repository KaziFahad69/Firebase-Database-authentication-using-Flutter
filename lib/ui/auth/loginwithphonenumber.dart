import 'package:agunbase/ui/auth/loginscreen.dart';
import 'package:agunbase/ui/auth/verifycodescreen.dart';
import 'package:agunbase/ui/utils/utils.dart';
import 'package:agunbase/widgets/roundbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  bool loading = false;
  final auth = FirebaseAuth.instance;
  final phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Loginwith Phone",style: style(color: Colors.white,size: 20 ),),centerTitle: true,),
      body: Column(
      
        children: [
        Padding(
          padding: EdgeInsets.only(top:50, right: 20, left: 20),
          child: CustomeTextFormField(
            keyboardType: TextInputType.number,
            controller: phonecontroller, 
          hinttext: "+880 123 1231 123", icon: Icon(Icons.phone_android)),
        ),
        RoundBoutton(title: "Send verification code", loading: loading, ontap: (){
          
          setState(() {
            loading = true;
          });
          auth.verifyPhoneNumber(
            phoneNumber: phonecontroller.text,
            verificationCompleted: (_){
              setState(() {
            loading = false;
          });
            }, 
          verificationFailed: (e){
            Utils().toastMessage(e.toString());
            setState(() {
            loading = false;
          });
          }, 
          codeSent: (String varificationId, int ? token){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VerificationCodeScreen(verificicationId: varificationId,)));
          setState(() {
            loading = false;
          });
          }, 
          codeAutoRetrievalTimeout: (e){
            setState(() {
            loading = false;
          });
            Utils().toastMessage(e.toString()
            );
          });
        })
      ],),
    );
  }
}