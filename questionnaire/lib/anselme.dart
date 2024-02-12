import 'package:flutter/material.dart';

final questions1 = [
  {
    'type': 1,
    'index': 0,
    'question': 'Pratiquez-vous un sport ?',
    'answers': [
      {'answerText': "oui", 'index': 0},
      {'answerText': "non", 'index': 1},
    ],
    'list_answer': '',
    'next': {'10': 1, '01': 4},
  },
  {
    'type': 2,
    'index': 1,
    'question': 'Selectionnez les sports que vous pratiquez ?',
    'answers': [
      {'answerText': "Football", 'index': 0},
      {'answerText': "Volley-Ball", 'index': 1},
      {'answerText': "Basketball", 'index': 2},
    ],
    'list_answer': '',
    'next': {
      '000': 4,
      '001': 3,
      '010': 4,
      '011': 3,
      '100': 2,
      '101': 2,
      '110': 2,
      '111': 4
    },
    'previous': 0
  },
  {
    'type': 1,
    'index': 2,
    'question': 'Quel est votre joueur préféré?',
    'answers': [
      {'answerText': "Messi", 'index': 0},
      {'answerText': "Ronaldo", 'index': 1},
      {'answerText': "neymar", 'index': 2},
    ],
    'list_answer': '',
    'next': {'001': 4, '010': 4, '100': 4},
    'previous': 1
  },
  {
    'type': 1,
    'index': 3,
    'question': 'Quel votre équipe préférée?',
    'answers': [
      {'answerText': "Lakers", 'index': 0},
      {'answerText': "Spurs", 'index': 1},
      {'answerText': "Golden States", 'index': 2},
    ],
    'list_answer': '',
    'next': {'001': 4, '010': 4, '100': 4},
    'previous': 1
  },
  {
    'type': 1,
    'index': 4,
    'question': 'Jouez-vous à la play ?',
    'answers': [
      {'answerText': "oui", 'index': 0},
      {'answerText': "non", 'index': 1},
    ],
    'list_answer': '',
    'next': {'10': 5, '01': 6},
    'previous': 0
  },
  {
    'type': 2,
    'index': 5,
    'question': 'Quels jeux jouez-vous ?',
    'answers': [
      {'answerText': "Fifa 22", 'index': 0},
      {'answerText': "naruto", 'index': 1},
      {'answerText': "God of War", 'index': 2},
    ],
    'list_answer': '',
    'next': {
      '000': 6,
      '001': 6,
      '010': 6,
      '011': 6,
      '100': 6,
      '101': 6,
      '110': 6,
      '111': 6
    },
    'previous': 4
  },
  {
    'type': 2,
    'index': 6,
    'question': 'Qu\'est-ce que vous aimez faire pendant vos temps libres ?',
    'answers': [
      {'answerText': "Dormir", 'index': 0},
      {'answerText': "Ciné", 'index': 1},
      {'answerText': "Plage", 'index': 2},
    ],
    'list_answer': '',
    'next': {
      '000': 10,
      '001': 10,
      '010': 10,
      '011': 10,
      '100': 10,
      '101': 10,
      '110': 10,
      '111': 10
    },
    'previous': 4
  }
];

class Anselme extends StatefulWidget {
  @override
  State<Anselme> createState() => _AnselmeState();
}

class _AnselmeState extends State<Anselme> {
  //String question = questions[0] as String;
  int indexQuestion = 0;
  List<int> previousIndex = [];
  bool isQuestionAnswered = false;
  String? selectedOptionType1;
  int selectedOptionType1Int = 0;
  List<String> selectedOptionType2 = [];
  List<int> selectedOptionType2Int = [];

  List<int> rangeAnswerDichotomous12(int nbReponses, List<int> l) {
    List<int> list = List<int>.filled(nbReponses, 0);
    for (int elem in l) {
      list[elem] = 1;
    }
    return list;
  }

  List<int> invRangeAnswerDichotomous12(String answer) {
    List<int> list = [];
    for (int i = 0; i < answer.length; i++) {
      (answer[i] == '1') ? list.add(i) : null;
    }
    return list;
  }

  void nextQuestion() {
    setState(() {
      //
      previousIndex.contains(indexQuestion)
          ? null
          : previousIndex.add(indexQuestion);
      print("liste of previous(next) index: $previousIndex");

      // récupération des réponses de l'utilisateur

      switch (questions1[indexQuestion]['type']) {
        case 2:
          selectedOptionType2Int.sort();
          int nbReponses = (questions1[indexQuestion]['answers']
                  as List<Map<String, Object>>)
              .length;
          selectedOptionType2Int =
              rangeAnswerDichotomous12(nbReponses, selectedOptionType2Int);
          //List <int> t=invRangeAnswerDichotomous12(selectedOptionType2Int.join().toString());
          print(
              'selectedOptionType2Int dans le nextQuestion: $selectedOptionType2Int ');
          questions1[indexQuestion]["list_answer"] =
              selectedOptionType2Int.join().toString();
          //(questions1[indexQuestion]["answers"] as List<Map<String,Object>>)["list_answer"]=[];
          break;
        case 1:
          List<int> l = [];
          l.add(selectedOptionType1Int);
          int nbReponses = (questions1[indexQuestion]['answers']
                  as List<Map<String, Object>>)
              .length;
          l = rangeAnswerDichotomous12(nbReponses, l);
          String selected = l.join().toString();
          print(
              'l: $l, selectedOptionType1Int: $selectedOptionType1Int, base10 : $selected ');
          questions1[indexQuestion]["list_answer"] = selected;
        default:
          break;
      }
      selectedOptionType2 =
          []; // mettre la liste des choix pour la questionn 2 à nul.
      selectedOptionType2Int =
          []; // mettre la liste des choix pour la questionn 2 à nul.

      // Gestion des indices des questions suivantes

      if (indexQuestion < questions1.length - 1) {
        String ans = questions1[indexQuestion]["list_answer"] as String;
        print("ans : $ans");
        int? ind = (questions1[indexQuestion]['next'] as Map<String, int>)[ans];
        print('index_next : $ind');
        if ((ind != null) && (ind < questions1.length)) {
          indexQuestion = ind;
        }
        switch (questions1[indexQuestion]['type']) {
          case 1:
            String answer = questions1[indexQuestion]['list_answer'] as String;
            if (invRangeAnswerDichotomous12(answer).isNotEmpty) {
              int index = invRangeAnswerDichotomous12(answer)[0];
              selectedOptionType1 = (questions1[indexQuestion]['answers']
                  as List<Map<String, Object>>)[index]['answerText'] as String;
            }
            break;
          case 2:
            String answer = questions1[indexQuestion]['list_answer'] as String;
            selectedOptionType2Int = invRangeAnswerDichotomous12(answer);
            break;
          default:
            break;
        }
      } else {
        print("excédent");
        print("QQuestion: $questions1");
      }
    });
  }

  void previousQuestion() {
    setState(() {
      //selectedOptionType2=[];
      if (indexQuestion > 0) {
        // index  de la question précédente
        int last = (previousIndex.isNotEmpty)
            ? previousIndex.removeLast()
            : indexQuestion;
        indexQuestion = last;
        print("liste of previous(previous) index: $previousIndex");

        switch (questions1[indexQuestion]['type']) {
          case 1:
            String answer = questions1[indexQuestion]['list_answer'] as String;
            int index = invRangeAnswerDichotomous12(answer)[0];
            selectedOptionType1 = (questions1[indexQuestion]['answers']
                as List<Map<String, Object>>)[index]['answerText'] as String;
            break;
          case 2:
            String answer = questions1[indexQuestion]['list_answer'] as String;
            selectedOptionType2Int = invRangeAnswerDichotomous12(answer);
            break;
          default:
            print("not case 1 or 2");
        }
      }
    });
  }

  void answerDichotomous1(String? value, int answerIndex) {
    setState(() {
      selectedOptionType1 = value;
      selectedOptionType1Int = answerIndex;
    });
  }

  void answerMultipleChoice2(bool value, String answer, int answerIndex) {
    setState(() {
      if (value) {
        selectedOptionType2.add(answer);
        selectedOptionType2Int.add(answerIndex);
      } else {
        selectedOptionType2.remove(answer);
        selectedOptionType2Int.remove(answerIndex);
      }
    });
  }

// Afficher les réponses à l'écran
/*
Widget affichageReponses(int index){
    switch(questions1[index]['type']){
        case 1:
            return Column(
              children:
              (questions1[index]['answers'] as List<Map<String,Object>>).map((answer)=>Dichotomous1(
                  answer:(answer['answerText'] as String),
                  selectedOption: selectedOptionType1,
                  index:(answer['index'] as int),
                  answerRadiofield: (p0,v) {
                    answerDichotomous1(p0,(answer['index'] as int));
                    print('selected value Type1: $selectedOptionType1');
                    print('selected value Type1 Int: $selectedOptionType1Int');
                  }
                  )
                ).toList(), 
              );
          
        case 2:
          //
          return Column(
            children:
            (questions1[index]['answers'] as List<Map<String,Object>>).map((answer)=>MultipleChoice2(
                    answer:(answer['answerText'] as String),
                    selectedOptionType2: selectedOptionType2,
                    selectedOptionType2Int: selectedOptionType2Int,
                    index:(answer['index'] as int),
                    answerMultipleChoice2: (p0,s,w) {
                      answerMultipleChoice2(p0,(answer['answerText'] as String),(answer['index'] as int));
                      //print('selected value Type2: $selectedOptionType2');
                      print('selected answer Type2 int : $selectedOptionType2Int');
                    }
                    )
            ).toList(),);
            
        default:
          return Column(children: [],);
          
    }
}
*/
  Widget afficheQuestion(int index) {
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
            (questions1[indexQuestion]['question'] as String),
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
    return Scaffold(
        appBar: AppBar(
          title: Text("Quizz"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          afficheQuestion(indexQuestion),
          //affichageReponses(indexQuestion),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                    onPressed: () {
                      previousQuestion();
                    },
                    icon: Icon(Icons.arrow_back),
                    label: Text("Previous")),
                SizedBox(
                  width: 30,
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      nextQuestion();
                    },
                    icon: Icon(Icons.arrow_forward),
                    label: Text("Next")),
              ],
            ),
          ),

          SizedBox(
            height: 30,
          ),
        ]));
  }
}
