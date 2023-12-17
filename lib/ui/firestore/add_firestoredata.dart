import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testappfirebase/utils/utils.dart';
import 'package:testappfirebase/widgets/round_button.dart';
import 'package:firebase_database/firebase_database.dart';

class AddFirestoreData extends StatefulWidget {
  const AddFirestoreData({super.key});

  @override
  State<AddFirestoreData> createState() => _AddFirestoreDataState();
}

class _AddFirestoreDataState extends State<AddFirestoreData> {
  bool loading = false;
  final postcontroller = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection('Users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add FireStore Data'),
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
                String id = DateTime.now().microsecondsSinceEpoch.toString();
               //String id = 'ayushshahi96kmr@gmail.com';
                fireStore.doc(id).set(
                    {'title': postcontroller.text.toString(), 'id': id}).then(
                  (value) {
                    Utils().toastMessage('Data Added');
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
