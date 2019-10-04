import 'package:flutter/material.dart';

class NoSerieses extends StatelessWidget {
  const NoSerieses({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
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
      ),
    );
  }
}
