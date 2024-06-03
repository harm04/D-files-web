import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divyang_sir_web/pages/login.dart';
// import 'package:divyang_sir_web/pages/register.dart';
// import 'package:divyang_sir_web/pages/success.dart';
// import 'package:divyang_sir_web/utils/snackbar.dart';

// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   TextEditingController documentTypecontroller = TextEditingController();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   _HomePageState() {
//     selectedName = fileName[0];
//   }

//   bool isEmailVerified = false;
//   bool isLoading = false;
//   Timer? timer;
//   String percentTransfer = "";

//   @override
//   void initState() {
//     super.initState();
//     isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
//     if (!isEmailVerified) {
//       FirebaseAuth.instance.currentUser!.sendEmailVerification();
//       timer = Timer.periodic(
//           const Duration(seconds: 3), (_) => checkEmailVerified());
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     timer?.cancel();
//     documentTypecontroller.dispose();
//   }

//   Future checkEmailVerified() async {
//     await FirebaseAuth.instance.currentUser!.reload();
//     setState(() {
//       isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
//     });
//     if (isEmailVerified) {
//       timer?.cancel();
//     }
//   }

//   Uint8List? _selectedFileBytes;
//   String? _fileName;
//   String? _fileType;
//   DateTime? _fileDate;
//   int? _fileSize;

//   // Function to select a file
//   Future<void> pickFile() async {
//     setState(() {
//       isLoading = true;
//     });
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//     setState(() {
//       isLoading = false;
//     });

//     if (result != null) {
//       setState(() {
//         _selectedFileBytes = result.files.single.bytes;
//         _fileName = result.files.single.name;
//         _fileType = result.files.single.extension ?? 'unknown';
//         _fileDate = DateTime.now();
//         _fileSize = result.files.single.size;
//       });
//     } else {
//       showSnackbar('File picking canceled', context);
//     }
//   }

//   // Function to upload the selected file to Firebase Storage
//   Future<String> uploadFile(String documentTypecontroller) async {
//     String res = 'some error occured';
//     setState(() {
//       isLoading = true;
//     });
//     if (_selectedFileBytes == null || _fileName == null) {
//       setState(() {
//         isLoading = false;
//       });
//       showSnackbar('No file selected', context);
//       return res;
//     }

//     try {
//       FirebaseStorage storage = FirebaseStorage.instance;
//       Reference ref = storage
//           .ref()
//           .child('media/${FirebaseAuth.instance.currentUser!.uid}/$_fileName');

//       UploadTask uploadTask = ref.putData(_selectedFileBytes!);

//       TaskSnapshot snapshot = await uploadTask;
//       String fileUrl = await snapshot.ref.getDownloadURL();

//       if (_fileType == 'pdf' || _fileType == 'doc' || _fileType == 'docx') {
//         await _firestore
//             .collection("media")
//             .doc(_auth.currentUser!.uid)
//             .collection('docs')
//             .doc(_fileName)
//             .set({
//           'fileName': _fileName,
//           'fileType': _fileType,
//           'fileSize': _fileSize,
//           'date': _fileDate,
//           'fileUrl': fileUrl,
//           'documentType': documentTypecontroller.toString(),
//         });
//       } else if (_fileType == 'jpg' ||
//           _fileType == 'jpeg' ||
//           _fileType == 'svg' ||
//           _fileType == 'png') {
//         await _firestore
//             .collection("media")
//             .doc(_auth.currentUser!.uid)
//             .collection('images')
//             .doc(_fileName)
//             .set({
//           'fileName': _fileName,
//           'fileType': _fileType,
//           'fileSize': _fileSize,
//           'date': _fileDate,
//           'fileUrl': fileUrl,
//           'documentType': documentTypecontroller.toString(),
//         });
//       } else {
//         await _firestore
//             .collection("media")
//             .doc(_auth.currentUser!.uid)
//             .collection('others')
//             .doc(_fileName)
//             .set({
//           'fileName': _fileName,
//           'fileType': _fileType,
//           'fileSize': _fileSize,
//           'date': _fileDate,
//           'fileUrl': fileUrl,
//           'documentType': documentTypecontroller.toString(),
//         });
//       }

//       setState(() {
//         isLoading = false;
//       });

     

//       res = 'success';
//     } catch (err) {
//       showSnackbar('Error uploading file: $err', context);
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//     return res;
//   }

//   final fileName = [
//     "Select file name",
//     "Aadhar card",
//     "Voter id",
//     "Driving license",
//     "Passport",
//     "Pan card",
//     "Rashan card",
//     "Other"
//   ];
//   String? selectedName = "";

//   @override
//   Widget build(BuildContext context) {
//     return isEmailVerified
//         ? StreamBuilder(
//             stream: FirebaseAuth.instance.authStateChanges(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.active) {
//                 if (snapshot.hasData) {
//                   return isLoading
//                       ? const Center(child: CircularProgressIndicator())
//                       : Scaffold(
//                           backgroundColor: const Color.fromARGB(255, 0, 7, 36),
//                           body: SingleChildScrollView(
//                             child: SafeArea(
//                                 child: Padding(
//                               padding: MediaQuery.of(context).size.width > 600
//                                   ? EdgeInsets.symmetric(
//                                       horizontal:
//                                           MediaQuery.of(context).size.width /
//                                               2.8)
//                                   : const EdgeInsets.all(18.0),
//                               child: Expanded(
//                                 child: Column(
//                                   children: [
//                                     const SizedBox(
//                                       height: 30,
//                                     ),
//                                     Image.asset('assets/images/filesPic.png'),
//                                     const Text(
//                                       'Upload your files to Divyang Sir\'s database.\nIt\'s 100% safe and secure, with no data sharing.',
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     const SizedBox(
//                                       height: 20,
//                                     ),
//                                     selectedName == "Other"
//                                         ? TextFormField(
//                                             controller: documentTypecontroller,
//                                             decoration: const InputDecoration(
//                                                 hintText:
//                                                     "Enter the type of  document",
//                                                 border: OutlineInputBorder()),
//                                           )
//                                         : DropdownButtonFormField(
//                                             decoration: const InputDecoration(
//                                                 labelText: "File name",
//                                                 border: OutlineInputBorder()),
//                                             icon: const Icon(
//                                               Icons.arrow_drop_down,
//                                               color: Colors.blue,
//                                             ),
//                                             dropdownColor: const Color.fromARGB(
//                                                 255, 38, 44, 49),
//                                             value: selectedName,
//                                             items: fileName
//                                                 .map((item) => DropdownMenuItem(
//                                                       value: item,
//                                                       child: Text(item),
//                                                     ))
//                                                 .toList(),
//                                             onChanged: (val) {
//                                               setState(() {
//                                                 selectedName = val as String;
//                                                 selectedName == "Other"
//                                                     ? documentTypecontroller
//                                                         .text = ""
//                                                     : documentTypecontroller
//                                                         .text = val;
//                                               });
//                                             },
//                                           ),
//                                     const SizedBox(
//                                       height: 20,
//                                     ),
//                                     _selectedFileBytes == null
//                                         ? const SizedBox()
//                                         : _fileType == "png" ||
//                                                 _fileType == "jpg" ||
//                                                 _fileType == "jpeg"
//                                             ? Column(
//                                                 children: [
//                                                   Image.memory(
//                                                     _selectedFileBytes!,
//                                                     height: 200,
//                                                     width: 200,
//                                                   ),
//                                                   Text(_fileName.toString()),
//                                                   Text(
//                                                       'Size : ${(_fileSize! / (1024 * 1024)).toStringAsFixed(2)} MB')
//                                                 ],
//                                               )
//                                             : const Icon(
//                                                 Icons.insert_drive_file,
//                                                 size: 100),
//                                     GestureDetector(
//                                       onTap: () {
//                                         if (documentTypecontroller.text == "" ||
//                                             documentTypecontroller.text ==
//                                                 "Select file name") {
//                                           showSnackbar(
//                                               'Please enter document type',
//                                               context);
//                                         } else {
//                                           pickFile();
//                                         }
//                                       },
//                                       child: SizedBox(
//                                         height: 60,
//                                         width:
//                                             MediaQuery.of(context).size.width,
//                                         child: const Center(
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               Icon(Icons.file_copy),
//                                               SizedBox(
//                                                 width: 5,
//                                               ),
//                                               Text(
//                                                 "Select file",
//                                                 style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize: 18),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     _selectedFileBytes != null
//                                         ? GestureDetector(
//                                             onTap: () async {
//                                               String res = await uploadFile(
//                                                   documentTypecontroller.text);

//                                               if (res == 'success') {
//                                                 setState(() {
//                                                   isLoading = false;
//                                                 });
//                                                 Navigator.push(context,
//                                                     MaterialPageRoute(
//                                                         builder: (context) {
//                                                   return const SuccessPage();
//                                                 }));
//                                                 showSnackbar(
//                                                     'File uploaded successfiully',
//                                                     context);
//                                               } else {
//                                                 setState(() {
//                                                   isLoading = false;
//                                                 });
//                                                 showSnackbar(res, context);
//                                               }
//                                             },
//                                             child: SizedBox(
//                                               height: 60,
//                                               width: MediaQuery.of(context)
//                                                   .size
//                                                   .width,
//                                               child: const Card(
//                                                 color: Colors.blue,
//                                                 child: Center(
//                                                   child: Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .center,
//                                                     children: [
//                                                       Icon(Icons.upload),
//                                                       SizedBox(
//                                                         width: 5,
//                                                       ),
//                                                       Text(
//                                                         "Upload file",
//                                                         style: TextStyle(
//                                                             color: Colors.white,
//                                                             fontSize: 18),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           )
//                                         : const SizedBox(),
//                                   ],
//                                 ),
//                               ),
//                             )),
//                           ),
//                         );
//                 } else if (snapshot.hasError) {
//                   return Center(
//                     child: Text('${snapshot.error}'),
//                   );
//                 }
//               }
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//               return const LoginPage();
//             },
//           )
//         : isLoading
//             ? const Center(
//                 child: CircularProgressIndicator(),
//               )
//             : Scaffold(
//                 backgroundColor: const Color.fromARGB(255, 0, 7, 36),
//                 body: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const SizedBox(
//                       height: 40,
//                     ),
//                     const Text(
//                         'You have not verified your email.Please check your span e-mail box'),
//                     const SizedBox(
//                       height: 40,
//                     ),
//                     GestureDetector(
//                       onTap: () async {
//                         setState(() {
//                           isLoading = true;
//                         });
//                         await FirebaseAuth.instance.currentUser!
//                             .sendEmailVerification();
//                         setState(() {
//                           isLoading = false;
//                         });
//                         showSnackbar('Email send', context);
//                       },
//                       child: SizedBox(
//                         height: 60,
//                         width: MediaQuery.of(context).size.width,
//                         child: const Center(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(Icons.file_copy),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Text(
//                                 "Send verification e-mail again",
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 18),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pushReplacement(context,
//                             MaterialPageRoute(builder: (context) {
//                           return const RegisterPage();
//                         }));
//                       },
//                       child: SizedBox(
//                         height: 60,
//                         width: MediaQuery.of(context).size.width,
//                         child: const Center(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(Icons.arrow_back),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Text(
//                                 "Return to registration page",
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 18),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//   }
// }


// select and upload file from mobile app....for admin
// https://www.youtube.com/watch?v=dmZ9Tg9k13U&t=657s
//   UploadTask? task;
//   File? file;
//   Future selectFile() async {
//     final result = await FilePicker.platform
//         .pickFiles(allowMultiple: false, allowCompression: true);
//     if (result == null) return;
//     final path = result.files.single.path!;
//     setState(() {
//       file = File(path);
//     });
//   }






import 'package:divyang_sir_web/pages/register.dart';
import 'package:divyang_sir_web/pages/success.dart';
import 'package:divyang_sir_web/utils/snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController documentTypecontroller = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  _HomePageState() {
    selectedName = fileName[0];
  }

  bool isEmailVerified = false;
  bool isLoading = false;
  Timer? timer;
  String percentTransfer = "";

  @override
  void initState() {
    super.initState();
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      isEmailVerified = currentUser.emailVerified;
      if (!isEmailVerified) {
        currentUser.sendEmailVerification();
        timer = Timer.periodic(
          const Duration(seconds: 3), 
          (_) => checkEmailVerified()
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    documentTypecontroller.dispose();
  }

  Future checkEmailVerified() async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      await currentUser.reload();
      setState(() {
        isEmailVerified = currentUser.emailVerified;
      });
      if (isEmailVerified) {
        timer?.cancel();
      }
    }
  }

  Uint8List? _selectedFileBytes;
  String? _fileName;
  String? _fileType;
  DateTime? _fileDate;
  int? _fileSize;

  // Function to select a file
  Future<void> pickFile() async {
    setState(() {
      isLoading = true;
    });
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      setState(() {
        isLoading = false;
      });

      if (result != null) {
        setState(() {
          _selectedFileBytes = result.files.single.bytes;
          _fileName = result.files.single.name;
          _fileType = result.files.single.extension ?? 'unknown';
          _fileDate = DateTime.now();
          _fileSize = result.files.single.size;
        });
      } else {
        showSnackbar('File picking canceled', context);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnackbar('Error picking file: $e', context);
    }
  }

  // Function to upload the selected file to Firebase Storage
  Future<String> uploadFile(String documentTypecontroller) async {
    String res = 'some error occurred';
    setState(() {
      isLoading = true;
    });

    if (_selectedFileBytes == null || _fileName == null) {
      setState(() {
        isLoading = false;
      });
      showSnackbar('No file selected', context);
      return res;
    }

    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        setState(() {
          isLoading = false;
        });
        showSnackbar('No user logged in', context);
        return res;
      }
      
      Reference ref = storage
          .ref()
          .child('media/${currentUser.uid}/$_fileName');

      UploadTask uploadTask = ref.putData(_selectedFileBytes!);

      TaskSnapshot snapshot = await uploadTask;
      String fileUrl = await snapshot.ref.getDownloadURL();

      final docData = {
        'fileName': _fileName,
        'fileType': _fileType,
        'fileSize': _fileSize,
        'date': _fileDate,
        'fileUrl': fileUrl,
        'documentType': documentTypecontroller,
      };

      final userDoc = _firestore
          .collection("media")
          .doc(currentUser.uid);

      if (_fileType == 'pdf' || _fileType == 'doc' || _fileType == 'docx') {
        await userDoc.collection('docs').doc(_fileName).set(docData);
      } else if (_fileType == 'jpg' ||
                 _fileType == 'jpeg' ||
                 _fileType == 'svg' ||
                 _fileType == 'png') {
        await userDoc.collection('images').doc(_fileName).set(docData);
      } else {
        await userDoc.collection('others').doc(_fileName).set(docData);
      }

      res = 'success';
    } catch (err) {
      showSnackbar('Error uploading file: $err', context);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
    return res;
  }

  final fileName = [
    "Select file name",
    "Aadhar card",
    "Voter id",
    "Driving license",
    "Passport",
    "Pan card",
    "Rashan card",
    "Other"
  ];
  String? selectedName = "";

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? StreamBuilder<User?>(
            stream: _auth.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Scaffold(
                          backgroundColor: const Color.fromARGB(255, 0, 7, 36),
                          body: SingleChildScrollView(
                            child: SafeArea(
                                child: Padding(
                              padding: MediaQuery.of(context).size.width > 600
                                  ? EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width /
                                              2.8)
                                  : const EdgeInsets.all(18.0),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Image.asset('assets/images/filesPic.png'),
                                  const Text(
                                    'Upload your files to Divyang Sir\'s database.\nIt\'s 100% safe and secure, with no data sharing.',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  selectedName == "Other"
                                      ? TextFormField(
                                          controller: documentTypecontroller,
                                          decoration: const InputDecoration(
                                              hintText:
                                                  "Enter the type of document",
                                              border: OutlineInputBorder()),
                                        )
                                      : DropdownButtonFormField(
                                          decoration: const InputDecoration(
                                              labelText: "File name",
                                              border: OutlineInputBorder()),
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.blue,
                                          ),
                                          dropdownColor: const Color.fromARGB(
                                              255, 38, 44, 49),
                                          value: selectedName,
                                          items: fileName
                                              .map((item) => DropdownMenuItem(
                                                    value: item,
                                                    child: Text(item),
                                                  ))
                                              .toList(),
                                          onChanged: (val) {
                                            setState(() {
                                              selectedName = val as String;
                                              selectedName == "Other"
                                                  ? documentTypecontroller
                                                      .text = ""
                                                  : documentTypecontroller
                                                      .text = val;
                                            });
                                          },
                                        ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  _selectedFileBytes == null
                                      ? const SizedBox()
                                      : _fileType == "png" ||
                                              _fileType == "jpg" ||
                                              _fileType == "jpeg"
                                          ? Column(
                                              children: [
                                                Image.memory(
                                                  _selectedFileBytes!,
                                                  height: 200,
                                                  width: 200,
                                                ),
                                                Text(_fileName.toString()),
                                                Text(
                                                    'Size : ${(_fileSize! / (1024 * 1024)).toStringAsFixed(2)} MB')
                                              ],
                                            )
                                          : const Icon(
                                              Icons.insert_drive_file,
                                              size: 100),
                                  GestureDetector(
                                    onTap: () {
                                      if (documentTypecontroller.text == "" ||
                                          documentTypecontroller.text ==
                                              "Select file name") {
                                        showSnackbar(
                                            'Please enter document type',
                                            context);
                                      } else {
                                        pickFile();
                                      }
                                    },
                                    child: SizedBox(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width,
                                      child: const Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.file_copy),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Select file",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  _selectedFileBytes != null
                                      ? GestureDetector(
                                          onTap: () async {
                                            String res = await uploadFile(
                                                documentTypecontroller.text);

                                            if (res == 'success') {
                                              setState(() {
                                                isLoading = false;
                                              });
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return const SuccessPage();
                                              }));
                                              showSnackbar(
                                                  'File uploaded successfully',
                                                  context);
                                            } else {
                                              setState(() {
                                                isLoading = false;
                                              });
                                              showSnackbar(res, context);
                                            }
                                          },
                                          child: SizedBox(
                                            height: 60,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: const Card(
                                              color: Colors.blue,
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.upload),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "Upload file",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            )),
                          ),
                        );
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
        : isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                backgroundColor: const Color.fromARGB(255, 0, 7, 36),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                        'You have not verified your email. Please check your spam e-mail box'),
                    const SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        final currentUser = _auth.currentUser;
                        if (currentUser != null) {
                          await currentUser.sendEmailVerification();
                        }
                        setState(() {
                          isLoading = false;
                        });
                        showSnackbar('Email sent', context);
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const RegisterPage();
                        }));
                      },
                      child: SizedBox(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_back),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Return to registration page",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
  }
}