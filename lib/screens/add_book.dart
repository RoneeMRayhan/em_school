import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddBook extends StatefulWidget {
  AddBook({Key key}) : super(key: key);

  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  static String title = 't', author = 'a';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AddBook Page'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              GestureDetector(
                child: Text('Add Book'),
                onTap: () {
                  Firestore.instance
                      .collection('books')
                      .document()
                      .setData({'title': title, 'author': author});
                  Fluttertoast.showToast(
                      msg: "Data inserted successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
