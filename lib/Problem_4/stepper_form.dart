import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swift_test/colors.dart';

import '../provider/provider_stepper.dart';
import '../widget/app_icon.dart';

class StepperProblem4 extends StatefulWidget {
  StepperProblem4({Key? key}) : super(key: key);

  @override
  State<StepperProblem4> createState() => _StepperProblem4State();
}

class _StepperProblem4State extends State<StepperProblem4> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  final _formKey = GlobalKey<FormState>();
  late String inputName = '';
  late String inputId = '';
  late String inputPhone = '';
  late String inputAddress = '';
  TextEditingController inputAge = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0),
                height: 80,
                width: 1000,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 7),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const AppIcon(icon: Icons.arrow_back_ios),
                      ),
                    ),
                    Column(
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 0, top: 30),
                          child: Text(
                            "Stepper form",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                  ],
                ),
              ),
              SizedBox(
                height: 600,
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Expanded(
                        child: Stepper(
                          controlsBuilder:
                              (BuildContext context, ControlsDetails controls) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                _currentStep == 2
                                    ? ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: AppColors.mainColor,

                                          shape: (RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          )),

                                          padding: const EdgeInsets.all(20),
                                          onPrimary:
                                              Colors.white, // <-- Splash color
                                        ),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            int value =
                                                int.parse(inputAge.text);

                                            // StepperModel statement =
                                            //     StepperModel(
                                            //         name: inputName,
                                            //         IdNumber: inputId,
                                            //         phone: inputPhone,
                                            //         address: inputAddress,
                                            //         age: value);
                                            DateTime dateTimeNow =
                                                DateTime.now(); //DateTime
                                            Timestamp myTimeStamp =
                                                Timestamp.fromDate(dateTimeNow);
                                            var provider =
                                                Provider.of<StepperProvider>(
                                                    context,
                                                    listen: false);
                                            AwesomeDialog(
                                              btnOkOnPress: () {
                                                provider
                                                    .createStepperForm(
                                                        name: inputName,
                                                        age: value,
                                                        phone: inputPhone,
                                                        IdNumber: inputId,
                                                        address: inputAddress,
                                                        createDate: myTimeStamp)
                                                    .then((value) =>
                                                        AwesomeDialog(
                                                          context: context,
                                                          dialogType: DialogType
                                                              .success,
                                                          animType: AnimType
                                                              .rightSlide,
                                                          title: 'Success!.',
                                                          // desc: 'Enjoy your meal.',
                                                          autoHide: Duration(
                                                              seconds: 2),
                                                        ).show())
                                                    .then((value) =>
                                                        Navigator.pop(context));
                                              },
                                              btnCancelOnPress: () {},
                                              context: context,
                                              dialogType: DialogType.question,
                                              animType: AnimType.rightSlide,
                                              title:
                                                  'Would you like to submit this information?.',
                                              // desc: 'Enjoy your meal.',
                                              // autoHide: Duration(seconds: 2),
                                            ).show();
                                          } else {
                                            AwesomeDialog(
                                              btnOkOnPress: () {},
                                              context: context,
                                              dialogType: DialogType.error,
                                              animType: AnimType.rightSlide,
                                              title:
                                                  'Please fill out the information correctly.',
                                              // desc: 'Enjoy your meal.',
                                              autoHide: Duration(seconds: 2),
                                            ).show();
                                          }
                                        },

                                        // onPressed: () => context
                                        //     .read<ShoppingCart>()
                                        //     .addItem(inputName),
                                        child: const Text('CONFIRM'),
                                      )
                                    : Container(),
                                _currentStep == 2
                                    ? Container()
                                    : ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: AppColors.mainColor,

                                          shape: (RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            //side: BorderSide(color: Colors.red)
                                          )),

                                          padding: const EdgeInsets.all(20),
                                          onPrimary:
                                              Colors.white, // <-- Splash color
                                        ),
                                        onPressed: controls.onStepContinue,
                                        child: const Text('NEXT'),
                                      ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red,

                                    shape: (RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      //side: BorderSide(color: Colors.red)
                                    )),

                                    padding: const EdgeInsets.all(20),
                                    onPrimary: Colors.white, // <-- Splash color
                                  ),
                                  onPressed: controls.onStepCancel,
                                  child: const Text('BACK'),
                                ),
                              ],
                            );
                          },
                          type: stepperType,
                          physics: const ScrollPhysics(),
                          currentStep: _currentStep,
                          onStepTapped: (step) => tapped(step),
                          onStepContinue: continued,
                          onStepCancel: cancel,
                          steps: <Step>[
                            Step(
                              title: const Text('Personal information'),
                              content: Column(
                                children: <Widget>[
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your name correctly.';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.person),
                                        labelText: 'Name',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        )),
                                    onChanged: (String value) {
                                      inputName = value;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your age correctly.';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.face),
                                        labelText: 'Age',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        )),
                                    controller: inputAge,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.length != 10) {
                                        return 'Please enter your phone correctly.';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.phone),
                                        labelText: 'Phone',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        )),
                                    onChanged: (String value) {
                                      inputPhone = value;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                              isActive: _currentStep >= 0,
                              state: _currentStep >= 0
                                  ? StepState.complete
                                  : StepState.disabled,
                            ),
                            Step(
                              title: const Text('Address information'),
                              content: Column(
                                children: <Widget>[
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.length != 13) {
                                        return 'Please enter your Id correctly.';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon:
                                            const Icon(Icons.contact_mail),
                                        labelText: 'ID Card number',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        )),
                                    onChanged: (String value) {
                                      inputId = value;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your address correctly.';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.home),
                                        labelText: 'Address',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        )),
                                    onChanged: (String value) {
                                      inputAddress = value;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                              isActive: _currentStep >= 0,
                              state: _currentStep >= 1
                                  ? StepState.complete
                                  : StepState.disabled,
                            ),
                            Step(
                              title: Text('Your information'),
                              content: Container(
                                // margin: EdgeInsets.only(right: 220),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Name : $inputName",
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      "Age : ${inputAge.text}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      "Phone : $inputPhone",
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      "ID Card Number : $inputId",
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      "Address : $inputAddress",
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                              ),
                              isActive: _currentStep >= 0,
                              state: _currentStep >= 2
                                  ? StepState.complete
                                  : StepState.disabled,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
