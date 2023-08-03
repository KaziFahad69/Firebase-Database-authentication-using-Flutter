import 'package:agunbase/ui/auth/loginscreen.dart';
import 'package:agunbase/ui/posts/postscreen.dart';
import 'package:agunbase/ui/utils/utils.dart';
import 'package:agunbase/widgets/roundbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerificationCodeScreen extends StatefulWidget {
  final String verificicationId;
  const VerificationCodeScreen({ required this.verificicationId, super.key});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
 bool loading = false;
  final auth = FirebaseAuth.instance;
  final verificationCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verify Code",style: style(color: Colors.white,size: 20 ),),centerTitle: true,),
      body: Column(
      
        children: [
        Padding(
          padding: EdgeInsets.only(top:50, right: 20, left: 20),
          child: CustomeTextFormField(
            //keyboardType: TextInputType.number,
            controller: verificationCodeController, 
          hinttext: "6 digit code", icon: Icon(Icons.phone_android)),
        ),
        RoundBoutton(title: "Verify", loading: loading, ontap: () async{
          setState(() {
            loading = true;
          });
          final credential = PhoneAuthProvider.credential(
            verificationId: widget.verificicationId, 
            smsCode: verificationCodeController.text.toString());
            try{
              await auth.signInWithCredential(credential);
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PostScreen()));
              setState(() {
            loading = false;
          });
            }catch(e){
              print("Error paisi verify e "+"${e}");
              setState(() {
            loading = false;
            Utils().toastMessage(e.toString());
          });
            }
        })
      ],),
    );
  }
}