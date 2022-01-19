import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/cubit/states.dart';

class CounterCubit extends Cubit<CounterStates>{

  CounterCubit() : super(CounterInitialState());

// As we will use the cubit in many places so instead to create an object from it in any class we use it
// we created a static method from it in same cubit class to use it fast in any class directly
  static CounterCubit get (context) => BlocProvider.of(context);

  int counter = 0;


  void minus (){

    counter --;
    emit(CounterMinus(counter));
  }

  void plus (){

    counter ++;
    emit(CounterAdding(counter));

  }


}