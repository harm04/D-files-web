
import 'package:divyang_sir_web/auth/auth.dart';
import 'package:divyang_sir_web/pages/homepage.dart';
import 'package:divyang_sir_web/pages/register.dart';
import 'package:divyang_sir_web/utils/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passwordcontroller = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
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
                        SizedBox(
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
                              Row(
                                children: [
                                  const Text(
                                    'Dont\'t have an account?',
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
                                            return RegisterPage();
                                          }),
                                        );
                                      },
                                      child: const Text(
                                        'Register',
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
                                          .loginWithEmail(
                                              email: emailcontroller.text,
                                              password: passwordcontroller.text,
                                              context: context);
                                  if (res == 'success') {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    showSnackbar('Login success', context);
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                      return HomePage();
                                    }));
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    showSnackbar(res, context);
                                  }
                                  // String res =await  AuthMethods().login(email: emailcontroller.text, password: passwordcontroller.text);
                                  //   if(res=='success'){

                                  //     setState(() {
                                  //       isLoading=false;
                                  //     });
                                  //     showSnackbar('Login success', context);
                                  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomePage(),),);
                                  // } else {

                                  //   setState(() {
                                  //     isLoading=false;
                                  //   });
                                  //   showSnackbar(res, context);
                                  // }
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Center(
                                      child: Text(
                                    'Login',
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
