import 'package:flutter/material.dart';
import 'package:testappfirebase/ui/auth/verifycode.dart';
import 'package:testappfirebase/utils/utils.dart';
import 'package:testappfirebase/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginWithPhoneNo extends StatefulWidget {
  const LoginWithPhoneNo({super.key});

  @override
  State<LoginWithPhoneNo> createState() => _LoginWithPhoneNoState();
}

class _LoginWithPhoneNoState extends State<LoginWithPhoneNo> {
  bool loading = false;
  final auth = FirebaseAuth.instance;
  final phonenocontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: phonenocontroller,
              decoration: InputDecoration(hintText: '+917800119990'),
            ),
            SizedBox(
              height: 80,
            ),
            RoundButton(
              loading: loading,
              title: 'Login',
              onTap: () {
                setState(() {
                  loading = true;
                });
                auth.verifyPhoneNumber(
                    phoneNumber: phonenocontroller.text,
                    verificationCompleted: (_) {
                      setState(() {
                        loading = false;
                      });
                    },
                    verificationFailed: (e) {
                      setState(() {
                        loading = false;
                      });
                      Utils().toastMessage(e.toString());
                    },
                    codeSent: (String verificationId, int? token) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerifyCode(
                              verificationId: verificationId,
                            ),
                          ));
                      setState(() {
                        loading = false;
                      });
                    },
                    codeAutoRetrievalTimeout: (e) {
                      Utils().toastMessage(e.toString());
                      setState(() {
                        loading = false;
                      });
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
