import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:swift_test/model/model_information.dart';

class InformationProvider with ChangeNotifier {
  Future createInformation(
      {required String name,
      required String IdNumber,
      required String email,
      required String phone,
      required String img,
      required Timestamp createDate}) async {
    final docTodo = FirebaseFirestore.instance.collection('information').doc();
    final informationmodel = Information(
      name: name,
      IdNumber: IdNumber,
      id: docTodo.id,
      email: email,
      phone: phone,
      img: img,
      createDate: createDate,
    );
    final json = informationmodel.toJson();
    await docTodo.set(json);
  }

  Future updateInformation(
      {required String name,
      required String IdNumber,
      required String email,
      required String phone,
      required String img,
      required String id,
      required Timestamp createDate}) async {
    final docTodo =
        FirebaseFirestore.instance.collection('information').doc(id);
    final informationmodel = Information(
      name: name,
      IdNumber: IdNumber,
      id: docTodo.id,
      email: email,
      phone: phone,
      img: img,
      createDate: createDate,
    );
    final json = informationmodel.toJson();
    await docTodo.update(json);
  }

  Stream<List<Information>> getInformations() {
    try {
      final items = FirebaseFirestore.instance
          .collection('information')
          .orderBy("name", descending: false)
          .snapshots()
          .map((snapshots) => snapshots.docs
              .map((doc) => Information.fromJson(doc.data()))
              .toList());
      // print('items is ${items}');

      return items;
    } catch (error) {
      throw error;
    }
  }

  Future deleteInformation({
    required String id,
  }) async {
    final docTodo =
        FirebaseFirestore.instance.collection('information').doc(id).delete();
  }
}
