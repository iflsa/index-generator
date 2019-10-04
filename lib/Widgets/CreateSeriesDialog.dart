import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:index_generator/model/Series.dart';

class CreateSeriesDialog extends StatefulWidget {
  const CreateSeriesDialog({Key key}) : super(key: key);

  @override
  _CreateSeriesDialogState createState() => _CreateSeriesDialogState();
}

class _CreateSeriesDialogState extends State<CreateSeriesDialog> {
  String _name = "";
  String _model = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                "Adding a series",
                style: TextStyle(
                  color: Colors.tealAccent,
                  fontSize: 25.0,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Name:",
                  labelStyle: TextStyle(color: Colors.white),
                ),
                onChanged: (value) {
                  _name = value;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Index model:",
                  labelStyle: TextStyle(color: Colors.white),
                ),
                onChanged: (value) {
                  _model = value;
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
          onPressed: () {
            if (_name != "" && _model != "") {
              Series newSeries = Series(_name, _model);
              Hive.box('serieses').add(newSeries);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
