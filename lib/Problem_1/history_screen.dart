import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swift_test/background.dart';
import 'package:swift_test/provider/provider_todo_history.dart';

import '../colors.dart';
import '../model/model_todolist.dart';
import '../provider/provider_todolist.dart';
import '../widget/app_icon.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<TodolistProvider>(context);
    final provHistory = Provider.of<TodolistHistoryProvider>(context);
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.white.withOpacity(0.9),
        body: Background(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0),
                height: 80,
                width: 1000,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 7),
                      child: IconButton(
                        onPressed: () {
                          Navigator.popUntil(
                              context, ModalRoute.withName("/todolist"));
                        },
                        icon: const AppIcon(icon: Icons.arrow_back_ios),
                      ),
                    ),
                    Column(
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 0, top: 30),
                          child: Text(
                            "History",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                // fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              StreamBuilder<List<Todolist>>(
                stream: provHistory.getTodosHistory(),
                builder: (
                  context,
                  snapshot,
                ) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong.');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                        margin: const EdgeInsets.only(top: 200),
                        child: const CircularProgressIndicator());
                  }
                  final data = snapshot.requireData;

                  return Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        Timestamp t = data[index].createDate;
                        DateTime d = t.toDate();
                        var dateText = d.toString();
                        return Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(
                                    index != 0
                                        ? data[index].date.substring(0, 10) ==
                                                data[index - 1]
                                                    .date
                                                    .substring(0, 10)
                                            ? ""
                                            : "${data[index].date.substring(0, 10)}"
                                        : "${data[index].date.substring(0, 10)}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                )
                              ],
                            ),
                            ListTile(
                              // trailing: Column(
                              //   // mainAxisSize: MainAxisSize.min,
                              //   children: [
                              //     GestureDetector(
                              //       onTap: () {
                              //         AwesomeDialog(
                              //           btnOkOnPress: () async {
                              //             await provHistory
                              //                 .createTodoHistory(
                              //                     createAt:
                              //                         data[index].createAt,
                              //                     todo: data[index].todo,
                              //                     date: data[index].date,
                              //                     description:
                              //                         data[index].description,
                              //                     createDate:
                              //                         data[index].createDate)
                              //                 .then((value) =>
                              //                     prov.deleteTodos(
                              //                         id: data[index].id))
                              //                 .then((value) => AwesomeDialog(
                              //                       btnOkOnPress: () {},
                              //                       context: context,
                              //                       dialogType:
                              //                           DialogType.success,
                              //                       animType:
                              //                           AnimType.rightSlide,
                              //                       title:
                              //                           'You success the ${data[index].todo}!',
                              //                       // desc: 'Enjoy your meal.',
                              //                       autoHide:
                              //                           Duration(seconds: 2),
                              //                     ).show());
                              //           },
                              //           btnCancelOnPress: () {},
                              //           context: context,
                              //           dialogType: DialogType.question,
                              //           animType: AnimType.rightSlide,
                              //           title:
                              //               'You success the ${data[index].todo}, right?',
                              //           // desc: 'Enjoy your meal.',
                              //           autoHide: Duration(seconds: 2),
                              //         ).show();
                              //       },
                              //       child: Icon(
                              //         Icons.check,
                              //         color: Colors.green,
                              //       ),
                              //     ),
                              //     GestureDetector(
                              //       onTap: () {
                              //         AwesomeDialog(
                              //           btnOkOnPress: () {
                              //             prov.deleteTodos(
                              //                 id: data[index].id);
                              //           },
                              //           btnCancelOnPress: () {},
                              //           context: context,
                              //           dialogType: DialogType.question,
                              //           animType: AnimType.rightSlide,
                              //           title:
                              //               'You want to delete the ${data[index].todo}, right?',
                              //           // desc: 'Enjoy your meal.',
                              //           autoHide: Duration(seconds: 2),
                              //         ).show();
                              //       },
                              //       child: Icon(
                              //         Icons.delete,
                              //         color: Colors.red,
                              //       ),
                              //     )
                              //   ],
                              // ),
                              title: Column(
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  bottomLeft:
                                                      Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20)),
                                              color: Colors.white),
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 10,
                                                bottom: 10),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        '${data[index].status}',
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      RichText(
                                                        text: TextSpan(
                                                          // Note: Styles for TextSpans must be explicitly defined.
                                                          // Child text spans will inherit styles from parent
                                                          style:
                                                              const TextStyle(
                                                            // fontSize: 14.0,
                                                            color: Colors.black,
                                                          ),
                                                          children: <TextSpan>[
                                                            const TextSpan(
                                                                text: 'Todo :',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            TextSpan(
                                                              text:
                                                                  '${data[index].todo}',
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      data[index].description ==
                                                              ''
                                                          ? Row()
                                                          : RichText(
                                                              text: TextSpan(
                                                                // Note: Styles for TextSpans must be explicitly defined.
                                                                // Child text spans will inherit styles from parent
                                                                style:
                                                                    const TextStyle(
                                                                  // fontSize:
                                                                  //     17.0,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                children: <
                                                                    TextSpan>[
                                                                  const TextSpan(
                                                                      text:
                                                                          'Description :',
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                  TextSpan(
                                                                    text:
                                                                        '${data[index].description}',
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                      RichText(
                                                        text: TextSpan(
                                                          style:
                                                              const TextStyle(
                                                            // fontSize: 14.0,
                                                            color: Colors.black,
                                                          ),
                                                          children: <TextSpan>[
                                                            const TextSpan(
                                                                text: 'Time :',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            TextSpan(
                                                              text:
                                                                  ' ${data[index].date.substring(11, 16)}',
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                snapshot.data?[index].img != ''
                                                    ? Container(
                                                        width: 80,
                                                        height: 80,
                                                        decoration: BoxDecoration(
                                                            borderRadius: const BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                bottomLeft:
                                                                    Radius.circular(
                                                                        20),
                                                                topRight:
                                                                    Radius.circular(
                                                                        20),
                                                                bottomRight:
                                                                    Radius.circular(
                                                                        20)),
                                                            color:
                                                                Colors.white38,
                                                            image: DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: NetworkImage(
                                                                    '${snapshot.data?[index].img}'))),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
