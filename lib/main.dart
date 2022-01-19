import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/LoginPage.dart';
import 'package:tasks_app/NewTaskScreen.dart';

import 'CounterScreen.dart';
import 'HomeLayoutScreen.dart';
import 'cubit/blocobserver.dart';

void main() {

  Bloc.observer = MyBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home:HomeLayoutScreen(),
    );
  }
}


