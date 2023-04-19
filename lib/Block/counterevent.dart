import 'package:bloc/bloc.dart';

class safal extends Cubit<int> {
  safal() : super(0);
  void increment() {
    emit(state + 1);
  }

  void decrement() {
    emit(state - 1);
  }
}
