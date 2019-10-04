import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:index_generator/screens/GenerateScreen.dart';
import '../model/Series.dart';

class SeriesListItem extends StatelessWidget {
  const SeriesListItem(this.series, this.id, {Key key}) : super(key: key);

  final Series series;
  final int id;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => GenerateScreen(series, id),
          ),
        );
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      series.name,
                      style: TextStyle(color: Colors.white, fontSize: 24.0),
                    ),
                    Text(
                      "Index model: ${series.model.toString()}",
                      style: TextStyle(color: Colors.grey, fontSize: 16.0),
                    )
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                color: Colors.tealAccent,
                iconSize: 25.0,
                onPressed: () {
                  Hive.box('serieses').deleteAt(id);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
