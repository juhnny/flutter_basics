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
            'Row, Column'
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.grey,
                child: Row(
                  children: [
                     Container(width: 20, height: 20, color: Colors.red,),
                     Container(width: 20, height: 100, color: Colors.green,),
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
                     Container(width: 20, height: 100, color: Colors.green,),
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
                    Container(width: 20, height: 100, color: Colors.green,),
                    Container(width: 20, height: 30, color: Colors.blue,),
                  ],
                ),
              ),

              // mainAxisAlignment
              //  start:
              //  end:
              //  center:
              //  spaceAround: 각 위젯의 앞뒤에 공백
              //  spaceBetween: 위젯 간 균등한 공백
              //  spaceEvenly: 앞뒤 그리고 각 위젯 간 균등한 공백
              Text('MainAxisAlignment'),
              Container(
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: 50, height: 50, color: Colors.red,),
                    Container(width: 50, height: 50, color: Colors.green,),
                    Container(width: 50, height: 50, color: Colors.blue,),
                  ],
                ),
              ),
              Container(
                color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(width: 50, height: 50, color: Colors.red,),
                    Container(width: 50, height: 50, color: Colors.green,),
                    Container(width: 50, height: 50, color: Colors.blue,),
                  ],
                ),
              ),
              Container(
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: 50, height: 50, color: Colors.red,),
                    Container(width: 50, height: 50, color: Colors.green,),
                    Container(width: 50, height: 50, color: Colors.blue,),
                  ],
                ),
              ),
              Container(
                color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(width: 50, height: 50, color: Colors.red,),
                    Container(width: 50, height: 50, color: Colors.green,),
                    Container(width: 50, height: 50, color: Colors.blue,),
                  ],
                ),
              ),

              // crossAxisAlignment
              //  start:
              //  end:
              //  center:
              //  stretch: 교차축을 모두 차지하게 배치. 높이 지정 필요
              //  baseline: 문자 기준선에 맞춰 배치
              Text('CrossAxisAlignment'),
              Container(
                color: Colors.black,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: 20, height: 20, color: Colors.red,),
                    Container(width: 20, height: 100, color: Colors.green,),
                    Container(width: 20, height: 30, color: Colors.blue,),
                  ],
                ),
              ),
              Container(
                color: Colors.grey,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(width: 20, height: 20, color: Colors.red,),
                    Container(width: 20, height: 100, color: Colors.green,),
                    Container(width: 20, height: 30, color: Colors.blue,),
                  ],
                ),
              ),
              Container(
                color: Colors.black,
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(width: 20, height: 20, color: Colors.red,),
                    Container(width: 20, height: 50, color: Colors.green,),
                    Container(width: 20, height: 30, color: Colors.blue,),
                  ],
                ),
              ),
              Container(
                color: Colors.grey,
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text('Apple',
                      style: TextStyle(
                        fontSize: 20,
                        backgroundColor: Colors.red,
                      ),),
                    Text('하나둘셋',
                      style: TextStyle(
                          fontSize: 30,
                        backgroundColor: Colors.orange,
                      ),),
                    Text(
                      '0123',
                      style: TextStyle(
                        fontSize: 10,
                        backgroundColor: Colors.yellow,
                      ),),
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