import 'package:flutter/material.dart';
import 'package:questionnaire/QuestionType/questiontype.dart';

class Matrix3 extends Questiontype {
  final Map? p;
  const Matrix3({super.key, required this.p});

  @override
  Map<String, String> get getVariable => _Matrix3State.variables;
  @override
  set setVariable(Map<String, String> variable) {
    _Matrix3State.variables = variable;
    _Matrix3State.changed = true;
  }

  @override
  State<Matrix3> createState() => _Matrix3State();
}

class _Matrix3State extends State<Matrix3> {
  static Map<String, String> variables = {};
  int ind = 0;
  int n = 0;
  static bool changed = false;

  void select(i, String value) {
    setState(() {
      variables['q${i + 1}'] = value;
      changed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (changed) {
      changed = false;
    } else {
      n = widget.p?['answer']!.length;
      variables = {};
      for (int i = 0; i < widget.p?['question']!.length; i++) {
        variables['q${i + 1}'] = '-1';
      }
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: <Widget>[
          const SizedBox(height: 30),
          const Text('Please rate us for the below attributes',
              style: TextStyle(fontSize: 17)),
          const SizedBox(height: 50),
          IntrinsicHeight(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 2 * (n + 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(''),
                            const SizedBox(height: 10),
                          ],
                        ),
                        for (var q in widget.p?['question']!)
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(q, style: TextStyle(fontSize: 17)),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  for (var aws = 0; aws < widget.p?['answer'].length; aws++)
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Text(widget.p?['answer'][aws]),
                              const SizedBox(height: 10),
                            ],
                          ),
                          for (var i = 0; i < widget.p?['question'].length; i++)
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RadioButton(
                                      answer: variables['q${i + 1}'],
                                      value: aws.toString(),
                                      func: (val) => select(i, val)),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                ]),
          ),
          const SizedBox(height: 30),
          Text('Json: $variables', style: TextStyle(fontSize: 15)),
        ]),
      ),
    );
  }
}

class RadioButton extends StatefulWidget {
  final String? answer;
  final String value;
  final Function(String) func;
  const RadioButton(
      {super.key,
      required this.answer,
      required this.value,
      required this.func});

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  @override
  Widget build(BuildContext context) {
    return Radio(
        value: widget.value,
        groupValue: widget.answer,
        onChanged: (value) => widget.func(value!));
  }
}
