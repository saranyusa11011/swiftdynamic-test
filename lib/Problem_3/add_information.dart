import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:swift_test/background.dart';

import '../colors.dart';
import '../provider/provider_information.dart';
import '../widget/app_icon.dart';

class AddInformationScreen extends StatefulWidget {
  const AddInformationScreen({Key? key}) : super(key: key);

  @override
  _AddInformationScreenState createState() => _AddInformationScreenState();
}

class _AddInformationScreenState extends State<AddInformationScreen> {
  late String name = '';
  late String IdNumber = '';
  late String email = '';
  late String phone = '';
  File? _image;
  late bool post = true;
  final _picker = ImagePicker();
  final formKey = GlobalKey<FormState>();

  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<InformationProvider>(context);

    return SafeArea(
        child: Scaffold(
      body: HomepageBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 0),
                        height: 80,
                        width: 1000,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                        ),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 7),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.popUntil(context,
                                      ModalRoute.withName("/information"));
                                },
                                icon: const AppIcon(icon: Icons.arrow_back_ios),
                              ),
                            ),
                            Column(
                              children: const <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 0, top: 30),
                                  child: Text(
                                    "Add Information",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              filled: true, //<-- SEE HERE

                              fillColor: Colors.white,
                              prefixIcon: const Icon(Icons.account_circle),
                              labelText: 'Firstname-Lastname',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )),
                          onChanged: (String value) {
                            name = value;
                          },
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length != 13) {
                              return 'Please enter your ID number.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              filled: true, //<-- SEE HERE

                              fillColor: Colors.white,
                              prefixIcon: const Icon(Icons.credit_card),
                              labelText: 'ID Number',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )),
                          onChanged: (String value) {
                            IdNumber = value;
                          },
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: TextFormField(
                          validator: (val) => val!.isEmpty || !val.contains("@")
                              ? "Please enter your email correctly."
                              : null,
                          decoration: InputDecoration(
                              filled: true, //<-- SEE HERE

                              fillColor: Colors.white,
                              prefixIcon: const Icon(Icons.email),
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )),
                          onChanged: (String value) {
                            email = value;
                          },
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length != 10) {
                              return 'Please enter your Phone.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              filled: true, //<-- SEE HERE

                              fillColor: Colors.white,
                              prefixIcon: const Icon(Icons.call),
                              labelText: 'Phone',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )),
                          onChanged: (String value) {
                            phone = value;
                          },
                        ),
                      ),
                    ],
                  )),
              GestureDetector(
                onTap: _openImagePicker,
                child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: 150,
                    height: 150,
                    child: _image != null
                        ? Image.file(
                            _image!,
                          )
                        : Image.asset('assets/images/upload.jpg')),
              ),
              // Column(
              //   children: [
              //     Container(
              //       margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
              //       width: 1000,
              //       child: ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //           shape: (RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(30.0),
              //             //side: BorderSide(color: Colors.red)
              //           )),
              //
              //           padding: const EdgeInsets.all(20),
              //           primary: AppColors.mainColor, // <-- Button color
              //           onPrimary: Colors.white, // <-- Splash color
              //         ),
              //         onPressed: _openImagePicker,
              //         child: const Text('Select An Image'),
              //       ),
              //     ),
              //     Container(
              //         margin: const EdgeInsets.only(top: 20, bottom: 10),
              //         width: 120,
              //         height: 120,
              //         child: _image != null
              //             ? Image.file(
              //                 _image!,
              //               )
              //             : Container()),
              //   ],
              // ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                width: 1000,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.mainColor,

                      shape: (RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        //side: BorderSide(color: Colors.red)
                      )),

                      padding: const EdgeInsets.all(20),
                      onPrimary: Colors.white, // <-- Splash color
                    ),
                    onPressed: () async {
                      AwesomeDialog(
                          btnCancelOnPress: () {},
                          context: context,
                          dialogType: DialogType.question,
                          animType: AnimType.rightSlide,
                          title: 'Add Information?',
                          btnOkOnPress: () async {
                            final isValid = formKey.currentState!.validate();

                            if (isValid &&
                                _image != null &&
                                IdNumber.length == 13) {
                              DateTime dateTimeNow = DateTime.now(); //DateTime
                              Timestamp myTimeStamp =
                                  Timestamp.fromDate(dateTimeNow);
                              DateTime now = DateTime.now();
                              String formattedDate =
                                  DateFormat('kk:mm:ss').format(now);
                              Reference ref = FirebaseStorage.instance
                                  .ref()
                                  .child('information/$IdNumber');
                              await ref.putFile(File(_image!.path));
                              String imageUrl = await ref.getDownloadURL();
                              prov
                                  .createInformation(
                                      name: name,
                                      IdNumber: IdNumber,
                                      email: email,
                                      phone: phone,
                                      img: imageUrl,
                                      createDate: myTimeStamp)
                                  .then((value) => AwesomeDialog(
                                        btnOkOnPress: () {},
                                        context: context,
                                        dialogType: DialogType.success,
                                        animType: AnimType.rightSlide,
                                        title: 'Edit success!',
                                        // desc: 'Enjoy your meal.',
                                        autoHide: Duration(seconds: 2),
                                      ).show().then((value) =>
                                          Navigator.popUntil(
                                              context,
                                              ModalRoute.withName(
                                                  '/information'))));
                            } else {}
                          }).show();
                    },
                    child: const Text('Add')),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
