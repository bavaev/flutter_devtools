import 'dart:async';

import 'student_event.dart';

class StudentBloc {
  final Map<int, double> _activists = {};

  final _inputEventController = StreamController<StudentEvent>();
  StreamSink<StudentEvent> get inputEventSink => _inputEventController.sink;

  final _outputStateController = StreamController<Map<int, double>>();
  Stream<Map<int, double>> get outputStateStream => _outputStateController.stream.asBroadcastStream();

  void mapEventToState(StudentEvent event) {
    if (event is StudentAddEvent) {
      _activists[event.activist[0]] = event.activist[1];
    } else if (event is StudentRemoveEvent) {
      _activists.remove(event.activist[0]);
    }

    _outputStateController.sink.add(_activists);
  }

  StudentBloc() {
    _inputEventController.stream.listen(mapEventToState);
  }

  void dispose() {
    _inputEventController.close();
    _outputStateController.close();
  }
}
