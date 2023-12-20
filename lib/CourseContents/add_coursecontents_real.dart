import 'package:flutter/material.dart';
import 'package:testappfirebase/utils/utils.dart';
import 'package:testappfirebase/widgets/round_button.dart';
import 'package:firebase_database/firebase_database.dart';

class AddCourseContentRealTime extends StatefulWidget {
  const AddCourseContentRealTime({super.key});

  @override
  State<AddCourseContentRealTime> createState() =>
      _AddCourseContentRealTimeState();
}

class _AddCourseContentRealTimeState extends State<AddCourseContentRealTime> {
  bool loading = false;
  final postcontroller = TextEditingController();
  final cousenamecontroller = TextEditingController();
  final subjectcontroller = TextEditingController();
  final videotitlecontroller = TextEditingController();
  final videosubtitlecontroller = TextEditingController();
  final videourlcontroller = TextEditingController();
  final videolectureno = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.ref('Course1');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Your Course Content'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: postcontroller,
                maxLines: 1,
                decoration: InputDecoration(
                    hintText: 'Enter the course name',
                    border: OutlineInputBorder()),
              ),
              TextFormField(
                controller: subjectcontroller,
                maxLines: 1,
                decoration: InputDecoration(
                    hintText: 'Enter Your Subject', border: OutlineInputBorder()),
              ),
              TextFormField(
                controller: videolectureno,
                maxLines: 1,
                decoration: InputDecoration(
                    hintText: 'Lecture name', border: OutlineInputBorder()),
              ),
              TextFormField(
                controller: videotitlecontroller,
                maxLines: 1,
                decoration: InputDecoration(
                    hintText: 'Enter Your VideoTitle',
                    border: OutlineInputBorder()),
              ),
              TextFormField(
                controller: videosubtitlecontroller,
                maxLines: 1,
                decoration: InputDecoration(
                    hintText: 'Enter Your VideoSubtitle',
                    border: OutlineInputBorder()),
              ),
              TextFormField(
                controller: videourlcontroller,
                maxLines: 1,
                decoration: InputDecoration(
                    hintText: 'Enter Your videourl',
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
                  
                  
                 
                  String id = cousenamecontroller.text.toString();
                  databaseRef
                      .child(id)
                      .child('SUBJECTS')
                      .child(subjectcontroller.text.toString())
                     .child('Videos').child(videolectureno.text.toString()).set({
                      'id':videolectureno.text.toString(),
                      'Title':videotitlecontroller.text.toString(),
                      'Subtitle':videosubtitlecontroller.text.toString(),
                      'Video Link':videourlcontroller.text.toString()
                     }).then(
                    (value) {
                      Utils().toastMessage('Post Succesfully Added');
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
      ),
    );
  }
}
