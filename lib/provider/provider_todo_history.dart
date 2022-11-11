import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/model_todolist.dart';

class TodolistHistoryProvider with ChangeNotifier {
  Future createTodoHistory(
      {required String todo,
      required String date,
      required String createAt,
      required String img,
      String? description,
      required Timestamp createDate}) async {
    final docTodo = FirebaseFirestore.instance.collection('history').doc();
    final todolistmodel = Todolist(
      createAt: createAt,
      img: img,
      status: 'COMPLETE',
      date: date,
      id: docTodo.id,
      todo: todo,
      description: description,
      createDate: createDate,
    );
    final json = todolistmodel.toJson();
    await docTodo.set(json);
  }

  Stream<List<Todolist>> getTodosHistory() {
    try {
      final items = FirebaseFirestore.instance
          .collection('history')
          .orderBy("date", descending: true)
          .snapshots()
          .map((snapshots) => snapshots.docs
              .map((doc) => Todolist.fromJson(doc.data()))
              .toList());
      // print('items is ${items}');

      return items;
    } catch (error) {
      throw error;
    }
  }
}
