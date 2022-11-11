import 'package:flutter/material.dart';
import 'package:swift_test/background.dart';
import 'package:swift_test/colors.dart';
import 'package:swift_test/widget/app_icon.dart';
import 'package:swift_test/widget/datail_box.dart';

import '../model/model_information.dart';
import 'edit_information.dart';

class DetailInformation extends StatefulWidget {
  DetailInformation({Key? key, required this.data}) : super(key: key);
  Information data;
  @override
  _DetailInformationState createState() => _DetailInformationState();
}

class _DetailInformationState extends State<DetailInformation> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: HomepageBackground(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0),
              height: 80,
              width: 1000,
              decoration: BoxDecoration(
                // color: Colors.orange.withOpacity(0.7),
                color: AppColors.mainColor,
                // borderRadius: const BorderRadius.only(
                //     bottomLeft: Radius.circular(20),
                //     bottomRight: Radius.circular(20))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 7),
                    child: IconButton(
                      onPressed: () {
                        Navigator.popUntil(
                            context, ModalRoute.withName("/information"));
                      },
                      icon: const AppIcon(icon: Icons.arrow_back_ios),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 0, top: 30),
                        child: Text(
                          "${widget.data.name}'s Information",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              // fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditInformation(data: widget.data)),
                        );
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: CircleAvatar(
                radius: 100.0,
                backgroundImage: NetworkImage(widget.data.img),
                backgroundColor: Colors.transparent,
              ),
            ),
            DetailBox(type: 'Name', text: widget.data.name),
            DetailBox(type: 'IdNumber', text: widget.data.IdNumber),
            DetailBox(type: 'Email', text: widget.data.email),
            DetailBox(type: 'Phone', text: widget.data.phone),
          ],
        ),
      ),
    ));
  }
}
