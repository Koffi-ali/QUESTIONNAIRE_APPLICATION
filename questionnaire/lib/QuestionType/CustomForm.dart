import 'package:flutter/material.dart';
import 'package:questionnaire/QuestionType/questiontype.dart';

class CustomForm extends Questiontype {
  final Map? p;
  const CustomForm({Key? key, required this.p}) : super(key: key);

  @override
  Map<String, String> get getVariable => MyCustomFormState.variables;

  @override
  set setVariable(Map<String, String> variable) {
    MyCustomFormState.variables = variable;
  }

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<CustomForm> {
  bool allFormsValid = true;
  static Map<String, String> variables = {};
  List<TextEditingController> controllers = [];
  int numbofform = 0;

  @override
  void initState() {
    super.initState();
    print("Number of controllers : ${widget.p!["question"].length} ");
    for (int i = 0; i < widget.p!["question"].length; i++) {
      controllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print("${controllers[0]} / ${controllers[1]} /${controllers[2]}");
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Column(
              children: List.generate(widget.p!['question'].length, (index) {
                return Form(
                  child: Column(
                    children: <Widget>[
                      Text(
                        widget.p!['question'][index],
                        style: TextStyle(fontSize: 14),
                      ),
                      TextFormField(
                        controller: controllers[index],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            variables[widget.p!['question'][index]] = value;
                          });
                        },
                      ),
                    ],
                  ),
                );
              }),
            ),
            Text(
              "${controllers[0].text} / ${controllers[1].text} /${controllers[2].text} /// ${variables}",
              style: TextStyle(fontSize: 14),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  allFormsValid = true;
                });

                for (var form in controllers) {
                  if (form.text.isEmpty) {
                    //Renvoyer un message d'erreur
                    setState(() {
                      allFormsValid = false;
                    });

                    break;
                  }
                }
                print(allFormsValid);
                if (allFormsValid) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                  /*for (var controller in controllers) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(controller.text),
                        );
                      },
                    );
                  }*/
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
