import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swift_test/model/model_stepper.dart';

class StepperProvider with ChangeNotifier {
  // final List<StepperModel> _steppermodel = [
  //
  // ];
  // List<StepperModel> get list => _steppermodel;
  //
  // void addStepper(StepperModel statement) {
  //   _steppermodel.add(statement);
  //   notifyListeners();
  // }

  Future createStepperForm(
      {required String name,
      required int age,
      required String phone,
      required String IdNumber,
      required String address,
      required Timestamp createDate}) async {
    final docStepper = FirebaseFirestore.instance.collection('stepper').doc();
    final steppermodel = StepperModel(
      name: name,
      id: docStepper.id,
      age: age,
      phone: phone,
      IdNumber: IdNumber,
      address: address,
      createDate: createDate,
    );
    final json = steppermodel.toJson();
    await docStepper.set(json);
  }

  Stream<List<StepperModel>> getSteppers() {
    try {
      final items = FirebaseFirestore.instance
          .collection('stepper')
          .orderBy("createDate", descending: false)
          .snapshots()
          .map((snapshots) => snapshots.docs
              .map((doc) => StepperModel.fromJson(doc.data()))
              .toList());
      // print('items is ${items}');

      return items;
    } catch (error) {
      throw error;
    }
  }
}
