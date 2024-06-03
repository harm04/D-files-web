// import 'package:divyang_sir_web/pages/homepage.dart';
// import 'package:divyang_sir_web/pages/login.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//       options: const FirebaseOptions(
//           apiKey: "AIzaSyARpWPvefyDKFAeejh_uPV9xpqD25fyAqk",
//           authDomain: "d-file-fcc73.firebaseapp.com",
//           projectId: "d-file-fcc73",
//           storageBucket: "d-file-fcc73.appspot.com",
//           messagingSenderId: "381133429589",
//           appId: "1:381133429589:web:c9e8888be2803cda3a2ddc",
//           measurementId: "G-Q5T7698KT1"));

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData.dark(),

//       home: StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.active) {
//             if (snapshot.hasData) {
//               return const HomePage();
//             } else if (snapshot.hasError) {
//               return Center(
//                 child: Text('${snapshot.error}'),
//               );
//             }
//           }
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           return const LoginPage();
//         },
//       ),
//       // home:const HomePage(),
//     );
//   }
// }


import 'package:divyang_sir_web/pages/homepage.dart';
import 'package:divyang_sir_web/pages/login.dart';
import 'package:divyang_sir_web/pages/onBoarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyARpWPvefyDKFAeejh_uPV9xpqD25fyAqk",
          authDomain: "d-file-fcc73.firebaseapp.com",
          projectId: "d-file-fcc73",
          storageBucket: "d-file-fcc73.appspot.com",
          messagingSenderId: "381133429589",
          appId: "1:381133429589:web:c9e8888be2803cda3a2ddc",
          measurementId: "G-Q5T7698KT1"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: StreamBuilder(
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
          return const OnBoardingPage();
        },
      ),
    );
  }
}