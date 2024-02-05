import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

// Center 위젯
// Center의 기본 크기은 가능한 최대 영역
// widthFactor, heightFactor를 쓰면 자식의 가로, 세로 크기의 배수로 크기를 제한할 수 있다.
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Container(
          color: Colors.yellow,
          child: Center(
            widthFactor: 4,
            heightFactor: 2,
            child: Image.asset(
              'images/big.jpeg',
              width: 50,
              height: 50,
            ),
          ),
        ),
      )
    );
  }
}