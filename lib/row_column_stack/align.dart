import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

// Align
// 위젯의 위치를 독립적으로 설정할 때 사용할 수 있는 위젯으로 Align과 Positioned가 있음
// Align은 독립적으로 쓸 수 있고, Positioned는 Stack에서만 사용 가능
// Align의 위치는 부모 위젯 내에서의 상대적 위치
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Align'
          ),
        ),
        body: Align(
          alignment: Alignment.bottomRight,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

