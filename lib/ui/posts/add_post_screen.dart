import 'package:agunbase/ui/utils/utils.dart';
import 'package:agunbase/widgets/roundbutton.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => AddPostScreenState();
}

class AddPostScreenState extends State<AddPostScreen> {
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  bool loading = false;
  final postcontroller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    postcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add your post",
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
          RoundBoutton(title: "Post",loading: loading, ontap: (){
            setState(() {
              loading = true;
            });
            String id = DateTime.now().millisecondsSinceEpoch.toString();
            databaseRef.child(id).set({
              'title': postcontroller.text.toString(),
              'id': id,

            }).then((value){
              Utils().toastMessage("Post Added");
              Navigator.pop(context);
              setState(() {
              loading = false;
            });
            }).onError((error, stackTrace){
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
