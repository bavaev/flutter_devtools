import 'package:equatable/equatable.dart';

abstract class StudentEvent extends Equatable {}

class StudentAddEvent extends StudentEvent {
  final List<dynamic> activist;

  StudentAddEvent(this.activist);

  @override
  List<List<dynamic>> get props => [activist];
}

class StudentRemoveEvent extends StudentEvent {
  final List<dynamic> activist;

  StudentRemoveEvent(this.activist);

  @override
  List<List<dynamic>> get props => [activist];
}
