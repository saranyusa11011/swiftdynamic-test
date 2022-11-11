import 'package:cloud_firestore/cloud_firestore.dart';

class StepperModel {
  String name;
  int age;
  String phone;
  String IdNumber;
  String id;
  String address;
  Timestamp createDate;

  StepperModel(
      {required this.name,
      required this.IdNumber,
      required this.id,
      required this.age,
      required this.phone,
      required this.createDate,
      required this.address});

  Map<String, dynamic> toJson() => {
        'name': name,
        'age': age,
        'IdNumber': IdNumber,
        'phone': phone,
        'createDate': createDate,
        'address': address,
        'id': id,
      };

  static StepperModel fromJson(Map<String, dynamic> json) => StepperModel(
        name: json['name'],
        age: json['age'],
        IdNumber: json['IdNumber'],
        phone: json['phone'],
        address: json['address'],
        id: json['id'],
        createDate: json['createDate'],
      );
}
