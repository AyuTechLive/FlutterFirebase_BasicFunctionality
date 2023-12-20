import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testappfirebase/Courses/add_coursecontents_afteraddcourse.dart';
import 'package:testappfirebase/utils/utils.dart';
import 'package:testappfirebase/widgets/round_button.dart';
import 'package:firebase_database/firebase_database.dart';

class AddCourse extends StatefulWidget {
  const AddCourse({super.key});

  @override
  State<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  bool loading = false;
  final coursediscriptioncontroller = TextEditingController();
  final coursenamecontroller = TextEditingController();
  final coursepricecontroller = TextEditingController();
  final courseimglinkcontroller = TextEditingController();

  final fireStore = FirebaseFirestore.instance.collection('All Courses');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Courses Data'),
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
                controller: coursenamecontroller,
                maxLines: 1,
                decoration: InputDecoration(
                    hintText: 'Course Name', border: OutlineInputBorder()),
              ),
              TextFormField(
                controller: coursediscriptioncontroller,
                maxLines: 4,
                decoration: InputDecoration(
                    hintText: 'Add The Course Discription',
                    border: OutlineInputBorder()),
              ),
              TextFormField(
                controller: coursepricecontroller,
                maxLines: 1,
                decoration: InputDecoration(
                    hintText: 'Course Price', border: OutlineInputBorder()),
              ),
              TextFormField(
                controller: courseimglinkcontroller,
                maxLines: 4,
                decoration: InputDecoration(
                    hintText: 'Course Banner Img Link',
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 30,
              ),
              RoundButton(
                loading: loading,
                title: 'Next',
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  String id = coursenamecontroller.text.toString();
                  //String id = 'ayushshahi96kmr@gmail.com';
                  fireStore.doc(id).set({
                    'Course Name': coursenamecontroller.text.toString(),
                    'Course Discription':
                        coursediscriptioncontroller.text.toString(),
                    'Course Price': coursepricecontroller.text,
                    'Course Img Link': courseimglinkcontroller.text.toString()
                  }).then(
                    (value) {
                      Utils().toastMessage('Course Created Successfully Now Add the course contents');
                      setState(() {
                        loading = false;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AddCourseContentAfterAddingCourse(
                                    coursename:
                                        coursenamecontroller.text.toString()),
                          ));
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
      ),
    );
  }
}
