import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuestionBank extends StatelessWidget {
  QuestionBank({Key key}) : super(key: key);
  Firestore fdb = Firestore.instance;

  List<Map> questions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }

  Widget buildBody() {
    print(questions);
    return StreamBuilder<QuerySnapshot>(
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
            questions.add(document.data);
            final dynamic message = document['option1'];
            return GestureDetector(
              child: ListTile(
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
              ),
              onTap: () => print(questions),
            );
          },
        );
      },
    );
  }
}
