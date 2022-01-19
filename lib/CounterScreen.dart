import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/cubit/cubit.dart';
import 'package:tasks_app/cubit/states.dart';

class Counter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=> CounterCubit(),
      child: BlocConsumer<CounterCubit,CounterStates>(
        listener:(context,state){

          if (state is CounterAdding){
            print ("Its adding state ${state.counter}");
          }
          if (state is CounterMinus){
            print ("Its Minus state ${state.counter}");
          }
        } ,
        builder:(context,state){
          return Scaffold(
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                      onTap: () {
                        CounterCubit.get(context).minus();
                      },
                      child: Text(
                        'Minus',
                        style: TextStyle(fontSize: 20),
                      )),
                  Text(
                    '${CounterCubit.get(context).counter}',
                    style: TextStyle(fontSize: 30),
                  ),
                  InkWell(
                      onTap: () {
                        CounterCubit.get(context).plus();
                      },
                      child: Text(
                        'Plus',
                        style: TextStyle(fontSize: 20),
                      ))
                ],
              ),
            ),
          );
        } ,

      ),
    );
  }
}


