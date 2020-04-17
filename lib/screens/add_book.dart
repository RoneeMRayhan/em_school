import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'book_list.dart';

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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Enter Title'),
            onChanged: (text) {
              print("Title: $text");
              title = text;
            },
          ),
          TextField(
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Enter Author'),
            onChanged: (text) {
              print("Author: $text");
              author = text;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /* TextField(
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Enter a search term'),
              ), */
              GestureDetector(
                child: Text(
                  'Add a Book',
                  style: TextStyle(
                      backgroundColor: Colors.amber,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
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
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => BookList()));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
