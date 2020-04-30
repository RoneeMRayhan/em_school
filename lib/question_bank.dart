import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuestionBank extends StatelessWidget {
  QuestionBank({Key key}) : super(key: key);
  Firestore fdb = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: fdb
            .collection("bcs")
            //.orderBy("created_at", descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const Text('Loading...');
          final int messageCount = snapshot.data.documents.length;
          return ListView.builder(
            itemCount: messageCount,
            itemBuilder: (_, int index) {
              final DocumentSnapshot document = snapshot.data.documents[index];
              final dynamic message = document['questionText'];
              return ListTile(
                trailing: IconButton(
                  onPressed: () => document.reference.delete(),
                  icon: Icon(Icons.delete),
                ),
                title: Text(
                  message != null
                      ? message.toString()
                      : '<No message retrieved>',
                ),
                subtitle: Text('Message ${index + 1} of $messageCount'),
              );
            },
          );
        },
      ),
    );
  }
}
