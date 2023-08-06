import 'package:agunbase/firestore/add_firestore_data.dart';
import 'package:agunbase/ui/auth/loginscreen.dart';
import 'package:agunbase/ui/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirestoreListScreen extends StatefulWidget {
  const FirestoreListScreen({super.key});

  @override
  State<FirestoreListScreen> createState() => _FirestoreListScreenState();
}

class _FirestoreListScreenState extends State<FirestoreListScreen> {
    
  
  final auth = FirebaseAuth.instance;
  final editcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              icon: Icon(Icons.logout_outlined))
        ],
        automaticallyImplyLeading: false,
        title: Text('Firestore'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddFirestoreData()));
        },
        child: Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
//Using stream builder (Good Practice)
            /*Expanded(child: StreamBuilder(
            stream: ref.onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent>snapshot){
            if(!snapshot.hasData){
              return CircularProgressIndicator();
            }else{
              Map <dynamic, dynamic> map = snapshot.data!.snapshot.value as dynamic;
              List<dynamic> list = [];
              list.clear();
              list = map.values.toList();
              return ListView.builder(
              itemCount: snapshot.data!.snapshot.children.length,
              itemBuilder: (context, index){
              return ListTile(
                title: Text(list[index]['title']),
                subtitle: Text(list[index]['id']),
              );
            });
            }
          })),*/

//Using firebaseAminatedList
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index){
                return ListTile(
                  title:Text("something"),
                );
              })
            )
          ],
        ),
      ),
    );
  }

  Future<void> showMyDialog(String title, String id) async {
    editcontroller.text = title;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update"),
          content: Container(
            child: TextField(
              controller: editcontroller,
              decoration: InputDecoration(hintText: "Edit"),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Update"),
            )
          ],
        );
      },
    );
  }
}