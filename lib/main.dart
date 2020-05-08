import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

Firestore fsd = Firestore.instance;
List<String> groupValue = [];
List<String> correctAnswer = [];
int index = 0;
double mark = 0.0;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EM School',
      home: Scaffold(
        body: MyHomePage(),
        floatingActionButton: FloatingActionButton(onPressed: () {
          for (int i = 0; i < groupValue.length - 1; i++) {
            if (groupValue[i] == correctAnswer[i]) {
              mark = mark + 1.0;
            } else if (groupValue[i] != correctAnswer[i]) {
              mark = mark - 0.5;
            } else {
              mark = mark;
            }
          }
          print(mark.toString());
        }),
      ),
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
  /* Firestore fsd = Firestore.instance;
  List<String> groupValue;
  List<String> correctAnswer;
  int index;
  double mark = 0.0; */
  @override
  void initState() {
    super.initState();
    index = 0;
    Record record;
    groupValue = [];
    correctAnswer = [];
    fsd.collection('bcs').snapshots().listen((data) {
      data.documents.map((f) {
        record = Record.fromSnapshot(f);
        groupValue.add(record.id.toString());
        correctAnswer.add(record.questionAnswer);
        print(record.questionAnswer);
      }).toList();
    });
  }

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
    /* final  */ Record record = Record.fromSnapshot(data);

    /* groupValue.add(record.questionAnswer); */
    //int index = 0;
    //String groupValue;

    return Padding(
      // key: ValueKey(record.name),
      //key: ValueKey(record.questionText),
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
                print(groupValue);
                print(groupValue.length);
                print(groupValue[3]);
                print(index.toString());
              }),
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),

              ListTile(
                title: Text(record.option1),
                leading: Radio(
                  value: record.option1, //record.questionAnswer,
                  groupValue: groupValue[record.id - 1],
                  onChanged: (value) {
                    setState(() {
                      groupValue[record.id - 1] = value;
                      //index++;
                      //groupValue.add(value);
                    });
                  },
                ),
              ),
              ListTile(
                title: Text(record.option2),
                leading: Radio(
                  value: record.option2,
                  groupValue: groupValue[record.id - 1],
                  onChanged: (value) {
                    setState(() {
                      groupValue[record.id - 1] = value;
                      //index++;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text(record.option3),
                leading: Radio(
                  value: record.option3,
                  groupValue: groupValue[record.id - 1],
                  onChanged: (value) {
                    setState(() {
                      groupValue[record.id - 1] = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text(record.option4),
                leading: Radio(
                  value: record.option4,
                  groupValue: groupValue[record.id - 1],
                  onChanged: (value) {
                    setState(() {
                      groupValue[record.id - 1] = value;
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
  int id;
  //final int votes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['questionText'] != null),
        assert(map['option1'] != null),
        assert(map['option2'] != null),
        assert(map['option3'] != null),
        assert(map['option4'] != null),
        assert(map['questionAnswer'] != null),
        assert(map['id'] != null),
        //name = map['name'],
        questionText = map['questionText'],
        option1 = map['option1'],
        option2 = map['option2'],
        option3 = map['option3'],
        option4 = map['option4'],
        questionAnswer = map['questionAnswer'],
        id = map['id'];
  //votes = map['votes'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$questionText:$questionAnswer>";
}
