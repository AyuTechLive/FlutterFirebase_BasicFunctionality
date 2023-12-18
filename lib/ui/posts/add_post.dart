import 'package:flutter/material.dart';
import 'package:testappfirebase/utils/utils.dart';
import 'package:testappfirebase/widgets/round_button.dart';
import 'package:firebase_database/firebase_database.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  bool loading = false;
  final postcontroller = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: postcontroller,
              maxLines: 4,
              decoration: InputDecoration(
                  hintText: 'What Is In Your Mind?',
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 30,
            ),
            RoundButton(
              loading: loading,
              title: 'Add',
              onTap: () {
                setState(() {
                  loading = true;
                });
                // databaseRef.child('1').child('Name').child('age').set(
                //     {'id': 1, 'title': postcontroller.text.toString()}).then(
                //   (value) {
                //     Utils().toastMessage('Post Succesfully Added');
                //     setState(() {
                //       loading = false;
                //     });
                String id = DateTime.now().microsecondsSinceEpoch.toString();
                databaseRef.child(id).set(
                    {'id': id, 'title': postcontroller.text.toString()}).then(
                  (value) {
                    Utils().toastMessage('Post Succesfully Added');
                    setState(() {
                      loading = false;
                    });
                  },
                ).onError(
                  (error, stackTrace) {
                    Utils().toastMessage(error.toString());
                    setState(() {
                      loading = false;
                    });
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

  
}
