import 'package:equatable/equatable.dart';

abstract class ActivistsEvent extends Equatable {
  const ActivistsEvent();
}

class ActivistsAdd extends ActivistsEvent {
  final Map<int, double> activists;

  const ActivistsAdd(this.activists);

  @override
  List<Map<int, double>> get props => [activists];
}
