import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../model/Series.dart';

class MainState extends ChangeNotifier {
  List<Series> _serieses = [];

  void addSeries(Series newSeries) {
    _serieses.add(newSeries);
    notifyListeners();
  }

  void dummy() {
    for (int i = 0; i < 10; i++) {
      _serieses.add(Series("Series ${i.toString()}", i));
    }
    notifyListeners();
  }

  deleteSeries(Series series) {
    _serieses.remove(series);
    notifyListeners();
  }

  saveSerieses() async {
    final directory = await getApplicationDocumentsDirectory();
    File('${directory.path}/serieses.txt')
        .writeAsString('${_serieses.toString()}');
  }

  loadSerieses() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/serieses.txt');
      String tStr = await file.readAsString();
      var list = jsonDecode(tStr);
      _serieses = list;
      notifyListeners();
    } catch (e) {}
  }

  get serieses => _serieses;
}
