import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:testappfirebase/PaymentGateway/razorpay_payment.dart';
import 'package:testappfirebase/Youtubevideo/youtube_video.dart';
import 'package:testappfirebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:testappfirebase/ui/auth/signupnew.dart';
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
