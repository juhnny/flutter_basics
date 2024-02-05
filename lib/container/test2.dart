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
          title: Text('Container'),
          backgroundColor: Colors.grey,
        ),
        body: Column( // 좌측에 왜 의도하지 않은 마진이 생겨있지?
          children: [
            // 크기 지정하기
            Container(
              // 마진 적용하는 방법
              // margin: const EdgeInsets.all(20), // 사방에 동일하게 적용
              margin: EdgeInsets.symmetric(horizontal: 20), // 상하 또는 좌우 적용
              // margin: const EdgeInsets.only(left: 20), // 상하좌우 각각 적용
              padding: EdgeInsets.all(10),
              color: Colors.red,
              width: 100,
              height: 100,
            ),
            // 그림자 효과
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: <BoxShadow>[BoxShadow(color: Colors.green, blurRadius: 8, spreadRadius: 8.0, blurStyle: BlurStyle.normal),]
              ),
              // color: Colors.red,
              width: 100,
              height: 100,
            ),
            // 테두리 효과
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 4,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              width: 100,
              height: 100,
              child: Image.asset('images/big.jpeg'),
            ),
            // 원 영역 출력
            Container(
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('images/big.jpeg'),
                  fit: BoxFit.cover
                )
              ),
              width: 100,
              height: 100,
            ),
            // 그라데이션
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.red,
                    Colors.yellow,
                  ]
                )
              ),
              width: 100,
              height: 100,
              child: Center(
                child: Text(
                  'Hello!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}