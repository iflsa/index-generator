import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:index_generator/model/Series.dart';
import 'package:provider/provider.dart';
import '../States/MainState.dart';
import '../Widgets/SeriesListItem.dart';
import '../Widgets/CreateSeriesDialog.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Index Generator"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Hive.openBox('serieses'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else if (snapshot.hasData) {
              return _buildListView();
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.list,
                      size: 100.0,
                      color: Colors.white60,
                    ),
                    SizedBox(height: 75.0),
                    Text(
                      "Your serieses will show up here.",
                      style: TextStyle(fontSize: 20.0, color: Colors.white60),
                    ),
                    SizedBox(height: 50.0),
                  ],
                ),
              );
            }
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text("Add"),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => CreateSeriesDialog());
        },
      ),
    );
  }

  _buildListView() {
    return WatchBoxBuilder(
      box: Hive.box('serieses'),
      builder: (ctx, sBox) => ListView.builder(
        itemCount: sBox.length,
        itemBuilder: (ctx, id) {
          final se = sBox.getAt(id) as Series;
          return SeriesListItem(se, id);
        },
      ),
    );
  }
}
