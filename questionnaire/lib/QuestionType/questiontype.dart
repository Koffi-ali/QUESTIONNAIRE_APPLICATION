import 'package:flutter/material.dart';

abstract class Questiontype extends StatefulWidget {
  const Questiontype({ Key? key }) : super(key: key);

  Map<String, String> get getVariable;
  set setVariable(Map<String, String> variable);

  @override
  State<Questiontype> createState() => _QuestiontypeState();
}

class _QuestiontypeState extends State<Questiontype> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}