import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

// Align
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Align 2'
          ),
        ),
        body: Stack(
          children: [
            Container(
              color: Colors.red,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.orange,
              ),
            ),

            // 숫자로 위치를 조절할 수도 있다.
            // x축, y축에 -1.0 ~ 1.0까지 설정 가능. (0, 0)이 중앙
            Align(
              alignment: Alignment(1.0, -1.0),
              child: Container(
                width: 100,
                height: 100,
                color: Colors.yellow,
              ),
            ),

            // FractionalOffset
            // 전통적 좌표계처럼 좌상단을 (0, 0)으로 하고 싶을 때 사용
            Align(
              alignment: FractionalOffset(1.0, 1.0),
              child: Container(
                width: 100,
                height: 100,
                color: Colors.green,
              ),
            ),
            Align(
              alignment: FractionalOffset(0.0, 0.75),
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
              ),
            ),

            // 미리 정의된 상수도 사용 가능
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.purple,
              ),
            ),
          ],

        ),
      ),
    );
  }
}

