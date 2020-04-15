import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Name extends StatefulWidget {
  Name({Key key}) : super(key: key);
  final fb = FirebaseDatabase.instance;
  final myController = TextEditingController();
  final name = "posts";

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<Name> {
  final fb = FirebaseDatabase.instance;
  final myController = TextEditingController();
  final name = "Name";

  var retrievedName;

  @override
  Widget build(BuildContext context) {
    final ref = fb.reference();
    return Scaffold(
        appBar: AppBar(
          title: Text("title"),
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(name),
                Flexible(child: TextField(controller: myController)),
              ],
            ),
            RaisedButton(
              onPressed: () {
                ref.child(name).child("rayon").child(name).set(myController.text);
              },
              child: Text("Submit"),
            ),
            RaisedButton(
              onPressed: () {
                ref.child(name).set(myController.text);
                ref.child("body").once().then(
                  (DataSnapshot data) {
                    print(data.value);
                    print(data.key);
                    setState(() {
                      retrievedName = data.value;
                    });
                  },
                );
              },
              child: Text("get"),
            ),
            Text(retrievedName ?? "posts")
          ],
        )));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
}
