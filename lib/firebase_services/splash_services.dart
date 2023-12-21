import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:testappfirebase/Courses/add_course.dart';
import 'package:testappfirebase/Courses/allcourses.dart';
import 'package:testappfirebase/ui/auth/login_screen.dart';
import 'package:testappfirebase/ui/firestore/firestore_list_screen.dart';
import 'package:testappfirebase/ui/posts/post_screen.dart';
import 'package:testappfirebase/ui/upload_image.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;
    if (user != null) {
      Timer(
        const Duration(seconds: 3),
        () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UploadImage(),
            )),
      );
    } else {
      Timer(
        const Duration(seconds: 5),
        () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            )),
      );
    }
  }
}
