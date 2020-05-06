import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:em_school/main.dart';
import 'package:flutter/material.dart';

class QuestionBank {
  int _questionNumber = 0;
  //QuestionBank({Key key}) : super(key: key);
  Firestore fdb = Firestore.instance;
  int length;

  List<Map<dynamic, dynamic>> _questionBank = [];
  Map<dynamic, dynamic> questionMap = {};

  //List<DocumentSnapshot> docList = [];
  getQuestionBank() => _questionBank;
  QuestionBank() {
    buildQuestion();
  }
  CollectionReference collectionReference;
  Future<void> buildQuestion() async {
    collectionReference = fdb.collection('bcss');
    final allDocs = await fdb.collection("bcss").getDocuments();
    length = allDocs.documents.length;
    collectionReference
        .snapshots()
        .listen((data) => data.documents.forEach((doc) {
              //_questionBank.add(doc["questionText"]);
              /* _questionBank.add(doc["option1"]);
              _questionBank.add(doc["option2"]);
              _questionBank.add(doc["option3"]);
              _questionBank.add(doc["option4"]);
              _questionBank.add(doc["questionAnswer"]); */
              /* questionMap.map(doc["questionText"]);
              questionMap.map(doc["option1"]);
              questionMap.map(doc["option2"]);
              questionMap.map(doc["option3"]);
              questionMap.map(doc["option4"]);
              questionMap.map(doc["questionAnswer"]); */
            }));

    await collectionReference.document('1').get().then((DocumentSnapshot ds) {
      questionMap.map(ds.data["questionText"]);
      questionMap.map(ds["option1"]);
      questionMap.map(ds["option2"]);
      questionMap.map(ds["option3"]);
      questionMap.map(ds["option4"]);
      questionMap.map(ds["questionAnswer"]);
      //print(ds['option1']);
      // use ds as a snapshot
      //docList.add(ds);
    });
    for (int i = 1; i <= length; i++) {
      collectionReference.document('$i').get().then((DocumentSnapshot ds) {
        /* questionMap.map(ds["questionText"]);
        questionMap.map(ds["option1"]);
        questionMap.map(ds["option2"]);
        questionMap.map(ds["option3"]);
        questionMap.map(ds["option4"]);
        questionMap.map(ds["questionAnswer"]); */
        //print(ds['option1']);
        // use ds as a snapshot
        //docList.add(ds);
      });
    }
  }

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNumber]['questionText'];
  }

  String getOptionText1() {
    return _questionBank[_questionNumber]['option1'];
  }

  String getOptionText2() {
    return _questionBank[_questionNumber]['option2'];
  }

  String getOptionText3() {
    return _questionBank[_questionNumber]['option3'];
  }

  String getOptionText4() {
    return _questionBank[_questionNumber]['option4'];
  }

  String getCorrectAnswer() {
    return _questionBank[_questionNumber]['questionAnswer'];
  }

  //TODO: Step 3 Part A - Create a method called isFinished() here that checks to see if we have reached the last question. It should return (have an output) true if we've reached the last question and it should return false if we're not there yet.

  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      //TODO: Step 3 Part B - Use a print statement to check that isFinished is returning true when you are indeed at the end of the quiz and when a restart should happen.

      print('Now returning true');
      return true;
    } else {
      return false;
    }
  }

  //TODO: Step 4 part B - Create a reset() method here that sets the questionNumber back to 0.
  void reset() {
    _questionNumber = 0;
  }
}
