import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/Series.dart';

class CreateSeriesesDialog extends StatefulWidget {
  const CreateSeriesesDialog({Key key}) : super(key: key);

  @override
  _CreateSeriesesDialogState createState() => _CreateSeriesesDialogState();
}

class _CreateSeriesesDialogState extends State<CreateSeriesesDialog> {
  String _str = "";

  void add() {
    if (_str != "") {
      var li = _str.split('\n');
      for (var i in li) {
        var la = i.split("-");
        Series newSeries = Series(la[0].trim(), la[1].trim());
        Hive.box('serieses').add(newSeries);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        content: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  "Add many",
                  style: TextStyle(
                    color: Colors.tealAccent,
                    fontSize: 25.0,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Enter multiple serieses:",
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  minLines: 5,
                  maxLines: 15,
                  onChanged: (value) {
                    setState(() {
                      _str = value;
                    });
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
            child: Text('Add'),
            onPressed: add,
          ),
        ],
      ),
    );
  }
}
