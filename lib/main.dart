import 'dart:math';
import 'package:flutter/material.dart';
import 'KataLima.dart' as lima;

void main(){
  runApp(mainApp());
}


class mainApp extends StatelessWidget{
  mainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Align(
              alignment: Alignment.center,
              child: Text("TEBAK KATA"),
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

  String kata = lima.data.kata[Random().nextInt(95)];
  @override
  State<body> createState() {
    return bodyState(kata);
  }
}
class bodyState extends State<body>{
  bodyState(this.kata);
  String kata;
  int barisKe = 0;
  bool benar = false;
  List<Widget> rows = [
    Row(spacing: 10, children: [Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white)]),
    Row(spacing: 10, children: [Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white)]),
    Row(spacing: 10, children: [Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white)]),
    Row(spacing: 10, children: [Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white)]),
    Row(spacing: 10, children: [Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white)]),
    Row(spacing: 10, children: [Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white)]),
  ];

  void CheckJawaban(String result){
    List<String> jawaban = this.kata.split(""); // memar
    List<String> elimResult = result.split(""); // mmear
    setState(() {
      List<Kotak> newKotak = [];
      for (int i = 0; i < 5; i++){
        if(result[i] == this.kata[i]){
          newKotak.add(Kotak(result[i], Colors.green));
          jawaban[i] = "0";
          elimResult[i] = "0";
        } else{
          newKotak.add(Kotak(result[i], Colors.red));
        }
      }
      // 0em00 0me00
      // kuning
      for(int j = 0; j < 5; j++){
        if(jawaban[j] == "0"){
          continue;
        }
        for(int e = 0; e < 5; e++){
          if(elimResult[e] == "0"){
            continue;
          } else {
           if (jawaban[j] == elimResult[e]){
             newKotak[e] = Kotak(elimResult[e], Colors.yellow);
           }
          }
        }
      }
      var newRow = Row(spacing: 10, children: newKotak);
      rows[barisKe] = newRow;
      barisKe++;

      if (result == this.kata || barisKe == this.rows.length){
        this.benar = true;
      }
    });
  }

  List<Widget> returnRows(){
   List<Widget> data = [];
   // data.add(Text(this.kata));         // cheatCode
   for (var d in rows){
     data.add(d);
   }
   if(this.benar == true) {
     data.add(Text(this.kata));
     data.add(
         TextButton(
             onPressed: () {
               setState(() {
                 for (int i = 0; i < this.rows.length; i++){
                   this.rows[i] = Row(spacing: 10, children: [Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white), Kotak(" ", Colors.white)]);
                 }
                 this.barisKe = 0;
                 this.benar = false;
                 this.kata = lima.data.kata[Random().nextInt(95)];
               });
             },
             child: Text("main lagi"))
     );
   } else {
     data.add(inputGuess((String data){
       CheckJawaban(data);
     }));
   }
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
            iconSize: 50,
            icon: Icon(Icons.arrow_circle_up)
        ),
      ],
    );
  }
}
