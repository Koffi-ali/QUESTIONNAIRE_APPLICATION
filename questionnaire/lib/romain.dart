import 'package:flutter/material.dart';

final packet = <Map>[
  {
    'question': ['Nom', 'Prénom', 'Age'],
    'answer': [],
    'next': {'222': 1, 'default': 2}
  },
];

class Romain extends StatefulWidget {
  const Romain({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<Romain> {
  bool allFormsValid = true;
  List<TextEditingController> controllers = [];
  int numbofform = 0;
  int numbofcontroller = packet[0]['question'].length;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < packet[0].length; i++) {
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Form Widget'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: packet[0]['question'].length,
                itemBuilder: (context, index) {
                  return Form(
                    child: Column(
                      children: <Widget>[
                        Text(
                          packet[0]['question'][index],
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
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Text(
              allFormsValid
                  ? ""
                  : "Vous devez remplir toutes les cases du formulaire",
              style: TextStyle(color: Colors.red),
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
                  for (var controller in controllers) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(controller.text),
                        );
                      },
                    );
                  }
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String allFormData = "";
          for (var controller in controllers) {
            allFormData += "${controller.text}, ";
          }

          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(allFormData),
              );
            },
          );
        },
        tooltip: 'Show Form Data',
        child: Icon(Icons.text_fields),
      ),
    );
  }
}
