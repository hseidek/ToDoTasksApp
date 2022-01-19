import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasks_app/ArchivedTaskScreen,dart.dart';
import 'package:tasks_app/DoneTaskScreen.dart';
import 'package:tasks_app/NewTaskScreen.dart';
import 'package:tasks_app/component.dart';
import 'package:tasks_app/shared/cubit.dart';
import 'package:tasks_app/shared/states.dart';

import 'constants.dart';

class HomeLayoutScreen extends StatelessWidget
{


  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool isBottomSheetShown = false;
  IconData defIcon = Icons.edit;



  TextEditingController  titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
//  void initState() {
//    super.initState();
//    createDatabase();
//  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){} ,
        builder:(context,state){
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Task"),
                BottomNavigationBarItem(icon: Icon(Icons.done_all), label: "Done"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_rounded), label: "Archived"),
              ],
            ),
            body: ConditionalBuilder(
              // condition write the condition here
              condition: true ,
              // builder if condition true
              builder: (context)=> cubit.screens[cubit.currentIndex] ,
              // fallback if condition not true
              fallback: (context)=>Center(child: CircularProgressIndicator(),) ,

            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
//                    insertIntoDatabase(title: titleController.text,date: dateController.text,time: timeController.text)
//                        .then((value) {
//                      Navigator.pop(context);
//                      isBottomSheetShown = false;
////                setState(() {
////                  defIcon = Icons.edit;
////                });
//                    });
                  }
                } else {
                  scaffoldKey.currentState
                      ?.showBottomSheet((context) => Container(
                    color: Colors.grey[100],
                    padding: EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          defaultTextFormField(
                              controller: titleController,
                              type: TextInputType.text,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Value can not be Empty';
                                }
                                return null;
                              },
                              label: "Task Title",
                              prefix: Icons.title),
//                          TextField(controller: titleController,
//
//                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultTextFormField(
                              controller: timeController,
                              type: TextInputType.datetime,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Time can not be Empty';
                                }
                                return null;
                              },
                              label: "Task Time",
                              prefix: Icons.watch_later,
                              onTap: () {
                                showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now())
                                    .then((value) {
                                  timeController.text =
                                      value!.format(context).toString();
//                              print (value!.format(context).toString());
                                });
                              }),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultTextFormField(
                              controller: dateController,
                              type: TextInputType.datetime,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Date can not be Empty';
                                }
                                return null;
                              },
                              label: "Task Date",
                              prefix: Icons.calendar_today,
                              onTap: () {
                                showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate:
                                    DateTime.parse('2022-12-31'))
                                    .then((value) {
                                  dateController.text =
                                      DateFormat.yMMMd().format(value!);
                                });
                              }),
                        ],
                      ),
                    ),
                  ))
                      .closed
                      .then((value) {
                    isBottomSheetShown = false;
//              setState(() {
//                defIcon = Icons.edit;
//              });
                  });
                  isBottomSheetShown = true;
//            setState(() {
//              defIcon = Icons.add;
//            });
                }
              },
              child: Icon(defIcon),
            ),
          );
        } ,
      ),
    );
  }


}


