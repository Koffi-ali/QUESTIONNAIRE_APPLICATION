import 'package:flutter/material.dart';
import 'package:questionnaire/QuestionType/questiontype.dart';

class Dichotomous1 extends Questiontype {
  final Map? p;
  const Dichotomous1({super.key, required this.p});

  @override
  Map<String, String> get getVariable => _Dichotomous1State.variables;

  @override
  set setVariable(Map<String, String> variable) {
    _Dichotomous1State.variables = variable;
    _Dichotomous1State.isQuestionAnswered = true;
  }

  @override
  State<Dichotomous1> createState() => _Dichotomous1State();
}

class _Dichotomous1State extends State<Dichotomous1> {
  static Map<String, String> variables = {'answer': '-1'};
  List<int> previousIndex = [];
  static bool isQuestionAnswered = false;
  String? selectedOptionType1;
  int selectedOptionType1Int = 0;

  void answerDichotomous1(String? value, int answerIndex) {
    setState(() {
      selectedOptionType1 = value;
      selectedOptionType1Int = answerIndex;
      variables['answer'] = answerIndex.toString();
      isQuestionAnswered = true;
    });
  }

  Widget afficheQuestion() {
    return Container(
        width: double.infinity,
        height: 130,
        margin: EdgeInsets.only(bottom: 10, left: 0, right: 0),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            (widget.p!['question'] as String),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (isQuestionAnswered) {
      isQuestionAnswered = false;
    } else {
      variables = {'answer': '-1'};
    }
    return Column(
      children: [
        afficheQuestion(),
        Column(
          children: (widget.p!['answers'] as List<Map<String, Object>>)
              .map((answer) => Radiofield(
                  answer: (answer['answerText'] as String),
                  selectedOption:(variables['answer'] as String) !='-1'?(widget.p!['answers'])[int.parse(variables['answer'] as String)]['answerText']:null,
                  index: (answer['index'] as int),
                  answerRadiofield: (p0, v) {
                    answerDichotomous1(p0, (answer['index'] as int));
                  }))
              .toList(),
        ),
        Text('$variables'),
      ],
    );
  }
}

class Radiofield extends StatelessWidget {
  final String answer;
  final String? selectedOption;
  final int index;
  final Function(String?, int) answerRadiofield;
  const Radiofield(
      {super.key,
      required this.answer,
      required this.answerRadiofield,
      required this.selectedOption,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      title: Text(answer),
      value: answer,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(30)),
      groupValue: selectedOption,
      onChanged: (value) => answerRadiofield(value, index),
    );
  }
}
