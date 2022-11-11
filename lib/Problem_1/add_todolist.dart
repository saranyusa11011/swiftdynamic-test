import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:swift_test/background.dart';
import 'package:uuid/uuid.dart';

import '../colors.dart';
import '../provider/provider_todolist.dart';
import '../widget/app_icon.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  late String todo = '';
  late String description = '';
  late DateTime _myDateTime;
  File? _image;
  final _picker = ImagePicker();

  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  String date =
      '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';
  final initialTime = const TimeOfDay(hour: 0, minute: 0);
  late TimeOfDay time = const TimeOfDay(hour: -10, minute: 0);
  final formKey = GlobalKey<FormState>();
  late String hour = '?';
  late String min = '?';
  final _formKey = GlobalKey<FormState>();
  late String timetext = ' ${DateTime.now().hour}:${DateTime.now().minute}';

  @override
  void initState() {
    var hourTimetext = DateTime.now().hour.toString();
    var minTimetext = DateTime.now().minute.toString();
    if (hourTimetext.length == 1 && minTimetext.length == 1) {
      timetext = ' 0${hourTimetext}:0${minTimetext}';
    } else if (hourTimetext.length == 2 && minTimetext.length == 1) {
      timetext = ' ${hourTimetext}:0${minTimetext}';
    } else if (hourTimetext.length == 1 && minTimetext.length == 2) {
      timetext = ' 0${hourTimetext}:${minTimetext}';
    } else if (hourTimetext.length == 2 && minTimetext.length == 2) {
      timetext = ' ${hourTimetext}:${minTimetext}';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<TodolistProvider>(context);

    return SafeArea(
      child: Scaffold(
          body: Background(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0),
                height: 80,
                width: 1000,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  // borderRadius: const BorderRadius.only(
                  //     bottomLeft: Radius.circular(20),
                  //     bottomRight: Radius.circular(20))
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 7),
                      child: IconButton(
                        onPressed: () {
                          Navigator.popUntil(
                              context, ModalRoute.withName("/todolist"));
                        },
                        icon: const AppIcon(icon: Icons.arrow_back_ios),
                      ),
                    ),
                    Column(
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 0, top: 30),
                          child: Text(
                            "Add To-Do",
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
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length >= 100) {
                            return 'Please enter To do.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            filled: true, //<-- SEE HERE

                            fillColor: Colors.white,
                            prefixIcon: const Icon(Icons.sports_soccer),
                            labelText: 'To do',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            )),
                        onChanged: (String value) {
                          todo = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                      filled: true, //<-- SEE HERE

                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.description),
                      labelText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      )),
                  onChanged: (String value) {
                    description = value;
                  },
                ),
              ),
              InkWell(
                onTap: () async {
                  _myDateTime = (await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2010),
                      lastDate: DateTime(2025)))!;
                  setState(() {
                    print(_myDateTime);
                    //final now = DateTime.now();
                    // print(_myDateTime);
                    date = DateFormat('dd-MM-yyyy').format(_myDateTime);
                    print('format to $date');
                    //time = _myDateTime.toString();
                  });
                },
                child: Container(
                    width: 1000,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        color: Colors.white.withOpacity(1)),
                    padding: const EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 20),
                    margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: date == ''
                        ? const Text(
                            'SELECT DATE',
                            textAlign: TextAlign.center,
                          )
                        : Text(
                            'Date : $date',
                            textAlign: TextAlign.center,
                          )),
              ),
              InkWell(
                onTap: () async {
                  final newTime = await showTimePicker(
                      context: context, initialTime: initialTime);

                  setState(() {
                    time = newTime!;
                    hour = time.hour.toString();
                    min = time.minute.toString();
                    if (hour.length == 1 && min.length == 1) {
                      timetext = ' 0${time.hour}:0${time.minute}';
                    } else if (hour.length == 2 && min.length == 1) {
                      timetext = ' ${time.hour}:0${time.minute}';
                    } else if (hour.length == 1 && min.length == 2) {
                      timetext = ' 0${time.hour}:${time.minute}';
                    } else if (hour.length == 2 && min.length == 2) {
                      timetext = ' ${time.hour}:${time.minute}';
                    }
                  });
                },
                child: Container(
                    width: 1000,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        color: Colors.white.withOpacity(1)),
                    padding: const EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 20),
                    margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: time == const TimeOfDay(hour: -10, minute: 0)
                        ? Text(
                            'Time : $timetext',
                            textAlign: TextAlign.center,
                          )
                        : Text(
                            'Time : ${time.hour.toString()} : ${time.minute.toString()} ',
                            textAlign: TextAlign.center,
                          )),
              ),
              // Container(
              //   margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              //   width: 1000,
              //   child: ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //         shape: (RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(30.0),
              //           //side: BorderSide(color: Colors.red)
              //         )),
              //         padding: const EdgeInsets.all(20),
              //         primary: AppColors.mainColor,
              //         onPrimary: Colors.white, // <-- Splash color
              //       ),
              //       onPressed: () async {
              //         _myDateTime = (await showDatePicker(
              //             context: context,
              //             initialDate: DateTime.now(),
              //             firstDate: DateTime(2010),
              //             lastDate: DateTime(2025)))!;
              //         setState(() {
              //           //final now = DateTime.now();
              //           date = DateFormat('dd-MM-yy').format(_myDateTime);
              //           print(date);
              //           //time = _myDateTime.toString();
              //         });
              //       },
              //       child: Text("Pick a date")),
              // ),
              // Container(
              //   margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              //   width: 1000,
              //   child: ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //         shape: (RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(30.0),
              //           //side: BorderSide(color: Colors.red)
              //         )),
              //         padding: const EdgeInsets.all(20),
              //         primary: AppColors.mainColor,
              //         onPrimary: Colors.white, // <-- Splash color
              //       ),
              //       onPressed: () async {
              //         final newTime = await showTimePicker(
              //             context: context, initialTime: initialTime);
              //
              //         setState(() {
              //           time = newTime!;
              //           hour = time.hour.toString();
              //           min = time.minute.toString();
              //           if (hour.length == 1 && min.length == 1) {
              //             timetext = ' 0${time.hour}:0${time.minute}';
              //           } else if (hour.length == 2 && min.length == 1) {
              //             timetext = ' ${time.hour}:0${time.minute}';
              //           } else if (hour.length == 1 && min.length == 2) {
              //             timetext = ' 0${time.hour}:${time.minute}';
              //           } else if (hour.length == 2 && min.length == 2) {
              //             timetext = ' ${time.hour}:${time.minute}';
              //           }
              //           // print(time.hour.bitLength);
              //         });
              //       },
              //       child: const Text("choose time")),
              // ),
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
                      // var now = DateTime(_myDateTime.year, _myDateTime.month,
                      //         _myDateTime.day, time.hour, time.minute, 00)
                      //     .toUtc()
                      //     .toIso8601String();
                      // print(now.toString());
                      AwesomeDialog(
                          btnCancelOnPress: () {},
                          context: context,
                          dialogType: DialogType.question,
                          animType: AnimType.rightSlide,
                          title: 'Add To-Do?',
                          btnOkOnPress: () async {
                            if (todo.length >= 100) {
                              AwesomeDialog(
                                btnOkOnPress: () {},
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Your To do is over 100 letters.',
                                // desc: 'Enjoy your meal.',
                                autoHide: const Duration(seconds: 2),
                              ).show();
                            } else if (todo != '' &&
                                date != '' &&
                                timetext != '?' &&
                                _image != null) {
                              const uuid = Uuid();
                              DateTime dateTimeNow = DateTime.now(); //DateTime
                              Timestamp myTimeStamp =
                                  Timestamp.fromDate(dateTimeNow);

                              // img
                              DateTime nowimg = DateTime.now();
                              String formattedDate =
                                  DateFormat('kk:mm:ss').format(nowimg);
                              Reference ref = FirebaseStorage.instance
                                  .ref()
                                  .child('information/$formattedDate');
                              await ref.putFile(File(_image!.path));
                              String imageUrl = await ref.getDownloadURL();
                              // ทดสอบ date time

                              // var now = DateTime(
                              //         _myDateTime.year,
                              //         _myDateTime.month,
                              //         _myDateTime.day,
                              //         time.hour,
                              //         time.minute,
                              //         00)
                              //     .toUtc()
                              //     .toIso8601String();
                              var now =
                                  DateTime.now().toUtc().toIso8601String();
                              var timezonenow = now.toString();
                              prov
                                  .createTodo(
                                      img: imageUrl,
                                      id: uuid.v1(),
                                      date: date + timetext,
                                      createAt: timezonenow.substring(0, 19),
                                      todo: todo,
                                      description: description,
                                      createDate: myTimeStamp)
                                  .then((value) => AwesomeDialog(
                                        btnOkOnPress: () {},
                                        context: context,
                                        dialogType: DialogType.success,
                                        animType: AnimType.rightSlide,
                                        title: 'Success!',
                                        // desc: 'Enjoy your meal.',
                                        autoHide: const Duration(seconds: 2),
                                      ).show().then((value) =>
                                          Navigator.pushNamed(
                                              context, '/todolist')));
                            } else if (todo != '' &&
                                date != '' &&
                                timetext != '?' &&
                                _image == null) {
                              const uuid = Uuid();
                              DateTime dateTimeNow = DateTime.now(); //DateTime
                              Timestamp myTimeStamp =
                                  Timestamp.fromDate(dateTimeNow);

                              var now =
                                  DateTime.now().toUtc().toIso8601String();
                              var timezonenow = now.toString();
                              prov
                                  .createTodo(
                                      img: '',
                                      id: uuid.v1(),
                                      date: date + timetext,
                                      createAt: timezonenow.substring(0, 19),
                                      todo: todo,
                                      description: description,
                                      createDate: myTimeStamp)
                                  .then((value) => AwesomeDialog(
                                        btnOkOnPress: () {},
                                        context: context,
                                        dialogType: DialogType.success,
                                        animType: AnimType.rightSlide,
                                        title: 'Success!',
                                        // desc: 'Enjoy your meal.',
                                        autoHide: const Duration(seconds: 2),
                                      ).show().then((value) =>
                                          Navigator.pushNamed(
                                              context, '/todolist')));
                            } else {
                              AwesomeDialog(
                                btnOkOnPress: () {},
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title:
                                    'Please fill out the information correctly.',
                                // desc: 'Enjoy your meal.',
                                autoHide: const Duration(seconds: 2),
                              ).show();
                            }
                          }).show();
                    },
                    child: const Text('Add')),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
