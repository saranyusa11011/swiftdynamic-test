import 'package:flutter/material.dart';

class DetailBox extends StatelessWidget {
  String text;
  String type;

  DetailBox({Key? key, required this.text, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      width: 600,
      height: 60,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 14),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Text(
        '$type : $text',
        textAlign: TextAlign.start,
        style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
      ),
    );
  }
}
