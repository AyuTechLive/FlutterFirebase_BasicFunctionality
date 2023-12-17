import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testappfirebase/Courses/add_course.dart';
import 'package:testappfirebase/Courses/coursecardview.dart';
import 'package:testappfirebase/Courses/coursediscription.dart';
import 'package:testappfirebase/ui/auth/login_screen.dart';
import 'package:testappfirebase/ui/firestore/add_firestoredata.dart';
import 'package:testappfirebase/ui/posts/add_post.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class AllCoursesScreen extends StatefulWidget {
  const AllCoursesScreen({super.key});

  @override
  State<AllCoursesScreen> createState() => _AllCoursesScreenState();
}

class _AllCoursesScreenState extends State<AllCoursesScreen> {
  final auth = FirebaseAuth.instance;
  final fireStore =
      FirebaseFirestore.instance.collection('All Courses').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Screen'),
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
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddCourse(),
              ));
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
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
          //             title: Text(list[index]['title']),
          //           );
          //         },
          //       );
          //     } else {
          //       return CircularProgressIndicator();
          //     }
          //   },
          // )),
          StreamBuilder<QuerySnapshot>(
            stream: fireStore,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return CircularProgressIndicator();
              if (snapshot.hasError) return Text('Some Error');
              return Expanded(
                  child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return CourseCardView(
                    courseName:
                        snapshot.data!.docs[index]['Course Name'].toString(),
                    coursePrice:
                        snapshot.data!.docs[index]['Course Price'].toString(),
                    courseImgLink: snapshot.data!.docs[index]['Course Img Link']
                        .toString(),
                    courseDiscription: snapshot
                        .data!.docs[index]['Course Discription']
                        .toString(),
                    courseRating: 4.5,
                    ontap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetails(
                        coursename: snapshot.data!.docs[index]['Course Name'].toString(),
                         courseprice: snapshot.data!.docs[index]['Course Price'].toString(),
                          courseImage: snapshot.data!.docs[index]['Course Img Link']
                        .toString(),
                           coursediscription:snapshot
                        .data!.docs[index]['Course Discription']
                        .toString(),),));
                    },
                  );
                },
              ));
            },
          ),
        ],
      ),
    );
  }
}
