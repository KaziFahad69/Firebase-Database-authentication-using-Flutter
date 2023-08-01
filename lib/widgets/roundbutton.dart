import 'package:flutter/material.dart';
class RoundBoutton extends StatelessWidget {

  final String title;
  final VoidCallback ontap;

  const RoundBoutton({Key?key, required this.title, required this.ontap}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.all(20),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration( borderRadius: BorderRadius.circular(20),
        color: Colors.deepPurple,

        ),
        child: Center(child: Text(title, style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),), ),
      ),
    );
  }
}
