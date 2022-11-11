import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swift_test/Problem_1/history_screen.dart';
import 'package:swift_test/Problem_1/todolist_screen.dart';
import 'package:swift_test/Problem_3/list_screen.dart';
import 'package:swift_test/homepage.dart';
import 'package:swift_test/provider/provider_information.dart';
import 'package:swift_test/provider/provider_stepper.dart';
import 'package:swift_test/provider/provider_todo_history.dart';
import 'package:swift_test/provider/provider_todolist.dart';

import 'Problem_1/add_todolist.dart';
import 'Problem_2/calculator.dart';
import 'Problem_3/add_information.dart';
import 'Problem_4/list_data.dart';
import 'Problem_4/stepper_form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodolistProvider()),
        ChangeNotifierProvider(create: (_) => TodolistHistoryProvider()),
        ChangeNotifierProvider(create: (_) => InformationProvider()),
        ChangeNotifierProvider(create: (_) => StepperProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Homepage(),
        '/todolist': (context) => TodolistScreen(),
        '/todolist/add': (context) => AddTodoScreen(),
        '/todolist/history': (context) => HistoryScreen(),
        '/calculator': (context) => Calculator(),
        '/information': (context) => ListScreen(),
        '/information/add': (context) => AddInformationScreen(),
        '/stepper/add': (context) => StepperProblem4(),
        '/stepper': (context) => Problem4(),
      },
    );
  }
}
