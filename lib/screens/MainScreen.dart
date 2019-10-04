import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:index_generator/Widgets/NoSerieses.dart';
import 'package:index_generator/model/Series.dart';
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
              return NoSerieses();
            }
          } else {
            return Center(child: CircularProgressIndicator());
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
      builder: (ctx, sBox) {
        if (sBox.length > 0) {
          return ListView.builder(
            itemCount: sBox.length,
            itemBuilder: (ctx, id) {
              final se = sBox.getAt(id) as Series;
              return SeriesListItem(se, id);
            },
          );
        } else {
          return NoSerieses();
        }
      },
    );
  }
}
