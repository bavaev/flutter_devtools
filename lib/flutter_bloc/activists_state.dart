import 'package:equatable/equatable.dart';

abstract class ActivistsState extends Equatable {}

class ActivistsLoading extends ActivistsState {
  @override
  List<Map<int, double>> get props => [];
}

class ActivistsLoaded extends ActivistsState {
  final Map<int, double> activists;

  ActivistsLoaded(this.activists);

  @override
  List<Map<int, double>> get props => [activists];
}
