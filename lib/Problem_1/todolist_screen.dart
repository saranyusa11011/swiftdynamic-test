import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:swift_test/Problem_1/edit_todo.dart';
import 'package:swift_test/background.dart';
import 'package:swift_test/colors.dart';
import 'package:swift_test/provider/provider_todo_history.dart';

import '../model/model_todolist.dart';
import '../provider/provider_todolist.dart';
import '../widget/app_icon.dart';

class TodolistScreen extends StatefulWidget {
  const TodolistScreen({Key? key}) : super(key: key);

  @override
  _TodolistScreenState createState() => _TodolistScreenState();
}

class _TodolistScreenState extends State<TodolistScreen> {
  late bool sortbyTitle = false;
  late bool sortbyDate = false;
  late bool sortbyStatus = false;
  late bool sortbyTodo = false;
  late String sort = 'date';
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<TodolistProvider>(context);
    final provHistory = Provider.of<TodolistHistoryProvider>(context);

    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.blueGrey[100],
        body: Background(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0),
                height: 120,
                width: 1000,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  // borderRadius: const BorderRadius.only(
                  //     bottomLeft: Radius.circular(20),
                  //     bottomRight: Radius.circular(20))
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 15, bottom: 7),
                          child: IconButton(
                            onPressed: () {
                              Navigator.popUntil(
                                  context, ModalRoute.withName("/"));
                            },
                            icon: const AppIcon(icon: Icons.arrow_back_ios),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 0, top: 15),
                          child: Text(
                            "To do list",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                // fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/todolist/history');
                            },
                            icon: const Icon(
                              Icons.history,
                              color: Colors.white,
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Text('SORT BY :', style: TextStyle(color: Colors.white)),
                        sortbyTodo == false
                            ? TextButton(
                                child: const Text(
                                  'Time To-Do',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  setState(() {
                                    sort = 'date';
                                    sortbyTitle = false;
                                    sortbyTodo = true;
                                    sortbyDate = false;
                                    sortbyStatus = false;
                                  });
                                },
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: sortbyTodo == true
                                      ? Colors.red[200]
                                      : AppColors.mainColor,

                                  shape: (RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    //side: BorderSide(color: Colors.red)
                                  )),

                                  padding: const EdgeInsets.all(13),
                                  onPrimary: Colors.white, // <-- Splash color
                                ),
                                onPressed: () {
                                  setState(() {
                                    sort = 'date';
                                    sortbyTitle = false;
                                    sortbyTodo = true;
                                    sortbyDate = false;
                                    sortbyStatus = false;
                                  });
                                },
                                child: const Text('Time To-Do')),
                        sortbyTitle == false
                            ? TextButton(
                                child: const Text(
                                  'Title',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  setState(() {
                                    sort = 'todo';

                                    sortbyTitle = true;
                                    sortbyDate = false;
                                    sortbyStatus = false;
                                    sortbyTodo = false;
                                  });
                                },
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: sortbyTitle == true
                                      ? Colors.red[200]
                                      : AppColors.mainColor,

                                  shape: (RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    //side: BorderSide(color: Colors.red)
                                  )),

                                  padding: const EdgeInsets.all(13),
                                  onPrimary: Colors.white, // <-- Splash color
                                ),
                                onPressed: () {
                                  setState(() {
                                    sort = 'todo';

                                    sortbyTitle = true;
                                    sortbyDate = false;
                                    sortbyStatus = false;
                                    sortbyTodo = false;
                                  });
                                },
                                child: const Text('Title')),
                        sortbyDate == false
                            ? TextButton(
                                child: const Text(
                                  'Create task',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  setState(() {
                                    sort = 'createAt';

                                    sortbyTitle = false;
                                    sortbyDate = true;
                                    sortbyStatus = false;
                                    sortbyTodo = false;
                                  });
                                },
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: sortbyDate == true
                                      ? Colors.red[200]
                                      : AppColors.mainColor,

                                  shape: (RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    //side: BorderSide(color: Colors.red)
                                  )),

                                  padding: const EdgeInsets.all(13),
                                  onPrimary: Colors.white, // <-- Splash color
                                ),
                                onPressed: () {
                                  setState(() {
                                    sort = 'createAt';

                                    sortbyTitle = false;
                                    sortbyDate = true;
                                    sortbyStatus = false;
                                    sortbyTodo = false;
                                  });
                                },
                                child: const Text('Create task')),
                        sortbyStatus == false
                            ? TextButton(
                                child: const Text(
                                  'Status',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  setState(() {
                                    sort = 'status';

                                    sortbyTitle = false;
                                    sortbyDate = false;
                                    sortbyStatus = true;
                                    sortbyTodo = false;
                                  });
                                },
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: sortbyStatus == true
                                      ? Colors.red[200]
                                      : AppColors.mainColor,

                                  shape: (RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    //side: BorderSide(color: Colors.red)
                                  )),

                                  padding: const EdgeInsets.all(13),
                                  onPrimary: Colors.white, // <-- Splash color
                                ),
                                onPressed: () {
                                  setState(() {
                                    sort = 'status';

                                    sortbyTitle = false;
                                    sortbyDate = false;
                                    sortbyStatus = true;
                                    sortbyTodo = false;
                                  });
                                },
                                child: const Text('Status')),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              StreamBuilder<List<Todolist>>(
                stream: prov.getTodos(sort),
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
                        // Timestamp t = data[index].createDate;
                        // DateTime d = t.toDate();
                        // var dateText = d.toString();
                        // DateTime dateTimeNow = DateTime.now(); //DateTime
                        // Timestamp myTimeStamp = Timestamp.fromDate(dateTimeNow);
                        // if (myTimeStamp.compareTo(data[index].createDate) > 0) {
                        //   print('เลย2');
                        // }
                        // int timestamp =
                        //     data[index].createDate.microsecondsSinceEpoch;
                        // var date =
                        //     new DateTime.fromMicrosecondsSinceEpoch(timestamp);

                        return Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    index != 0
                                        ? data[index].date.substring(0, 10) ==
                                                data[index - 1]
                                                    .date
                                                    .substring(0, 10)
                                            ? ""
                                            : "${data[index].date.substring(0, 10)}"
                                        : "${data[index].date.substring(0, 10)}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                )
                              ],
                            ),
                            Slidable(
                                endActionPane: ActionPane(
                                  motion: StretchMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: ((context) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditTodoScreen(
                                                      data: snapshot
                                                          .data![index])),
                                        );
                                      }),
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.orange.shade200,
                                      icon: Icons.edit,
                                    ),
                                    SlidableAction(
                                      onPressed: ((context) {
                                        DeleteAwesome(
                                          snapshot.data![index].todo,
                                          snapshot.data![index].id,
                                        );
                                      }),
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.red.shade400,
                                      icon: Icons.delete,
                                    )
                                  ],
                                ),
                                child: ListTile(
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
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
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
                                                                color: Colors
                                                                    .red[300],
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
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              children: <
                                                                  TextSpan>[
                                                                const TextSpan(
                                                                    text:
                                                                        'Todo :',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold)),
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
                                                                  text:
                                                                      TextSpan(
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
                                                                          style:
                                                                              const TextStyle(fontWeight: FontWeight.bold)),
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
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              children: <
                                                                  TextSpan>[
                                                                const TextSpan(
                                                                    text:
                                                                        'Time :',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold)),
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
                                                    snapshot.data?[index].img !=
                                                            ''
                                                        ? Container(
                                                            width: 80,
                                                            height: 80,
                                                            decoration: BoxDecoration(
                                                                borderRadius: const BorderRadius
                                                                        .only(
                                                                    topLeft:
                                                                        Radius.circular(
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
                                                                color: Colors
                                                                    .white38,
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
                                  leading: IconButton(
                                    onPressed: () {
                                      AwesomeDialog(
                                        btnOkOnPress: () async {
                                          await provHistory
                                              .createTodoHistory(
                                                  img: data[index].img,
                                                  createAt:
                                                      data[index].createAt,
                                                  todo: data[index].todo,
                                                  date: data[index].date,
                                                  description:
                                                      data[index].description,
                                                  createDate:
                                                      data[index].createDate)
                                              .then((value) => prov.deleteTodos(
                                                  id: data[index].id))
                                              .then((value) => AwesomeDialog(
                                                    btnOkOnPress: () {},
                                                    context: context,
                                                    dialogType:
                                                        DialogType.success,
                                                    animType:
                                                        AnimType.rightSlide,
                                                    title:
                                                        'You success the ${data[index].todo}!',
                                                    autoHide: const Duration(
                                                        seconds: 2),
                                                  ).show());
                                        },
                                        btnCancelOnPress: () {},
                                        context: context,
                                        dialogType: DialogType.question,
                                        animType: AnimType.rightSlide,
                                        title:
                                            'You success the ${data[index].todo}, right?',
                                        autoHide: const Duration(seconds: 2),
                                      ).show();
                                    },
                                    icon: AppIcon(
                                      icon: Icons.check,
                                      backgroundColor:
                                          Colors.grey.withOpacity(0.5),
                                      iconColor: Colors.grey,
                                      iconSize: 20,
                                    ),
                                  ),
                                ))
                          ],
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // _showMyDialog();
            Navigator.pushNamed(context, '/todolist/add');
          },
          backgroundColor: AppColors.mainColor,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  late String todo = '';
  late String description = '';
  late DateTime _myDateTime;
  late String date = '';
  final initialTime = const TimeOfDay(hour: 0, minute: 0);
  late TimeOfDay time = const TimeOfDay(hour: -10, minute: 0);
  final formKey = GlobalKey<FormState>();
  late String timetext = '?';
  late String hour = '?';
  late String min = '?';
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add new?'),
          content: SizedBox(
            height: 220,
            child: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 0, left: 20, right: 20),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.length >= 100) {
                        return 'Please enter To do.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.sports_soccer),
                        labelText: 'To do',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        )),
                    onChanged: (String value) {
                      todo = value;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 7, left: 20, right: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.description),
                        labelText: 'Description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        )),
                    onChanged: (String value) {
                      description = value;
                    },
                  ),
                ),
                Text(date),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        _myDateTime = (await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2010),
                            lastDate: DateTime(2025)))!;
                        setState(() {
                          print(_myDateTime);
                          //final now = DateTime.now();
                          // print(_myDateTime);
                          date = DateFormat('dd-MM-yyyy').format(_myDateTime);
                          print('format to $date');
                          //time = _myDateTime.toString();
                        });
                      },
                      child: Container(
                          // width: 100,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                              color: Colors.grey.withOpacity(0.3)),
                          padding: const EdgeInsets.only(
                              top: 20, left: 15, right: 15, bottom: 20),
                          margin:
                              const EdgeInsets.only(top: 7, left: 0, right: 0),
                          child: date == ''
                              ? const Text('Select date')
                              : Text('Date : $date')),
                    ),
                    InkWell(
                      onTap: () async {
                        final newTime = await showTimePicker(
                            context: context, initialTime: initialTime);

                        setState(() {
                          time = newTime!;
                          hour = time.hour.toString();
                          min = time.minute.toString();
                          if (hour.length == 1 && min.length == 1) {
                            timetext = ' 0${time.hour}:0${time.minute}';
                          } else if (hour.length == 2 && min.length == 1) {
                            timetext = ' ${time.hour}:0${time.minute}';
                          } else if (hour.length == 1 && min.length == 2) {
                            timetext = ' 0${time.hour}:${time.minute}';
                          } else if (hour.length == 2 && min.length == 2) {
                            timetext = ' ${time.hour}:${time.minute}';
                          }
                          // print(time.hour.bitLength);
                        });
                      },
                      child: Container(
                          // width: 100,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                              color: Colors.grey.withOpacity(0.3)),
                          padding: const EdgeInsets.only(
                              top: 20, left: 15, right: 15, bottom: 20),
                          margin:
                              const EdgeInsets.only(top: 7, left: 0, right: 0),
                          child: time == const TimeOfDay(hour: -10, minute: 0)
                              ? const Text('Choose time')
                              : Text(
                                  'Time : ${time.hour.toString()} : ${time.minute.toString()} ')),
                    ),
                  ],
                )
              ],
            )),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Add'),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<AwesomeDialog> DeleteAwesome(String title, String id) async =>
      AwesomeDialog(
        context: context,
        dialogType: DialogType.question,
        animType: AnimType.rightSlide,
        title: 'Do you want to delete $title?',
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          Provider.of<TodolistProvider>(context, listen: false)
              .deleteTodos(id: id)
              .then((value) => AwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  animType: AnimType.rightSlide,
                  title: 'Delete Success!',
                  autoHide: const Duration(seconds: 2))
                ..show());
        },
      )..show();
}
