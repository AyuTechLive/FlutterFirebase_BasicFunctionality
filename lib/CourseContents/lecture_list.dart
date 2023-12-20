import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:testappfirebase/CourseContents/add_coursecontents_real.dart';
import 'package:testappfirebase/CourseContents/lecturevideoplayer.dart';

class ChildItem {
  final String key;
  final dynamic value;

  ChildItem(this.key, this.value);

  ChildItem.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key!,
        value = snapshot.value;

  // Add any other relevant methods and properties for your data model
}

class LectureList extends StatelessWidget {
  final String subject;
  final textcontroller = TextEditingController();
  late DatabaseReference _databaseReference;
  // .child('Maths')
  // .child('Videos');

  Stream<DatabaseEvent> getChildrenStream() {
    // You can also order or filter your data if necessary using _databaseReference.orderByChild('childName'), etc.
    return _databaseReference.onValue;
  }

  LectureList({Key? key, required this.subject}) : super(key: key) {
    _databaseReference = FirebaseDatabase.instance
        .ref('Course1')
        .child('SUBJECTS')
        .child(subject)
        .child('Videos');
    // Initialize _databaseReference in the constructor
  }

  //LectureList({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lecture List'),
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
          Text(subject),
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
                          trailing: InkWell(child: Icon(Icons.delete),
                          onTap: () {
                             _databaseReference .child(
                                          snapshot.child('id').value.toString())
                                      .remove();
                          },),
                          
                          onTap: () {
                            Navigator.push(
                              context,MaterialPageRoute(builder: (context) => LectureVideoPlayer(
                                videoURL: child.value['Video Link'].toString(), 
                                videoTitle: child.value['Title'].toString(),
                                 videoSubtitle: child.value['Subtitle'].toString()),)
                            );
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

  
  
  