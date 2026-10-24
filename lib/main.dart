import 'dart:math';
import 'package:flutter/material.dart';
import 'KataLima.dart';

void main(){
  runApp(MainApp());
}


class MainApp extends StatelessWidget{

  MainApp({super.key});
  static String kata = data.kata[Random().nextInt(100)];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.center,
            child: Text(kata),                  // fix me
          ),
        ),
        body: Center(
          child: body(),
        )
      ),
    );
  }
}


class body extends StatefulWidget{
  body({super.key});

  @override
  State<body> createState() {
    return BodyState();
  }

}

class BodyState extends State<body>{
  int barisKe = 0;
  List<Widget> rows = [
    Row(spacing: 10, children: [Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white)]),
    Row(spacing: 10, children: [Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white)]),
    Row(spacing: 10, children: [Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white)]),
    Row(spacing: 10, children: [Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white)]),
    Row(spacing: 10, children: [Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white)]),
  ];

  void CheckJawaban(String result){
    setState(() {
      List<Kotak> newKotak = [];

      for (int i = 0; i < rows.length; i++){
        if(result[i] == MainApp.kata[i]){
          newKotak.add(Kotak(result[i], Colors.green));
        } else{
          newKotak.add(Kotak(result[i], Colors.red));
        }
      }
      var newRow = Row(spacing: 10, children: newKotak);
      rows[barisKe] = newRow;
      barisKe++;
    });
  }

  List<Widget> returnRows(){
   List<Widget> data = [];
   for (var d in rows){
     data.add(d);
   }
   data.add(inputGuess((String data){
     CheckJawaban(data);
   }));
   return data;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        spacing: 20,
        children: returnRows()
      ),
    );
  }
}

class Kotak extends StatelessWidget{

  Kotak(this.huruf, this.warna, {super.key});
  String huruf;
  Color warna;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
         border: Border.all(color: Colors.black45),
        color: this.warna
      ),
      child: Center(
        child: Text(huruf[0].toUpperCase()),
      ),
    );
  }
}

class inputGuess extends StatefulWidget{
  inputGuess(this.fungsi);
  void Function(String) fungsi;
  State<inputGuess> createState() {
    return inputGuessState(this.fungsi);
  }

}

class inputGuessState extends State<inputGuess>{
  inputGuessState(this.fungsi);
  void Function(String) fungsi;
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            maxLength: 5,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                )
            ),
            controller: textEditingController,
            focusNode: focusNode,
            autofocus: true,
          ),
        ),
        IconButton(
            onPressed: () {
              this.fungsi(textEditingController.text.trim());
              textEditingController.clear();
              focusNode.requestFocus();
            },
            icon: Icon(Icons.arrow_circle_up)
        ),
      ],
    );
  }
}
