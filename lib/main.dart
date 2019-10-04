import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:index_generator/model/Series.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'States/MainState.dart';
import 'screens/GenerateScreen.dart';
import 'screens/MainScreen.dart';

void main() async {
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(SeriesAdapter(), 0);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Index Generator',
      theme: ThemeData.dark(),
      home: MainScreen(),
    );
  }
}
