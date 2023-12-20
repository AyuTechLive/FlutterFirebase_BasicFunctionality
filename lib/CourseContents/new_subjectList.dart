import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:testappfirebase/CourseContents/add_coursecontents_real.dart';
import 'package:testappfirebase/CourseContents/lecture_list.dart';

class ChildItem {
  final String key;
  final dynamic value;

  ChildItem(this.key, this.value);

  ChildItem.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key!,
        value = snapshot.value;

  // Add any oth
  //initer relevant methods and properties for your data model
}

class NewSubjectList extends StatelessWidget {
  final String coursename;
  final textcontroller = TextEditingController();
  late DatabaseReference _databaseReference;
  // .child('Maths')
  // .child('Videos');

  Stream<DatabaseEvent> getChildrenStream() {
    // You can also order or filter your data if necessary using _databaseReference.orderByChild('childName'), etc.
    return _databaseReference.onValue;
  }

  NewSubjectList({super.key, required this.coursename});

  @override
  
  Widget build(BuildContext context) {
    _databaseReference=FirebaseDatabase.instance.ref(coursename).child('SUBJECTS');
    return Scaffold(
      appBar: AppBar(
        title: Text('New Subject List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
          StreamBuilder(
            stream: getChildrenStream(),
            builder:
                (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                //DataSnapshot dataValues = snapshot.data!.snapshot;
                //  Map<dynamic, dynamic> values = dataValues.value as Map<dynamic, dynamic>;
                //  List<ChildItem> items = values.entries.map((e) => ChildItem(e.key, e.value)).toList();
                return Expanded(
                  child: FirebaseAnimatedList(
                    query: _databaseReference,
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      // Assuming your child nodes are maps with a 'name' field
                      final child = ChildItem.fromSnapshot(snapshot);
                      return SizeTransition(
                        sizeFactor: animation,
                        child: ListTile(
                          title: Text(child.key),
                          subtitle: Text(child.value['Video Link'].toString()),
                          trailing: InkWell(
                            child: Icon(Icons.delete),
                            onTap: () {
                              _databaseReference.child(child.key).remove();
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      LectureList(subject: child.key,coursename: coursename,),
                                ));
                          },
                          // Display the value or any child property
                        ),
                      );
                    },
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
// class ChildItem {
//   final String key;
//   final dynamic value;

//   ChildItem(this.key, this.value);

//   ChildItem.fromSnapshot(DataSnapshot snapshot)
//       : key = snapshot.key!,
//         value = snapshot.value;

//   // Add any other relevant methods and properties for your data model
// }

  
  
  