

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divyang_sir_web/pages/email_verify.dart';


import 'package:divyang_sir_web/utils/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Methods {
  final FirebaseAuth _auth;

  Methods(this._auth);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User get user => _auth.currentUser!;

  Future<String> signUpWithEmail({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required BuildContext context,
  }) async {
    String res = 'Email has been sent to your e-mail';
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          firstName.isNotEmpty &&
          lastName.isNotEmpty) {
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await sendEmail(context);
        
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return EmailVerify(
            emailVerification: sendEmail(context),
          );
        }));

          await _firestore.collection('Users').doc(user.uid).set({
          'email': email,
          'password': password,
          'firstName': firstName,
          'lastName': lastName,
          'uid': user.uid,
        });
        res = 'success';
        
      } else {
        showSnackbar('Please enter all the fields', context);
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }


  // Future<String> uploadtoStorage(
  //   {
  //     required String fileName,required String fileType,required String fileSize,required String fileDate,required String fileUrl
  //   }
  // )async{
  //   String res ='sme error occured';
  //   try{
  //      await FirebaseFirestore.instance
  //       .collection('media')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection('abc')
  //       .doc(fileName)
  //       .set({
  //     'fileName': fileName,
  //     'fileType': fileType,
  //     'fileSize': fileSize,
  //     'fileDate': fileDate,
  //     'fileUrl': fileUrl,
  //   });
  //   res ='success';
  //   }catch(err){
  //     res=err.toString();
  //   }
  //   return res;
  // }

  // EMAIL LOGIN
  Future<String> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    String res = 'some error occured';
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = 'success';
      } else {
        showSnackbar('Please enter all the fields', context);
      }

      // if (!user.emailVerified) {
      //   showSnackbar('It\'s seems you are not registered.Please register first',
      //       context);
      // }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }


  // EMAIL VERIFICATION
  Future<void> sendEmail(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
    } catch (err) {
      showSnackbar(err.toString(), context);
    }
  }
}
