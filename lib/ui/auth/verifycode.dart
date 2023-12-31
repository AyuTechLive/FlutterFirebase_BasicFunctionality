import 'package:flutter/material.dart';
import 'package:testappfirebase/ui/posts/post_screen.dart';
import 'package:testappfirebase/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testappfirebase/widgets/round_button.dart';

class VerifyCode extends StatefulWidget {
  final String verificationId;
  const VerifyCode({super.key, required this.verificationId});

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  bool loading = false;
  final auth = FirebaseAuth.instance;
  final verifyCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify'),
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
              controller: verifyCodeController,
              decoration: InputDecoration(hintText: '6 Digit Code'),
            ),
            SizedBox(
              height: 80,
            ),
            RoundButton(
                loading: loading,
                title: 'Verify',
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  final credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: verifyCodeController.text.toString());
                  try {
                    await auth.signInWithCredential(credential);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostScreen(),
                        ));
                  } catch (e) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage(e.toString());
                  }
                })
          ],
        ),
      ),
    );
  }
}
