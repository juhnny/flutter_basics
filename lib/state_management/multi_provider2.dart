import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Provider 라이브러리 사용해보기

// Provider에서 앱의 상태를 관리하는 데 제공하는 기법은 크게 2가지
// - Provider: 하위 위젯이 이용할 상태 제공
//    - Provider: 기본 프로바이더
//    - ChangeNotifierProvider: 상태 변경 감지 제공
//    - MultiProvider: 여러가지 상태 등록
//    - ProxyProvider: 다른 상태를 참조해서 새로운 상태 생산
//    - StreamProvider: 스트림 결과를 상태로 제공
//    - FutureProvider: 퓨쳐 결과를 상태로 제공
// - Consume: 하위 위젯에서 상태 데이터 사용
//    - Provider.of(): 타입으로 프로바이더의 상태 데이터 획득
//    - Consumer: 상태를 이용할 위젯 명시
//    - Selector: 상태를 이용할 위젯과 그 위젯에서 이용할 상태 명시

// Provider들을 중첩해 사용하는 대신 MultiProvider를 사용해보자.
void main(){
  runApp(MyApp());
}

// ChangeNotifierProvider에 등록하여 하위 위젯에서 이용할 데이터를 추상화한 모델 클래스
class Counter with ChangeNotifier{
  int _count = 0;
  int get count => _count;

  void increment(){
    _count++;
    // 단순히 상태 데이터가 변경됐다고 하위 위젯을 다시 빌드하지는 않으며 notify를 해줘야 함
    notifyListeners();
  }
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('ChangeNotifierProvider'),
        ),

        // Provider 대신 MultiProvider를 쓰면 가독성도 좋아지고 쓰기도 편리하다
        body: MultiProvider(
          providers: [
            Provider<int>.value(value: 10),
            Provider<String>.value(value: "Hello"),
            ChangeNotifierProvider<Counter>.value(value: Counter()),
            // 하위 위젯에서 프로바이더 사용 시 제네릭을 이용하므로 제네릭이 같은 타입이면 마지막에 등록한 프로바이더만 이용하게 되니 주의
            Provider<int>.value(value: 20),
            Provider<String>.value(value: "World"),
          ],
          child: SubWidget(),
        )
      )
    );
  }
}

class SubWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var value = Provider.of<int>(context);
    var text = Provider.of<String>(context);
    var counter = Provider.of<Counter>(context);

    return Column(
        children: [
          Text('value: ${value}'),
          Text('text: ${text}'),
          Text('data: ${counter.count}'),
          ElevatedButton(onPressed: counter.increment, child: Text('Increase'))
    ]);
  }
}