import 'package:cloud_firestore/cloud_firestore.dart';

class Information {
  String name;
  String IdNumber;
  String id;
  String email;
  String phone;
  String img;
  Timestamp createDate;

  Information({
    required this.name,
    required this.IdNumber,
    required this.id,
    required this.email,
    required this.phone,
    required this.img,
    required this.createDate,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'IdNumber': IdNumber,
        'id': id,
        'email': email,
        'phone': phone,
        'img': img,
        'createDate': createDate,
      };

  static Information fromJson(Map<String, dynamic> json) => Information(
        name: json['name'],
        IdNumber: json['IdNumber'],
        id: json['id'],
        email: json['email'],
        phone: json['phone'],
        img: json['img'],
        createDate: json['createDate'],
      );
}
