import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

// 기본축과 교차축 main axi, cross axis
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Stack'
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Text('Stack'),
              Container(
                color: Colors.grey,
                child: Stack(
                  children: [
                     Container(width: 200, height: 100, color: Colors.red,),
                     Container(width: 100, height: 60, color: Colors.green,),
                     Container(width: 50, height: 30, color: Colors.blue,),
                  ],
                ),
              ),

              // IndexedStack
              // Stack은 여러 위젯을 겹쳐 보여주지만, IndexedStack은 하나만 보여준다.
              Text('IndexedStack'),
              Container(
                color: Colors.grey,
                child: IndexedStack(
                  index: 1,
                  children: [
                    Container(width: 200, height: 100, color: Colors.red,),
                    Container(width: 100, height: 60, color: Colors.green,),
                    Container(width: 50, height: 30, color: Colors.blue,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}