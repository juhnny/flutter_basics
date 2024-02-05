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
        appBar: AppBar(
          title: Text("Gesture Detector"),
        ),
        body: Column(
          children: [
            // Flutter에서 이벤트 처리의 기본은 GestureDetector
            // 모든 사용자 이벤트는 GestureDetector로 처리할 수 있지만 화면 구성은 직접 해줘야 한다.
            // 버튼 위젯처럼 자주 사용하는 위젯들은 자체적으로 이벤트 처리가 가능
            GestureDetector(
              child: Image.asset('images/big.jpeg'),
              onTap: (){
                print("onTap");
              },
              onDoubleTap: (){
                print("onDoubleTap");
              },
              onLongPress: (){
                print('onLongPress');
              },
              onVerticalDragStart: (DragStartDetails details){
                print('onVerticalDragStart - global position: '
                    '${details.globalPosition.dx}, ${details.globalPosition.dy}');
              },
              onHorizontalDragStart: (DragStartDetails details){
                print('onHorizontalDragStart - global position: '
                    '${details.globalPosition.dx}, ${details.globalPosition.dy}');
              },
            ),
            ElevatedButton(
              onPressed: (){
                print("click");
              },
              child: Text("Elevated Button"),
            ),
            ElevatedButton(
              onPressed: null, // 콜백에 null을 등록하면 버튼이 비활성화됨
              child: Text("Diabled Button"),
            ),
            ElevatedButton(
              onPressed: (){
                print("click");
              },
              child: Text("Elevated Button"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red)
              ),
            ),

          ],
        ),
      ),
    );
  }
}