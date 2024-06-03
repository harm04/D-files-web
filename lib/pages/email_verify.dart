import 'dart:async';

import 'package:divyang_sir_web/pages/homepage.dart';
import 'package:divyang_sir_web/pages/login.dart';
import 'package:divyang_sir_web/utils/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerify extends StatefulWidget {
  final emailVerification;
  const EmailVerify({super.key, required this.emailVerification});

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

bool isEmailVerified = false;
bool isLoading = false;
Timer? timer;

class _EmailVerifyState extends State<EmailVerify> {
  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      FirebaseAuth.instance.currentUser!.sendEmailVerification();
      timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkEmailVerified());
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return const HomePage();
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return const LoginPage();
            },
          )
        :isLoading?Center(child: CircularProgressIndicator(),): Scaffold(
            backgroundColor: const Color.fromARGB(255, 0, 7, 36),
            body: Padding(
              padding:MediaQuery.of(context).size.width>600?EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/2.8 ): const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Image.asset('assets/images/email_verify.png'),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                      'Email verification link has been send on your email id.Please check your mail'),
                  const SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await FirebaseAuth.instance.currentUser!
                          .sendEmailVerification();
                      setState(() {
                        isLoading = false;
                      });
                      showSnackbar('Email send', context);
                    },
                    child: SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.file_copy),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Send verification e-mail again",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
