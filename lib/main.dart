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
          child: BodyStatefull(),
        )
      ),
    );
  }
}


class BodyStatefull extends StatefulWidget{
  BodyStatefull({super.key});

  @override
  State<BodyStatefull> createState() {
    return Body();
  }

}
class Body extends State<BodyStatefull>{

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

      for (int i = 0; i < 5; i++){
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

  List<Widget> ReturnRows(){
   List<Widget> data = [];
   for (var d in rows){
     data.add(d);
   }
   data.add(InputGuess(fungsi: (data) {
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
        children: ReturnRows()
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

class InputGuess extends StatelessWidget{
  InputGuess({super.key,required this.fungsi});
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
            fungsi(textEditingController.text.trim());
            textEditingController.clear();
            focusNode.requestFocus();
            },
              icon: Icon(Icons.arrow_circle_up)
          ),
        ],
    );
  }
}
