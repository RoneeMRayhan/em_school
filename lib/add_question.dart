import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:em_school/question_bank.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddQuestion extends StatefulWidget {
  AddQuestion({Key key}) : super(key: key);

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final GlobalKey<FormState> formKey = GlobalKey();
  String questionText, option1, option2, option3, option4, questionAnswer;
  Future<void> pushData() {
    final FormState form = formKey.currentState;

    if (form.validate()) {
      form.save();
      //form.reset();
      Fluttertoast.showToast(
          msg: "Data inserted successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => QuestionBank()));
      Firestore.instance.collection('bcs').document().setData({
        'questionText': questionText,
        'option1': option1,
        'option2': option2,
        'option3': option3,
        'option4': option4,
        'questionAnswer': questionAnswer,
      });
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a Question'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Question Text",
                  border: OutlineInputBorder(),
                ),
                onSaved: (val) => questionText = val,
                validator: (val) {
                  if (val.isEmpty) {
                    return "Title filled can't be empty";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Option1",
                  border: OutlineInputBorder(),
                ),
                onSaved: (val) => option1 = val,
                validator: (val) {
                  if (val.isEmpty) {
                    return "Body filled can't be empty";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Option2",
                  border: OutlineInputBorder(),
                ),
                onSaved: (val) => option2 = val,
                validator: (val) {
                  if (val.isEmpty) {
                    return "Body filled can't be empty";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Option3",
                  border: OutlineInputBorder(),
                ),
                onSaved: (val) => option3 = val,
                validator: (val) {
                  if (val.isEmpty) {
                    return "Body filled can't be empty";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Option4",
                  border: OutlineInputBorder(),
                ),
                onSaved: (val) => option4 = val,
                validator: (val) {
                  if (val.isEmpty) {
                    return "Body filled can't be empty";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Question Answer",
                  border: OutlineInputBorder(),
                ),
                onSaved: (val) => questionAnswer = val,
                validator: (val) {
                  if (val.isEmpty) {
                    return "Body filled can't be empty";
                  }
                  return null;
                },
              ),
            ),
            FloatingActionButton(
              onPressed: () => pushData(),
              child: Icon(Icons.add),
              tooltip: 'Add a Question',
            ),
          ],
        ),
      ),
    );
  }
}
