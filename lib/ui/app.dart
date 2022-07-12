import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:devtools_flutter/ui/list_1.dart';
import 'package:devtools_flutter/ui/list_2.dart';
import 'package:devtools_flutter/flutter_bloc/activists_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter DevTools',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<ActivistsBloc>(
        create: (context) => ActivistsBloc(),
        child: const MyHomePage(title: 'Flutter DevTools'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: TabBar(
            controller: _tabController,
            tabs: const <Widget>[
              Tab(
                icon: Icon(Icons.person_pin_rounded),
              ),
              Tab(
                icon: Icon(Icons.co_present_rounded),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            FirstList(),
            SecondList(),
          ],
        ));
  }
}
