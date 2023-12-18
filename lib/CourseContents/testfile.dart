import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testappfirebase/CourseContents/add_coursecontents_real.dart';
import 'package:testappfirebase/ui/auth/login_screen.dart';
import 'package:testappfirebase/ui/posts/add_post.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:testappfirebase/utils/utils.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Firebase List'),
        ),
        body: ChildList(),
      ),
    );
  }
}

class ChildItem {
  final String key;
  final dynamic value;

  ChildItem(this.key, this.value);

  ChildItem.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key!,
        value = snapshot.value;

  // Add any other relevant methods and properties for your data model
}

class ChildList extends StatelessWidget {
  // Assuming you've already set up your database and know the path
  final DatabaseReference _databaseReference = FirebaseDatabase.instance
      .ref('Course1')
      .child('SUBJECTS')
      .child('Business Administration')
      .child('Videos');

  Stream<DatabaseEvent> getChildrenStream() {
    // You can also order or filter your data if necessary using _databaseReference.orderByChild('childName'), etc.
    return _databaseReference.onValue;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getChildrenStream(),
      builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          //DataSnapshot dataValues = snapshot.data!.snapshot;
          //  Map<dynamic, dynamic> values = dataValues.value as Map<dynamic, dynamic>;
          //  List<ChildItem> items = values.entries.map((e) => ChildItem(e.key, e.value)).toList();
          return FirebaseAnimatedList(
            query: _databaseReference,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              // Assuming your child nodes are maps with a 'name' field
              final child = ChildItem.fromSnapshot(snapshot);
              return SizeTransition(
                sizeFactor: animation,
                child: ListTile(
                  title: Text(child.key),
                  subtitle: Text(child.value['Video Link'].toString()), // Display the value or any child property
                ),
              );
            },
          );
        }
      },
    );
  }
}
