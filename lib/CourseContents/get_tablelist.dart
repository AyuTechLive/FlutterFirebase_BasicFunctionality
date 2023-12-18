import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testappfirebase/CourseContents/add_coursecontents_real.dart';
import 'package:testappfirebase/ui/auth/login_screen.dart';
import 'package:testappfirebase/ui/posts/add_post.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:testappfirebase/utils/utils.dart';

class GetTablelist extends StatefulWidget {
  const GetTablelist({super.key});

  @override
  State<GetTablelist> createState() => _GetTablelistState();
}

class _GetTablelistState extends State<GetTablelist> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance
      .ref('Course1')
      .child('SUBJECTS')
      .child('Business Administration')
      .child('Videos');
  // .child('Lec 1');
  //  .child('Title');
  final searchFiltercontroller = TextEditingController();
  final editcontroller = TextEditingController();
  List<dynamic> keys = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllUsers();
  }

  // Future<void> fetchAllUsers() async {
  //   DatabaseReference usersRef = FirebaseDatabase.instance
  //       .ref('Course1')
  //       .child('SUBJECTS')
  //       .child('Business Administration')
  //       .child('Videos');

  //   try {
  //     DatabaseEvent event = await usersRef.once();
  //     DataSnapshot snapshot = event.snapshot;

  //     if (snapshot.value != null) {
  //       Map<dynamic, dynamic>? usersMap =
  //           snapshot.value as Map<dynamic, dynamic>?;

  //       if (usersMap != null) {
  //         usersMap.forEach((key, value) {
  //           setState(() {
  //             keys = usersMap.keys
  //                 .toList(); // Populate keys list with Firebase keys
  //           });
  //           //keys.add(key);
  //           // print('User ID: $key');
  //           // if (value is Map<dynamic, dynamic>) {
  //           //   value.forEach((key, value) {
  //           //     print('$key: $value');
  //           //   });
  //           // }
  //           // print('---------------');
  //         });
  //       }
  //     } else {
  //       print('No users found');
  //     }
  //   } catch (error) {
  //     print('Error fetching users: $error');
  //   }
  // }
  Future<void> fetchAllUsers() async {
    try {
      DataSnapshot snapshot = await ref.get();

      if (snapshot.value != null) {
        Map<dynamic, dynamic>? usersMap =
            snapshot.value as Map<dynamic, dynamic>?;

        if (usersMap != null) {
          setState(() {
            keys = usersMap.keys.cast<String>().toList();
          });
        }
      } else {
        print('No users found');
      }
    } catch (error) {
      print('Error fetching users: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Get Table List'),
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then(
                  (value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                  },
                );
              },
              icon: Icon(Icons.logout_outlined))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //fetchAllUsers();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddCourseContentRealTime(),
              ));
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: searchFiltercontroller,
              decoration: InputDecoration(
                  hintText: 'Search Data', border: OutlineInputBorder()),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),

          // Expanded(
          //     child: StreamBuilder(
          //   stream: ref.onValue,
          //   builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          //     if (snapshot.hasData) {
          //       Map<dynamic, dynamic> map =
          //           snapshot.data!.snapshot.value as dynamic;
          //       List<dynamic> list = [];
          //       list.clear();
          //       list = map.values.toList();
          //       return ListView.builder(
          //         itemCount: snapshot.data!.snapshot.children.length,
          //         itemBuilder: (context, index) {
          //           return ListTile(
          //             title: Text(list[index]['Title']),
          //           );
          //         },
          //       );
          //     } else {
          //       return CircularProgressIndicator();
          //     }
          //   },
          // )),

          // Expanded(
          //   child: FirebaseAnimatedList(
          //     query: ref,
          //     itemBuilder: (context, snapshot, animation, index) {
          //       final title = snapshot.value.toString();
          //       if (searchFiltercontroller.text.isEmpty) {
          //         return ListTile(
          //           title: Text(fetchAllUsers().toString()),
          //           subtitle:
          //               Text(snapshot.child('Video Link').value.toString()),
          //         );
          //       } else if (title.toLowerCase().contains(
          //           searchFiltercontroller.text.toLowerCase().toString())) {
          //         return ListTile(
          //           title: Text(snapshot.child('Title').value.toString()),
          //         );
          //       } else {
          //         return Container();
          //       }
          //     },
          //   ),
          // ),,
          Expanded(
            child: ListView.builder(
                itemCount: keys.length, // Use the number of keys as the list item count
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(title: Text(keys[index]));
                }),
          ),
          //  Expanded(
          //   child: StreamBuilder(
          //     stream: ref.onValue,
          //     builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
          //       if (snapshot.hasData && snapshot.data != null) {
          //         Map<dynamic, dynamic>? usersMap =
          //             snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;

          //         if (usersMap != null) {
          //           List<dynamic> keys = usersMap.keys.toList();

          //           return ListView.builder(
          //             itemCount: keys.length,
          //             itemBuilder: (BuildContext context, int index) {
          //               return ListTile(title: Text(keys[index].toString()));
          //             },
          //           );
          //         } else {
          //           return Center(child: Text('No data available'));
          //         }
          //       } else {
          //         return Center(child: CircularProgressIndicator());
          //       }
          //     },
          //   ),
          // ),

          // Text(keys[0]),
        ],
      ),
    );
  }

  Future<void> showMyDialouge(String title, String id) async {
    editcontroller.text = title;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('update'),
          content: Container(
            child: TextField(
              controller: editcontroller,
              decoration: InputDecoration(hintText: 'Edit Here'),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel')),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ref
                    .child(id)
                    .update({'title': editcontroller.text.toString()}).then(
                  (value) {
                    Utils().toastMessage('Data updated succesfully');
                  },
                ).onError(
                  (error, stackTrace) {
                    Utils().toastMessage(error.toString());
                  },
                );
              },
              child: Text('Update'),
            )
          ],
        );
      },
    );
  }
}
