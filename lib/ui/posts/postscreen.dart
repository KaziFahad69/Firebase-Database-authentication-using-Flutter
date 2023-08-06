import 'package:agunbase/ui/auth/loginscreen.dart';
import 'package:agunbase/ui/posts/add_post_screen.dart';
import 'package:agunbase/ui/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  FocusNode _focusNode = FocusNode();
  final searchfilterController = TextEditingController();
  final ref = FirebaseDatabase.instance.ref('Post');
  final auth = FirebaseAuth.instance;
  final editcontroller = TextEditingController();


@override
void initState() {
  super.initState();
  _focusNode.addListener(() {
    if (_focusNode.hasFocus) {
      // When the TextFormField gains focus, show the cursor.
      SystemChannels.textInput.invokeMethod('TextInput.show');
    } else {
      // When the TextFormField loses focus, hide the cursor.
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }
  });
}



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
        title: Text('Posts'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddPostScreen()));
        },
        child: Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                focusNode: _focusNode,
                controller: searchfilterController,
                
                decoration: InputDecoration(
                    hintText: "Search", border: OutlineInputBorder()),
                onChanged: (String value) {
                  setState(() {});
                },
              ),
            ),
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
              child: FirebaseAnimatedList(
                  query: ref,
                  defaultChild: Text("Data is loading MyBoy"),
                  itemBuilder: (context, snapshot, animation, index) {
                    final title = snapshot.child("title").value.toString();
                    if (searchfilterController.text.isEmpty) {
                      return ListTile(
                        title: Text(snapshot.child("title").value.toString()),
                        subtitle: Text(snapshot.child("id").value.toString()),
                        trailing: PopupMenuButton(
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                      value: 1,
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.pop(context);
                                          showMyDialog(
                                              title,
                                              snapshot
                                                  .child("id")
                                                  .value
                                                  .toString());
                                        },
                                        title: Text("Edit"),
                                        leading: Icon(Icons.edit),
                                      )),
                                  PopupMenuItem(
                                    onTap: (){
                                      //Navigator.pop(context);
                                      ref.child(snapshot.child("id").value.toString()).remove();
                                    },
                                      value: 2,
                                      child: ListTile(
                                        title: Text("Delete"),
                                        leading: Icon(Icons.delete_outlined),
                                      ))
                                ]),
                      );
                    } else if (title.toLowerCase().contains(
                        searchfilterController.text.toLowerCase().toString())) {
                      return ListTile(
                        title: Text(snapshot.child("title").value.toString()),
                        subtitle: Text(snapshot.child("id").value.toString()),
                      );
                    } else {
                      return Container();
                    }
                  }),
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
                ref.child(id).update({
                  'title' : editcontroller.text.toLowerCase(),
                }).then((value) {
                  Utils().toastMessage("Title Updated");
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              child: Text("Update"),
            )
          ],
        );
      },
    );
  }
}
