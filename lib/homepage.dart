import 'package:flutter/material.dart';
import 'package:swift_test/background.dart';

import 'colors.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: HomepageBackground(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Column(
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 0, top: 30),
                        child: Text(
                          "Swift dynamic",
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
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              // alignment: Alignment.bottomCenter,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    padding: EdgeInsets.all(10),
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/todolist');
                      },
                      title: Text('Todolist'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      leading: Icon(Icons.fact_check),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    padding: EdgeInsets.all(10),
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/calculator');
                      },
                      title: Text('Calculator'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      leading: Icon(Icons.calculate),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    padding: EdgeInsets.all(10),
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/information');
                      },
                      title: Text('Information'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      leading: Icon(Icons.badge),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    padding: EdgeInsets.all(10),
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/stepper');
                      },
                      title: Text('Stepper form'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      leading: Icon(Icons.format_list_numbered),
                    ),
                  ),
                ],
              ),
            ),
            // Spacer(),
            // Column(
            //   children: const [
            //     Text("Name : Saranyu Saprom"),
            //     Text("Email : Saranyusa@kkumail.com"),
            //     Text("Phone : 061-939-3334")
            //   ],
            // )
          ],
        ),
      ),
    ));
  }
}
