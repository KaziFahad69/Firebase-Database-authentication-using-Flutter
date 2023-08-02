import 'package:agunbase/homepage.dart';
import 'package:agunbase/ui/auth/loginscreen.dart';
import 'package:agunbase/ui/utils/utils.dart';
import 'package:agunbase/widgets/roundbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  void signUp(){
    if (_formKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    _auth.createUserWithEmailAndPassword(
                      email: _emailcontroller.text.toString(), 
                      password: _passwordcontroller.text.toString()).then((value){
                        setState(() {
                      loading = false;
                    });
                      }).onError((error, stackTrace){
                        Utils().toastMessage(error.toString());
                        setState(() {
                      loading = false;
                    });
                      });
                   //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));
                  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("SignUP",style: TextStyle(color: Colors.white),),centerTitle: true,
          //automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomeTextFormField(
                        keyboardType: TextInputType.emailAddress,
                          controller: _emailcontroller,
                          hinttext: "Email",
                          icon: Icon(Icons.email_outlined),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            // use a regular expression to check if the email contains @ and a domain name
                            RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                            if (!emailRegex.hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          }
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomeTextFormField(
                        keyboardType: TextInputType.text,
                          iconsuffix: Icon(Icons.visibility_off),
                          controller: _passwordcontroller,
                          hinttext: "Password",
                          icon: Icon(Icons.lock_open),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            // use a regular expression to check if the password has at least 6 characters
                            RegExp passwordRegex = RegExp(r'^.{6,}$');
                            if (!passwordRegex.hasMatch(value)) {
                              return 'Please enter a password with at least 6 characters';
                            }
                            return null;
                          }
                      )

                    ],
                  )),
              SizedBox(
                height: 30,
              ),
              RoundBoutton(
                title: "Signup",
                loading: loading,
                ontap: () {
                   signUp();
                },
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? "),
                  TextButton(onPressed:(){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
                  },
                  child: Text("Login ")),
                ],
              )
            ],
          ),
        ));
  }
}
