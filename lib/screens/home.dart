import 'package:em_school/main.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

int counter = MyApp().counter;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  String title = 'HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = counter;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      theme: ThemeData(primarySwatch: Colors.amber),
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        backgroundColor: Colors.amber[200],
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('This is pressed $_counter times'),
              ],
            )
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
