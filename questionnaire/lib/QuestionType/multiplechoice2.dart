import 'package:flutter/material.dart';
import 'package:questionnaire/QuestionType/questiontype.dart';

class MultipleChoice2 extends Questiontype {
  final Map? p;
  const MultipleChoice2({super.key, required this.p});

  @override
  Map<String, String> get getVariable => _MultipleChoice2State.variables;

  @override
  set setVariable(Map<String, String> variable) {
    _MultipleChoice2State.variables = variable;
    _MultipleChoice2State.isQuestionAnswered = true;  
  }

  @override
  State<MultipleChoice2> createState() => _MultipleChoice2State();
}

class _MultipleChoice2State extends State<MultipleChoice2> {
  static Map<String, String> variables = {};
  int n = 0;
  static bool isQuestionAnswered = false;
  List<String> selectedOptionType2 = [];
  List<int> selectedOptionType2Int = [];

  List <int> formatanswer(int nbReponses, List <int> l){
    List <int> list=List<int>.filled(nbReponses, 0);
    for(int elem in l){
        list[elem]=1;
    }
    return list;
 }
  void answerMultipleChoice2(bool value, String answer, int answerIndex) {
    setState(() {
      if (value) {
        selectedOptionType2.add(answer);
        variables[answer]='1';
        selectedOptionType2Int.add(answerIndex);
      } else {
        selectedOptionType2.remove(answer);
        variables[answer]='0';
        selectedOptionType2Int.remove(answerIndex);
      }
      isQuestionAnswered = true;
    });
  }

  Widget afficheQuestion() {
    if (isQuestionAnswered) {
      isQuestionAnswered = false;
    } else {
      n = widget.p?['answers']!.length;
      variables = {};
      for (int i = 0; i < widget.p?['answers']!.length; i++) {
        variables['${widget.p?['answers'][i]['answerText']}'] = '0';
      }
    }
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
    return Column(
      children: [
        afficheQuestion(),
        Column(
          children: (widget.p!['answers'] as List<Map<String, Object>>)
              .map((answer) => Checkboxfield(
                  answer: (answer['answerText'] as String),
                  selectedOptionType2: variables.entries
                                       .where((entry)=> entry.value=='1')
                                       .map((entry)=>entry.key)
                                       .toList(),
                  selectedOptionType2Int: selectedOptionType2Int,
                  index: (answer['index'] as int),
                  answerCheckboxfield: (p0, s, w) {
                    answerMultipleChoice2(p0, (answer['answerText'] as String),
                        (answer['index'] as int));
                  }))
              .toList(),
        ),
        Text('$variables'),
      ],
    );
  }
}

class Checkboxfield extends StatelessWidget {
  final String answer;
  final int index;
  final List<String> selectedOptionType2;
  final List<int?> selectedOptionType2Int;
  final Function(bool, String, int?) answerCheckboxfield;
  const Checkboxfield(
      {super.key,
      required this.answer,
      required this.answerCheckboxfield,
      required this.selectedOptionType2,
      required this.selectedOptionType2Int,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(answer),
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Colors.green,
      value: selectedOptionType2.contains(answer),
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(30)),
      onChanged: (value) => answerCheckboxfield(value ?? false, answer, index),
    );
  }
}
