import 'package:flutter/material.dart';

final json = <Map>[{"Title" : "Comment allez vous ?" , "response" :[0xf518,0xf519,0xf520,0xf521,0xf517]}] ;

class Thomas extends StatefulWidget {
  const Thomas({super.key});

  @override
  State<Thomas> createState() => _Thomas();
}

class _Thomas extends State<Thomas> {
  int selectedImage = -1;

  Widget customButton(int indexNumber, int index) {
    return IconButton(
        onPressed: () {
          setState(() {
            selectedImage = index;
            print(selectedImage);
          });
        },
        icon: Icon(IconData(indexNumber, fontFamily: 'MaterialIcons')),
        color: ((selectedImage == index)
            ? Color.fromARGB(255, 0, 255, 0)
            : Color.fromARGB(255, 255, 0, 0)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child:Text(json[0]["Title"], textAlign: TextAlign.center))
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var i = 0 ; i< json[0]["response"].length ; i++)
                Expanded(
                  flex: 3,
                  child: customButton(json[0]["response"][i], i),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
