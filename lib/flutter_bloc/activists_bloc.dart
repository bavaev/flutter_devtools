import 'package:devtools_flutter/flutter_bloc/activists_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:devtools_flutter/flutter_bloc/activists_state.dart';

class ActivistsBloc extends Bloc<ActivistsEvent, ActivistsState> {
  ActivistsBloc() : super(ActivistsLoading()) {
    on<ActivistsAdd>((event, emit) {
      final state = this.state;
      emit(ActivistsLoaded(event.activists));
    });
  }
}
