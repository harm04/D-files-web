import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color.fromARGB(255, 0, 7, 36),
      body: SafeArea(child: Center(
        child: Padding(
          padding:MediaQuery.of(context).size.width>600?EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width/2.8 ): const EdgeInsets.all(18.0),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/success.png'),
            const Text('Your file is uploaded successfully')
          ],
              ),
        ),
      )),
    );
  }
}