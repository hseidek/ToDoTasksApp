abstract class CounterStates {}

class CounterInitialState extends CounterStates {}
class CounterAdding extends CounterStates {

  late final int counter;
  CounterAdding(this.counter);

}
class CounterMinus extends CounterStates {

  late final int counter;
  CounterMinus(this.counter);
}
