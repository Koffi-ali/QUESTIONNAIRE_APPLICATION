import 'package:flutter/material.dart';
import 'questionnaire.dart';
import 'thomas.dart';
import 'romain.dart';

class Home extends StatefulWidget {
const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> pages =  [
    Questionnaire(),
    Thomas(),
    Romain(),
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: GridView.count(
        primary: false,
        padding: EdgeInsets.all(15),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        children: [
          QForm(
            title: 'questionnaire 1', 
            c: Colors.orange, 
            wdg: Questionnaire(),
          ),
          QForm(
            title: 'Thomas', 
            c: Colors.cyan, 
            wdg: Thomas(),
          ),
          QForm(
            title: 'Romain', 
            c: Colors.purple, 
            wdg: Romain(),
          ),
          QForm(
            title: 'Ali', 
            c: Colors.green, 
            wdg: Romain(),
          ),
        ],
      ),
    );
  }
}

class QForm extends StatelessWidget {
const QForm({ Key? key, required this.title, required this.c, required this.wdg }) : super(key: key);
  final String title;
  final Color c;
  final Widget wdg;

  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => wdg),)},
      child: Container(
        padding: const EdgeInsets.all(8),
        color: c,
        child: Text(title),
      ),
    );
  }
}