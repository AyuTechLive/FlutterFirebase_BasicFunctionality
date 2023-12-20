import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testappfirebase/CourseContents/new_subjectList.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                  return  SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return CourseCardView(
                      courseName:
                          snapshot.data!.docs[index]['Course Name'].toString(),
                      coursePrice:
                          snapshot.data!.docs[index]['Course Price'].toString(),
                      courseImgLink: snapshot
                          .data!.docs[index]['Course Img Link']
                          .toString(),
                      courseDiscription: snapshot
                          .data!.docs[index]['Course Discription']
                          .toString(),
                      courseRating: 4.5,
                      ontap: () {
                        searchAndCreateCourse1(
                          snapshot.data!.docs[index]['Course Name'].toString(),
                          snapshot.data!.docs[index]['Course Price'].toString(),
                          snapshot.data!.docs[index]['Course Img Link']
                              .toString(),
                          snapshot.data!.docs[index]['Course Discription']
                              .toString(),
                        );
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => CourseDetails(
                        //         coursename: snapshot
                        //             .data!.docs[index]['Course Name']
                        //             .toString(),
                        //         courseprice: snapshot
                        //             .data!.docs[index]['Course Price']
                        //             .toString(),
                        //         courseImage: snapshot
                        //             .data!.docs[index]['Course Img Link']
                        //             .toString(),
                        //         coursediscription: snapshot
                        //             .data!.docs[index]['Course Discription']
                        //             .toString(),
                        //       ),
                        //     ));
                      },
                    );
                  },
                ),
              ));
            },
          ),
        ],
      ),
    );
  }

  Future<void> searchAndCreateCourse1(String coursename, String courseprice,
      String courseimg, String coursediscription) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String usersCollectionPath = 'Users'; // The collection name
    String userEmailsDocumentId =
        auth.currentUser!.email.toString(); // The document name
    String courseFieldKey =
        coursename; // The field key for the course data within the emails document

    // Reference to the emails document in the users collection
    DocumentReference emailsDocumentRef =
        firestore.collection(usersCollectionPath).doc(userEmailsDocumentId);

    try {
      // Get the current snapshot of the emails document
      DocumentSnapshot emailsSnapshot = await emailsDocumentRef.get();

      if (emailsSnapshot.exists) {
        Map<String, dynamic> emailsData =
            emailsSnapshot.data() as Map<String, dynamic>;

        // Check if the courseFieldKey already exists and is a list
        if (emailsData.containsKey(courseFieldKey) &&
            emailsData[courseFieldKey] is List) {
          // CourseFieldKey exists and is a list, print its values
          List<dynamic> courseList = emailsData[courseFieldKey];
          // if (courseList[0] == 0) {
          //   await emailsDocumentRef.update({
          //     courseFieldKey: [1],
          //   });
          // }
          if (courseList[0] == 2) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewSubjectList(coursename: coursename),
                ));
          }
          print(
              'Course data exists and contains the following values: $courseList');
        } else {
          // CourseFieldKey does not exist as a list, add it as an empty list
          await emailsDocumentRef.set(
              {
                courseFieldKey: [0],

                // Initialize with a list containing the value 0
              },
              SetOptions(
                  merge:
                      true)); // Using merge to update the document without overwriting other fields
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CourseDetails(
                    coursename: coursename,
                    courseprice: courseprice,
                    courseImage: courseimg,
                    coursediscription: coursediscription),
              ));

          print('Course data field created and set to initial value.');
        }
      } else {
        // The emails document does not exist, so create it with the course data as an empty list
        await emailsDocumentRef.set({
          courseFieldKey: [0], // Initialize with a list containing the value 0
        });
        print('Document with course data created.');
      }
    } catch (e) {
      // Handle any errors
      print('Error occurred: $e');
    }
  }
}
