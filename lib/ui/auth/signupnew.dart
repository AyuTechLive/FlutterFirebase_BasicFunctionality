import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testappfirebase/ui/auth/login_screen.dart';
import 'package:testappfirebase/utils/utils.dart';
import 'package:testappfirebase/widgets/round_button.dart';
import 'package:firebase_database/firebase_database.dart';

class SignUpNew extends StatefulWidget {
  const SignUpNew({super.key});

  @override
  State<SignUpNew> createState() => _SignUpNewState();
}

class _SignUpNewState extends State<SignUpNew> {
  bool loading = false;
  final _formfield = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  // final databaseref = FirebaseDatabase.instance;
  var username = '';

  FirebaseAuth _auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance.collection('Users');

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: _formfield,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailcontroller,
                      decoration: const InputDecoration(
                          hintText: 'Email',
                          //helperText: 'Enter your email',
                          prefixIcon: Icon(Icons.alternate_email)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      controller: passwordcontroller,
                      obscureText: true,
                      decoration: const InputDecoration(
                          hintText: 'Password',
                          // helperText: 'Enter your password',
                          prefixIcon: Icon(Icons.lock_clock_outlined)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Password';
                        }
                        return null;
                      },
                    ),
                  ],
                )),
            RoundButton(
              title: 'SignUp',
              loading: loading,
              onTap: () {
                if (_formfield.currentState!.validate()) {
                  setState(() {
                    loading = true;
                  });

                  _auth
                      .createUserWithEmailAndPassword(
                    email: emailcontroller.text.toString(),
                    password: passwordcontroller.text.toString(),
                  )
                      .then((value) {
                    String id = emailcontroller.text.toString();
                    fireStore.doc(id).set({
                      'Email':emailcontroller.text.toString(),
                      'Password':passwordcontroller.text.toString(),
                      'UID':DateTime.now().microsecondsSinceEpoch.toString(),
                      'My Courses':['Course1','Course2','Course3']
                    }).then((value) {
                      setState(() {
                      loading = false;
                    });
                    },);

                   
                  }).onError(
                    (error, stackTrace) {
                      Utils().toastMessage(error.toString());
                      setState(() {
                        loading = false;
                      });
                    },
                  );
                }
              },
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already Have An Account?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ));
                    },
                    child: Text('Login'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
