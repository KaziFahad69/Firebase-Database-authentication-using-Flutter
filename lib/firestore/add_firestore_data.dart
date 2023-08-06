import 'package:agunbase/ui/utils/utils.dart';
import 'package:agunbase/widgets/roundbutton.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddFirestoreData extends StatefulWidget {
  const AddFirestoreData({super.key});

  @override
  State<AddFirestoreData> createState() => _AddFirestoreDataState();
}

class _AddFirestoreDataState extends State<AddFirestoreData> {
  final fireStore = FirebaseFirestore.instance.collection('users');
  bool loading = false;
  final postcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Firestore Data",
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              
              controller: postcontroller,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Whats on your mind? ",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          RoundBoutton(title: "Add",loading: loading, ontap: (){
            setState(() {
              loading = true;
            });
            String id = DateTime.now().millisecondsSinceEpoch.toString();
            fireStore.doc(id).set({
              'title': postcontroller.text.toString(),
              'id': id,
            }).then((value) {
              Navigator.pop(context);
              Utils().toastMessage("Data added to FireStore");
              setState(() {
              loading = false;
            });
            }).onError((error, stackTrace) {
              Utils().toastMessage(error.toString());
              setState(() {
              loading = false;
            });
            });
          })
        ],
      ),
    );
  }
}