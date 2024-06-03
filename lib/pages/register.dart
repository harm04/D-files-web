
import 'package:divyang_sir_web/auth/auth.dart';
import 'package:divyang_sir_web/pages/login.dart';
import 'package:divyang_sir_web/utils/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passwordcontroller = TextEditingController();

  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    firstnamecontroller.dispose();
    lastnamecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
            child: Container(
          height: MediaQuery.of(context).size.height,
          color: Color.fromARGB(255, 0, 7, 36),
          child: Padding(
            padding:MediaQuery.of(context).size.width>600?EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/2.8 ): const EdgeInsets.symmetric(horizontal: 20.0),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 70,
                        ),
                        Image.asset(
                          'assets/images/auth.png',
                          height: 200,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10, bottom: 20, top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextField(
                                controller: emailcontroller,
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.email),
                                  hintText: 'Enter email',
                                  label: const Text('Email'),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: passwordcontroller,
                                obscureText: true,
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.password),
                                  hintText: 'Create a password',
                                  label: const Text('Password'),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: firstnamecontroller,
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                  hintText: 'First name',
                                  label: const Text('First name'),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: lastnamecontroller,
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                  hintText: 'Last name',
                                  label: const Text('Last name'),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Already have an account?',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) {
                                            return LoginPage();
                                          }),
                                        );
                                      },
                                      child: const Text(
                                        'Login',
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 17),
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  String res =
                                      await Methods(FirebaseAuth.instance)
                                          .signUpWithEmail(
                                              email: emailcontroller.text,
                                              password: passwordcontroller.text,
                                              firstName:
                                                  firstnamecontroller.text,
                                              lastName: lastnamecontroller.text,
                                              context: context);
                                  if (res == 'success') {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    showSnackbar(
                                        'Email sent successfully', context);
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    showSnackbar(res, context);
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Center(
                                      child: Text(
                                    'Register',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
          ),
        )),
      ),
    );
  }
}
