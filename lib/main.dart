import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:testappfirebase/CourseContents/add_coursecontents_real.dart';
import 'package:testappfirebase/CourseContents/get_coursecontent_real.dart';
import 'package:testappfirebase/CourseContents/get_tablelist.dart';
import 'package:testappfirebase/CourseContents/new_subjectList.dart';
import 'package:testappfirebase/CourseContents/lecture_list.dart';
import 'package:testappfirebase/CourseContents/testfile.dart';
import 'package:testappfirebase/Courses/allcourses.dart';
import 'package:testappfirebase/PaymentGateway/razorpay_payment.dart';
import 'package:testappfirebase/Youtubevideo/youtube_video.dart';
import 'package:testappfirebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:testappfirebase/pdfviewer/pdfview.dart';
import 'package:testappfirebase/ui/auth/signupnew.dart';
import 'package:testappfirebase/ui/firestore/firestore_list_screen.dart';
import 'package:testappfirebase/ui/splash_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', 
    home: SplashScreen(),);
  }
}
// test id rzp_test_tyxaS4GuEkyx6N
// key secret 8jamZMfywIiI0OdfnRhEXmnC
