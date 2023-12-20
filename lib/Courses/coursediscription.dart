import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testappfirebase/Courses/allcourses.dart';
import 'package:testappfirebase/utils/utils.dart';
import 'package:testappfirebase/widgets/round_button.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CourseDetails extends StatefulWidget {
  final String coursename;
  final String courseprice;
  final String courseImage;
  final String coursediscription;

  const CourseDetails(
      {super.key,
      required this.coursename,
      required this.courseprice,
      required this.courseImage,
      required this.coursediscription});

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance.collection('Users').snapshots();
  final _razorpay = Razorpay();
  CollectionReference ref = FirebaseFirestore.instance.collection('Users');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    Utils().toastMessage(response.paymentId.toString());

   // ref.doc(auth.currentUser!.email.toString()).update({'UID': "1234567"});
    searchAndCreateCourse1(widget.coursename);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear(); // Removes all listeners
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.network(widget.courseImage),
          Text(widget.coursename),
          Text(widget.courseprice),
          Text(widget.courseImage),
          Text(widget.coursediscription),
          SizedBox(
            height: 50,
          ),
          RoundButton(
            title: 'Buy Now',
            onTap: () {
              var options = {
                'key': 'rzp_test_tyxaS4GuEkyx6N',
                'amount': int.parse(widget.courseprice) *
                    100, //in the smallest currency sub-unit.
                'name': widget.coursename, // Generate order_id using Orders API
                'description': widget.coursediscription,
                'timeout': 120, // in seconds
                'prefill': {
                  'contact': '9123456789',
                  'email': 'gaurav.kumar@example.com'
                }
              };
              _razorpay.open(options);
            },
          )
        ],
      ),
    );
  }

  Future<void> searchAndCreateCourse1(String coursename) async {
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
      DocumentSnapshot emailsSnapshot = await emailsDocumentRef.get();

      if (emailsSnapshot.exists) {
        Map<String, dynamic> emailsData =
            emailsSnapshot.data() as Map<String, dynamic>;

        if (emailsData.containsKey(courseFieldKey) &&
            emailsData[courseFieldKey] is List) {
          List<dynamic> courseList = emailsData[courseFieldKey];
          if (courseList[0] == 0) {
            await emailsDocumentRef.update({
              courseFieldKey: [2],
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AllCoursesScreen(),
              ),
            );
          }
        }
      }
    } catch (e) {
      // Handle any errors
      print('Error occurred: $e');
      // You might want to handle this error case or log it accordingly
      // For instance, showing an error dialog or navigating back
    }
  }
}
