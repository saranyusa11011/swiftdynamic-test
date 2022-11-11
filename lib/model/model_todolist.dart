import 'package:cloud_firestore/cloud_firestore.dart';

class Todolist {
  String todo;
  String? description;
  String id;
  String date;
  String status;
  String createAt;
  String img;
  Timestamp createDate;

  Todolist({
    required this.todo,
    required this.id,
    required this.status,
    this.description,
    required this.date,
    required this.createDate,
    required this.createAt,
    required this.img,
  });

  Map<String, dynamic> toJson() => {
        'todo': todo,
        'description': description,
        'createDate': createDate,
        'id': id,
        'date': date,
        'status': status,
        'createAt': createAt,
        'img': img,
      };

  static Todolist fromJson(Map<String, dynamic> json) => Todolist(
        todo: json['todo'],
        description: json['description'],
        createDate: json['createDate'],
        id: json['id'],
        date: json['date'],
        status: json['status'],
        createAt: json['createAt'],
        img: json['img'],
      );
}
