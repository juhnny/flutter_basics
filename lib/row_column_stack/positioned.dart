import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

// Positioned
// 위젯의 위치를 독립적으로 설정할 때 사용할 수 있는 위젯으로 Align과 Positioned가 있음
// Align은 독립적으로 쓸 수 있고, Positioned는 Stack에서만 사용 가능
// Positioned는 부모 위젯의 어느 모서리로부터 얼마나 떨어져야 하는지로 정의
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Positioned'
          ),
        ),
        body: Stack(
          children: [
            Container(
              color: Colors.red,
            ),
            Positioned(
              top: 40.0,
              right: 40.0,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.orange,
              ),
            ),

            // 반대방향끼리 지정하니 늘어나버리네
            Positioned(
              top: 10,
              bottom: 10,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.yellow,
              ),
            ),

          ],
        ),
      ),
    );
  }
}

