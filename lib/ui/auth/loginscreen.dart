import 'package:agunbase/homepage.dart';
import 'package:agunbase/ui/auth/signup_screen.dart';
import 'package:agunbase/widgets/roundbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text("Login",style: TextStyle(color: Colors.white),),centerTitle: true,
            automaticallyImplyLeading: false,
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
                  title: "Login",
                  ontap: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));
                    }
                  },
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? "),
                    TextButton(onPressed:(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignupScreen()));
                    },
                    child: Text("Sign up ")),
                  ],
                )
              ],
            ),
          )),
    );
  }
}

class CustomeTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hinttext;
  final Icon icon;
  final Icon? iconsuffix;
  final String? Function(String?)? validator;
  final TextInputType ? keyboardType;

  CustomeTextFormField(
      {this.iconsuffix,
        this.keyboardType,
        this.validator,
      required this.controller,
      required this.hinttext,
      required this.icon});

  @override
  _CustomeTextFormFieldState createState() => _CustomeTextFormFieldState();
}

class _CustomeTextFormFieldState extends State<CustomeTextFormField> {
  bool _obscureText = false;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hinttext,
        prefixIcon: widget.icon,
        suffixIcon: widget.iconsuffix != null
            ? IconButton(
                icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility),
                onPressed: _toggleObscureText,
              )
            : null, // only show the suffix icon if it is not null
      ),
      validator: widget.validator,
      keyboardType: widget.keyboardType,
    );
  }
}

// class CustomeTextFormField extends StatelessWidget {
//   bool obsecure;
//   final TextEditingController controller;
//   final String hinttext;
//   final Icon icon;
//   final Icon? iconsuffix;
//   CustomeTextFormField(
//       {this.iconsuffix,
//       required this.obsecure,
//       required this.controller,
//       required this.hinttext,
//       required this.icon});
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       obscureText: obsecure,
//       controller: controller,
//       decoration: InputDecoration(
//         hintText: hinttext,
//         prefixIcon: icon,
//         suffixIcon: obsecure ? iconsuffix : null
//       ),
//     );
//   }
// }
