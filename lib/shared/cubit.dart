import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasks_app/shared/states.dart';

import '../ArchivedTaskScreen,dart.dart';
import '../DoneTaskScreen.dart';
import '../NewTaskScreen.dart';

class AppCubit extends Cubit <AppStates>{
  AppCubit() : super(AppInitialState());

static AppCubit get (context)=> BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    NewTaskScreen(),
    DoneTaskScreen(),
    ArchivedTaskScreen()
  ];

  List <String> titles =[
    'New Tasks', 'Done Tasks', 'Archived tasks'

  ];

  void changeIndex (int index){
    currentIndex= index;
    emit(AppChangeBottomNavBarState());

  }

  Database? database;
  List <Map> tasks = [];
  void createDatabase()  {
   openDatabase("todo.db",
        onCreate: (database, version) {
          print("Database Created");
          database
              .execute(
              'create table tasks(id INTEGET primary key, title TEXT, date TEXT, time TEXT,status TEXT)')
              .then((value) {
            print("Table is created");
          }).catchError((error) {
            print(
                "Error while creating the table in database ${error.toString()}");
          });
        },
        version: 1,
        onOpen: (database) {
          print("Database is opened");
          getDataFromDatabase(database).then((value) {
             tasks = value;
            print (tasks);
            emit(AppGetDatabaseState());

          });
        }).then((value) {
          database = value;
          emit(AppCreateDatabaseState());
    });
  }

  Future insertIntoDatabase(
      {@required title,@required date,@required time}) async {
    return await database?.transaction((txn) {
      txn
          .rawInsert(
          'INSERT INTO tasks(title,date,time,status) Values ("$title","$date","$time","New")')
          .then((value) {
        print("$value Instereted successfully");
      }).catchError((error) {
        print(
            "Error happened while inserting the record in the database ${error.toString()}");
      });
      return null;
    });
  }

  Future <List<Map>> getDataFromDatabase (database) async  {
    return database!.rawQuery('Select * from tasks');

  }
}