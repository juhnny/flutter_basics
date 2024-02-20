import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: HomeScreen()
      ),
    );
  }
}

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  _dialog(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Title'),
            content: Text("Content"),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text('OK')
              ),
            ],
          );
        }
    );
  }

  // 콘텐츠를 더욱 추가한 다이얼로그
  _dialog2(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Title'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(),
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value){}),
                    Text('수신동의')
                  ],
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text('CANCEL')
              ),
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text('IGNORE')
              ),
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text('OK')
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: _dialog,
              child: Text('Show Dialog')
          ),
          ElevatedButton(
              onPressed: _dialog2,
              child: Text('Show Dialog2')
          ),
        ],
      ),
    );
  }
}