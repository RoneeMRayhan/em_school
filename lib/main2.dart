import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:em_school/add_question.dart';
import 'package:em_school/question.dart';
import 'package:em_school/question_bank.dart';
import 'package:flutter/material.dart';
//TODO: Step 2 - Import the rFlutter_Alert package here.
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();
//QuestionBank questionBank;

void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  //final questionBank = QuestionBank();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void checkAnswer(String userPickedAnswer) {
    String correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      //TODO: Step 4 - Use IF/ELSE to check if we've reached the end of the quiz. If so,
      //On the next line, you can also use if (quizBrain.isFinished()) {}, it does the same thing.
      if (quizBrain.isFinished() == true) {
        //TODO Step 4 Part A - show an alert using rFlutter_alert,

        //This is the code for the basic alert from the docs for rFlutter Alert:
        //Alert(context: context, title: "RFLUTTER", desc: "Flutter is awesome.").show();

        //Modified for our purposes:
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();

        //TODO Step 4 Part C - reset the questionNumber,
        quizBrain.reset();

        //TODO Step 4 Part D - empty out the scoreKeeper.
        scoreKeeper = [];
      }

      //TODO: Step 6 - If we've not reached the end, ELSE do the answer checking steps below 👇
      else {
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizBrain.nextQuestion();
      }
    });
  }

  Future<void> pushData() {
    Firestore.instance
        .collection('talks')
        .document()
        .setData({'title': 'titleww', 'author': 'author'});
    return null;
  }

  String s = 'demo';
  List<String> sList = ['sss'];
  Map<String, dynamic> sMap = {};
  Future<void> getData() {
    /* Firestore.instance
        .collection('talks')
        .document()
        .get()
        .then((DocumentSnapshot ds) {
      s = ds['author'].toString();

      // use ds as a snapshot
    }); */
    Firestore.instance
        .collection('talks')
        //.where("topic", isEqualTo: "flutter")
        .snapshots()
        .listen(
            (data) => data.documents.forEach((doc) => sList.add(doc["title"])));

    return null;
  }

  @override
  void initState() {
    // TODO: implement initState

    //questionBank = QuestionBank();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pushData();
    getData();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                // s,
                sList[1],
                //quizBrain.getQuestionText(),

                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.amber,
              child: Text(
                quizBrain.getOptionText1(),
                //questionBank.getOptionText1(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkAnswer(quizBrain.getOptionText1());
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.cyan,
              child: Text(
                quizBrain.getOptionText2(),
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                getData();
                //The user picked false.
                checkAnswer(quizBrain.getOptionText2());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddQuestion(),
                  ),
                );
                print(sList);
                print(Firestore);
                print(Firestore.instance);
                print(Firestore.instance.collection('talks'));
                print(Firestore.instance.collection('talks').document());
                print(Firestore.instance.collection('talks').document().get());
                print(Firestore.instance
                    .collection('talks')
                    .document()
                    .get()
                    .then((DocumentSnapshot ds) => print(ds)));
                print(Firestore.instance
                    .collection('talks')
                    .document()
                    .get()
                    .then((DocumentSnapshot ds) => print(ds.data)));

                print(Firestore.instance
                    .collection('talks')
                    //.where("topic", isEqualTo: "flutter")
                    .snapshots()
                    .listen((data) =>
                        data.documents.forEach((doc) => print(doc["title"]))));
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.lime,
              child: Text(
                quizBrain.getOptionText3(),
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(quizBrain.getOptionText3());
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.orange,
              child: Text(
                quizBrain.getOptionText4(),
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(quizBrain.getOptionText4());
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.orange,
              child: Text(
                'print',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                QuestionBank questionBank = QuestionBank();
                /* questionBank.collectionReference.snapshots().listen((data) =>
                    data.documents
                        .forEach((doc) => print(doc["questionText"]))); */

                print(questionBank.questionMap.values.toString());

                /* for (int id = 1; id <= questionBank.length; id++) {
                  questionBank.collectionReference
                      .document('$id')
                      .get()
                      .then((DocumentSnapshot ds) {
                    print(ds['option1']);

                    // use ds as a snapshot
                  });
                } */
                //print(questionBank.getQuestionBank());
                //print(questionBank.docList);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
