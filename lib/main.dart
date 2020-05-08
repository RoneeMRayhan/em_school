import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EM School',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select the correct answer')),
      body: _buildBody(context),
    );
  }

  /* Widget _buildColumn(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('text'),
        _buildBody(context),
      ],
    );
  } */

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('bcs').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);
    List<String> groupValue = [];
    groupValue.add(record.questionAnswer);

    return Padding(
      // key: ValueKey(record.name),
      key: ValueKey(record.questionText),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
            /* 
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, */
            children: <Widget>[
              //Text(record.name),
              /* Text(record.questionText),
              Text(record.option1), */

              Text(record.questionText),
              RaisedButton(onPressed: () {
                print(groupValue.first);
                print(groupValue.length);
                print(groupValue);
              }),
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),

              ListTile(
                title: Text(record.option1),
                leading: Radio(
                  value: record.questionAnswer,
                  groupValue: groupValue[0],
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
              ListTile(
                title: Text(record.option2),
                leading: Radio(
                  value: record.option2,
                  groupValue: groupValue[0],
                  onChanged: (value) {
                    setState(() {
                      groupValue = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text(record.option3),
                leading: Radio(
                  value: record.option3,
                  groupValue: groupValue,
                  onChanged: (value) {
                    setState(() {
                      groupValue = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text(record.option4),
                leading: Radio(
                  value: record.option4,
                  groupValue: groupValue,
                  onChanged: (value) {
                    setState(() {
                      groupValue = value;
                    });
                  },
                ),
              ),
              /* Text(record.option2),
              Text(record.option3),
              Text(record.option4),
              Text(record.questionAnswer), */
              //Text(record.votes.toString()),
            ]),
      ),
    );
  }
}

class Record {
  //final String name;
  final String questionText, option1, option2, option3, option4, questionAnswer;
  //final int votes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['questionText'] != null),
        assert(map['option1'] != null),
        assert(map['option2'] != null),
        assert(map['option3'] != null),
        assert(map['option4'] != null),
        assert(map['questionAnswer'] != null),
        //name = map['name'],
        questionText = map['questionText'],
        option1 = map['option1'],
        option2 = map['option2'],
        option3 = map['option3'],
        option4 = map['option4'],
        questionAnswer = map['questionAnswer'];
  //votes = map['votes'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$questionText:$questionAnswer>";
}
