import 'package:devtools_flutter/bloc/student_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:devtools_flutter/bloc/student_bloc.dart';
import 'package:devtools_flutter/flutter_bloc/activists_bloc.dart';
import 'package:devtools_flutter/flutter_bloc/activists_event.dart';
import 'package:devtools_flutter/flutter_bloc/activists_state.dart';
import 'package:flutter/material.dart';

class SecondList extends StatefulWidget {
  const SecondList({Key? key}) : super(key: key);

  @override
  State<SecondList> createState() => _SecondListState();
}

class _SecondListState extends State<SecondList> {
  final StudentBloc _bloc = StudentBloc();
  Map<int, double> state = {};

  @override
  void initState() {
    _bloc.outputStateStream.listen((event) {
      setState(() => state = event);
      BlocProvider.of<ActivistsBloc>(context).add(ActivistsAdd(event));
    });
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivistsBloc, ActivistsState>(
      builder: (context, state) {
        if (state is ActivistsLoaded) {
          state.activists.forEach((key, value) {
            _bloc.inputEventSink.add(StudentAddEvent([key, value]));
          });
          final List<int> keys = state.activists.keys.toList();
          return ListView.builder(
              itemCount: keys.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.green.shade100, Colors.blue.shade100]),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black45,
                        offset: Offset(5, 5),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Image.asset('assets/student.png'),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Student - ${keys[index]}',
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Score - ${state.activists[keys[index]]}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () => _bloc.inputEventSink.add(StudentRemoveEvent([keys[index], state.activists[keys[index]]])),
                                child: const Text('Удалить'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
