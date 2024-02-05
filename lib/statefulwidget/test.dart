import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics/statelesswidget/test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Stateful Widget"),
        ),
        body: MyWidget(),
      ),
    );
  }
}

class MyWidget extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _MyWidgetState();
  }
}

class _MyWidgetState extends State<MyWidget> {
  bool enable = false;
  String stateText = "disabled";

  void changeCheck() {
    setState(() {
      if(enable) {
        stateText = "disabled";
        enable = false;
      } else {
        stateText = "enabled";
        enable = true;
      }
    });
  }

   @override
  Widget build(BuildContext context) {
     return Center(
       child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           IconButton(
               onPressed: changeCheck,
               icon: (
                   enable ? Icon(Icons.check_box, size: 20,)
                   : Icon(Icons.check_box_outline_blank, size: 20,))),
           Text(
             "$stateText"
           )
         ],
       ),
     );
  }
}