import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;

  List<Question> _questionBank = [
    Question('Which is the capital of Bangladesh?', 'North Dhaka',
        'South Dhaka', 'Dhaka', 'Jahangirnagar', 'Dhaka'),
    Question('Bangladesh became independent in---', '1969', '1971', '1972',
        '1975', '1971'),
    Question('What is the Independent Day of Bangladesh?.', '16 December',
        '21 February', '7 March', '26 March', '26 March'),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  String getOptionText1() {
    return _questionBank[_questionNumber].option1;
  }

  String getOptionText2() {
    return _questionBank[_questionNumber].option2;
  }

  String getOptionText3() {
    return _questionBank[_questionNumber].option3;
  }

  String getOptionText4() {
    return _questionBank[_questionNumber].option4;
  }

  String getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
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
