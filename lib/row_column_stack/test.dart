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
            'Row, Column, Stack'
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                color: Colors.grey,
                child: Row(
                  children: [
                     Container(width: 20, height: 20, color: Colors.red,),
                     Container(width: 20, height: 50, color: Colors.green,),
                     Container(width: 20, height: 30, color: Colors.blue,),
                  ],
                ),
              ),

              // MainAxisSize - max, min
              // 기본값은 max로, 가능한 최대 영역을 차지
              // 교차축은 자식 위젯을 출력할 수 있는 최소 크기
              Text('MainAxixSize'),
              Container(
                color: Colors.black,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                     Container(width: 20, height: 20, color: Colors.red,),
                     Container(width: 20, height: 50, color: Colors.green,),
                     Container(width: 20, height: 30, color: Colors.blue,),
                  ],
                ),
              ),
              Container(
                color: Colors.grey,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 20, height: 20, color: Colors.red,),
                    Container(width: 20, height: 50, color: Colors.green,),
                    Container(width: 20, height: 30, color: Colors.blue,),
                  ],
                ),
              ),

              // mainAxisAlignment
              //  start:
              //  end:
              //  center:
              //  spaceAround:
              //  spaceBetween:
              //  spaceEvenly:
              Text('MainAxisAlignment'),
              Container(
                color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: 20, height: 20, color: Colors.red,),
                    Container(width: 20, height: 50, color: Colors.green,),
                    Container(width: 20, height: 30, color: Colors.blue,),
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