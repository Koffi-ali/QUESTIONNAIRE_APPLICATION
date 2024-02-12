import 'package:flutter/material.dart';
import 'package:questionnaire/QuestionType/dichotomous1.dart';
import 'package:questionnaire/QuestionType/multiplechoice2.dart';
import 'package:questionnaire/QuestionType/questiontype.dart';
import 'package:questionnaire/QuestionType/matrix3.dart';

final packet = <Map>[
  {
    'type': 1,
    'question': 'Pratiquez-vous un sport ?',
    'answers': [
      {'answerText': "oui", 'index': 0},
      {'answerText': "non", 'index': 1},
    ],
    'list_answer': '',
    'next': {'1': 1, '0': 2},
  },
  {
    'type': 3,
    'question': [
      'notez votre appréciation dddddddddddddddddddddddddddddddd?',
      'how was the service ?',
      'coucou ?'
    ],
    'answer': ['bad', 'neutral', 'good'],
    'next': {'222': 1, '000': 0, '111': 3, 'default': 2}
  },
  {
    'type': 3,
    'question': ['hello ?', 'deuxième phase'],
    'answer': ['bad', 'neutral', 'good'],
    'next': {'22': 1, 'default': 2}
  },
  {
    'type': 2,
    'question': 'Qu\'est-ce que vous aimez faire pendant vos temps libres ?',
    'answers': [
      {'answerText': "Dormir", 'index': 0},
      {'answerText': "Ciné", 'index': 1},
      {'answerText': "Plage", 'index': 2},
    ],
    'next': {
      '000': 4,
      '001': 1,
      '010': 2,
      '011': 3,
      '100': 2,
      '101': 1,
      '110': 0,
      '111': 0
    },
  },
  {
    'type': 2,
    'question': 'Comment avez-vous trouvez ce questionnaire?',
    'answers': [
      {'answerText': "Bien", 'index': 0},
      {'answerText': "Moyen", 'index': 1},
      {'answerText': "Beauf", 'index': 2},
    ],
    'next': {
      '000': 4,
      '001': 1,
      '010': 2,
      '011': 3,
      '100': 2,
      '101': 1,
      '110': 0,
      '111': 0
    },
  }
];

Questiontype printW(Map p) {
  switch (p['type']) {
    case 1:
      return Dichotomous1(p: p);
    case 2:
      return MultipleChoice2(p: p);
    default:
      return Matrix3(
        p: p,
      );
  }
}

class Questionnaire extends StatefulWidget {
  const Questionnaire({Key? key}) : super(key: key);
  @override
  State<Questionnaire> createState() => _QuestionnaireState();
}

class _QuestionnaireState extends State<Questionnaire> {
  int indQuestion = 0;
  bool error = false;
  late Questiontype question = printW(packet[indQuestion]);
  Map<String, String> answer = {};
  List<Map<String, String>> res = [];
  List<int> previousIndex = [];

  void nextq(Map<String, int> next) {
    setState(() {
      String s = '';
      bool isin = false;
      int currInd = indQuestion;
      answer = question.getVariable;
      for (String aws in answer.values) {
        s = s + aws;
      }
      if (s.contains('-')) {
        throw Exception('error -1: unanswered question');
      }
      for (var i in next.keys) {
        if (s == i) {
          print('in next');
          isin = true;
          indQuestion = next[s.toString()]!;
        }
      }
      if (isin == false) {
        print('in default');
        indQuestion = next['default']!;
      }
      error = false;
      previousIndex.add(currInd);
      answer['id'] = currInd.toString();
      res.add(answer);
      question = printW(packet[indQuestion]);
      print('previousIndex: $previousIndex');
      print('res: $res');
    });
  }

  void previousq() {
    setState(() {
      indQuestion =(previousIndex.isNotEmpty) ? previousIndex.removeLast() : indQuestion;
      Map<String, String> prevres = res.isNotEmpty ? res.removeLast() : {};
      error = false;
      question = printW(packet[indQuestion]);
      prevres.removeWhere((key, value) => key == "id");
      question.setVariable = prevres;
      print(question.getVariable);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('questionnaire 1'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          question,
          error
              ? Text('Error', style: TextStyle(color: Colors.red))
              : SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (indQuestion != 0)
              
                ElevatedButton.icon(
                  onPressed: () {
                    previousq();
                  },
                  icon: Icon(Icons.arrow_back),
                  label: Text("Previous"),
                ),
              if (indQuestion != 0)
                SizedBox(
                  width: 30,
                ),
                (indQuestion!=packet.length-1)?
                ElevatedButton.icon(
                  onPressed: () {
                    try {
                      nextq(packet[indQuestion]['next']);
                    } catch (e) {
                      setState(() {
                        error = true;
                      });
                      print(e);
                    }
                  },
                  icon: Icon(Icons.arrow_forward),
                  label: Text("Next"),
                ):
                 ElevatedButton.icon(
                  onPressed: () {
                  },
                  icon: Icon(Icons.check),
                  label: Text("Confirm"),
                ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text('data: $answer'),
        ],
      ),
    );
  }
}
