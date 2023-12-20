import 'package:flutter/material.dart';
import 'package:testappfirebase/firebase_services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashScreen = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff7455F7),
        body: Center(
          child: Container(
          child: Image.network('https://firebasestorage.googleapis.com/v0/b/fir-d8752.appspot.com/o/intro%20pg%20vector%201.png?alt=media&token=2a0b5868-2f82-4729-8fc4-798f4e28443a'),
          ),
        )
        );
  }
}
