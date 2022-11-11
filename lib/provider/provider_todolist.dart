import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/model_todolist.dart';

class TodolistProvider with ChangeNotifier {
  Future createTodo(
      {required String id,
      required String todo,
      required String createAt,
      required String date,
      String? description,
      required String img,
      required Timestamp createDate}) async {
    final docTodo = FirebaseFirestore.instance.collection('todolist').doc(id);
    final todolistmodel = Todolist(
      img: img,
      createAt: createAt,
      status: 'IN PROGRESS',
      date: date,
      id: id,
      todo: todo,
      description: description,
      createDate: createDate,
    );
    final json = todolistmodel.toJson();
    await docTodo.set(json);
  }

  Stream<List<Todolist>> getTodos(String text) {
    try {
      final items = FirebaseFirestore.instance
          .collection('todolist')
          .orderBy(text, descending: false)
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

  Future deleteTodos({
    required String id,
  }) async {
    final docTodo =
        FirebaseFirestore.instance.collection('todolist').doc(id).delete();
  }

  Future updateTodo(
      {required String id,
      required String todo,
      required String createAt,
      required String date,
      String? description,
      required String img,
      required Timestamp createDate}) async {
    final docTodo = FirebaseFirestore.instance.collection('todolist').doc(id);
    final todolistmodel = Todolist(
      img: img,
      createAt: createAt,
      status: 'IN PROGRESS',
      date: date,
      id: id,
      todo: todo,
      description: description,
      createDate: createDate,
    );
    final json = todolistmodel.toJson();
    await docTodo.update(json);
  }

  // Stream<List<Search>> getSearch(String textSearch) {
  //   try {
  //     final items = FirebaseFirestore.instance
  //         .collection('search')
  //         .orderBy('createDate', descending: false)
  //         // .where('search', isEqualTo: textSearch)
  //         .snapshots()
  //         .map((snapshots) => snapshots.docs
  //             .map((doc) => Search.fromJson(doc.data()))
  //             .toList());
  //     // print('items is ${items}');
  //
  //     return items;
  //   } catch (error) {
  //     throw error;
  //   }
  // }

  // Future createSearch(
  //     {required String search, required Timestamp createDate}) async {
  //   final docSearch = FirebaseFirestore.instance.collection('search').doc();
  //   final Searchmodel = Search(
  //     search: search,
  //     createDate: createDate,
  //     id: docSearch.id,
  //   );
  //   final json = Searchmodel.toJson();
  //   await docSearch.set(json);
  // }

  Stream<List<Todolist>> getTodosFromSearch(String text) {
    try {
      final items = FirebaseFirestore.instance
          .collection('todolist')
          .where('todo', isEqualTo: text)
          // .where('description', isEqualTo: text)
          // .orderBy(text, descending: false)
          .snapshots()
          .map((snapshots) => snapshots.docs
              .map((doc) => Todolist.fromJson(doc.data()))
              .toList());
      // print('items is ${items.length.toString()}');

      return items;
    } catch (error) {
      throw error;
    }
  }
}
