import 'dart:math';

import 'package:devtools_flutter/bloc/student_bloc.dart';
import 'package:devtools_flutter/bloc/student_event.dart';
import 'package:devtools_flutter/flutter_bloc/activists_bloc.dart';
import 'package:devtools_flutter/flutter_bloc/activists_event.dart';
import 'package:devtools_flutter/flutter_bloc/activists_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:devtools_flutter/network/getNetworkData.dart';

class FirstList extends StatefulWidget {
  const FirstList({Key? key}) : super(key: key);

  @override
  State<FirstList> createState() => _FirstListState();
}

class _FirstListState extends State<FirstList> {
  final StudentBloc _bloc = StudentBloc();
  late Map<int, double> state = {};
  var rng = Random();

  double random() {
    return rng.nextInt(10000) / 100;
  }

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
    return ListView.builder(itemBuilder: (context, index) {
      double _score = random();
      return BlocBuilder<ActivistsBloc, ActivistsState>(
        builder: (context, blocState) {
          if (blocState is ActivistsLoaded) {
            state = blocState.activists;
          }
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
                          'Student - ${index.toString()}',
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Score - ${state[index] ?? _score}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            state.keys.contains(index)
                                ? _bloc.inputEventSink.add(StudentRemoveEvent([index, state[index] ?? _score]))
                                : _bloc.inputEventSink.add(StudentAddEvent([index, state[index] ?? _score]));
                          },
                          child: state.keys.contains(index) ? const Text('Удалить') : const Text('Добавить'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
