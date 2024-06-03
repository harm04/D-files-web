
import 'package:divyang_sir_web/pages/login.dart';
import 'package:divyang_sir_web/pages/register.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
           width: MediaQuery.of(context).size.width,
          child: Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
          ),
        ),
         SafeArea(
            child: Padding(
          padding:MediaQuery.of(context).size.width>600?EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/2.8 ): const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                   SizedBox(
                    height: 50,
                    width: 110,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                          return const RegisterPage();
                        }));
                      },
                      child: const Card(
                        color: Colors.green,
                        child: Center(
                            child: const Text(
                          'Register',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 50,
                    width: 110,
                    child: GestureDetector(
                      onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                          return const LoginPage();
                        }));
                      },
                      child: const Card(
                        color: Colors.green,
                        child: Center(
                            child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const SizedBox(
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Send your files to Divyang sir more securely',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 45,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Safe || Secure || Easy',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    )
                  ],
                ),
              )
            ],
          ),
        ))
      ],
    ));
  }
}
