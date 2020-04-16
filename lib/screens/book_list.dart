import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:em_school/screens/add_book.dart';
import 'package:em_school/screens/home.dart';
import 'package:em_school/screens/view_post.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BookList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('books').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              return new ListView(
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return new ListTile(
                    title: new Text(document['title']),
                    subtitle: new Text(document['author']),
                    trailing: GestureDetector(
                      child: GestureDetector(
                        child: Icon(Icons.edit, color: Colors.amber),
                        onTap: () {
                          Fluttertoast.showToast(
                              msg: "Data Edit",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddBook()));
                        },
                      ),
                      //onTap:  document.documentID,//Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ViewPost()));
                    ),
                    /* onTap: () {
                      Fluttertoast.showToast(
                          msg: "Data inserted successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }, */
                  );
                }).toList(),
              );
          }
        },
      ),
    );
  }
}
