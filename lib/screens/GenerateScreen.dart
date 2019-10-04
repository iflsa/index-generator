import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:index_generator/model/Series.dart';
import 'dart:math';

class GenerateScreen extends StatefulWidget {
  const GenerateScreen(this.series, this.id, {Key key}) : super(key: key);

  final Series series;
  final int id;

  @override
  _GenerateScreenState createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  List<String> _outputs = [];
  List<String> _outputsToShow = [];
  int _numOfRands = 0;

  var sBox;

  String randOne() {
    String tmpStr = "";
    String letters = "qwertyuiopasdfghjklzxcvbnm";
    bool skip = false;
    print(widget.series.model.split(""));

    for (var i in widget.series.model.split("")) {
      if (skip) {
        tmpStr += i;
        skip = false;
      } else if (i == '#') {
        tmpStr += Random().nextInt(10).toString();
      } else if (i == '*') {
        int r = Random().nextInt(letters.length);
        tmpStr += letters[r];
      } else if (i == '^') {
        int r = Random().nextInt(letters.length);
        tmpStr += letters.toUpperCase()[r];
      } else if (i == '\\') {
        skip = true;
      } else {
        tmpStr += i;
      }
    }

    if (_outputs.contains(tmpStr)) {
      if (_outputs.length == pow(10, widget.series.model.length)) {
        _outputs = [];
        _showReloadDialog();
      } else {
        return randOne();
      }
    }
    return tmpStr;
  }

  void rand(int numsNum) {
    List<String> tmpList = [];
    for (int i = 0; i < numsNum; i++) tmpList.add(randOne());
    setState(() {
      _outputs += tmpList;
      _outputsToShow = tmpList;
    });
  }

  void _showReloadDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Reloading randomizer",
                  style: TextStyle(
                    color: Colors.tealAccent,
                    fontSize: 25.0,
                  ),
                ),
                SizedBox(height: 25.0),
                Text("All passible options has been randomized.")
              ],
            ),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  initState() {
    super.initState();
    setState(() {
      sBox = Hive.box('serieses');
      _outputs = sBox.getAt(widget.id).used;
    });
    print(sBox.toString());
  }

  @override
  void dispose() {
    sBox.putAt(
      widget.id,
      Series(widget.series.name, widget.series.model, used: _outputs),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.series.name}"), centerTitle: true),
      body: Container(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 125.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (var i in _outputsToShow)
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: AutoSizeText(
                      '$i',
                      style: TextStyle(
                        fontSize: 50.0,
                        fontFamily: 'Amatic SC',
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 4,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      )),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton.extended(
            heroTag: null,
            icon: Icon(Icons.scatter_plot),
            label: Text("Random one"),
            onPressed: () {
              rand(1);
            },
          ),
          SizedBox(height: 10.0),
          FloatingActionButton.extended(
            heroTag: null,
            icon: Icon(Icons.scatter_plot),
            label: Text("Random more"),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  content: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "How many to random?",
                            style: TextStyle(
                              color: Colors.tealAccent,
                              fontSize: 25.0,
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Number of randoms:",
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              int myNum = int.tryParse(value);
                              _numOfRands = myNum == null ? 0 : myNum;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text('Random'),
                      onPressed: () {
                        if (_numOfRands != 0) {
                          rand(_numOfRands);
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
