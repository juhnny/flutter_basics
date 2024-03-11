import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Provider 라이브러리 사용해보기

// Consumer
//  Provider로 등록한 상태를 위젯에서 가져올 때는 Provider.of()를 사용한다.
// 그런데 Provider.of()로 상태를 등록하면 상태값이 변경됐을 때 위젯이 불필요하게 다시 빌드될 수 있다.

// 상태를 이용하지 않는 위젯은 상태가 변경되어도 다시 빌드되지 않는다.
// Widget1이 Counter의 값을 변경하면 Widget1은 재생성되지만 Widget2는 재 빌드되지 않는다.

// 하지만 Widget1 아래 상태(Provider)를 이용하지 않는 위젯이 있다면 어떨까?
// Widget1_1, Widget1_2 위젯은 상태를 이용하지 않음에도 불구하고 부모 위젯이 재빌드되므로 덩달아 같이 재빌드된다.
// Provider를 이용하는 위젯은 불필요한 빌드가 일어날 가능성이 있다는 것
// 불필요한 재빌드를 피하기 위해서는 Consumer나 Selector를 이용한다.
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
              title: Text('Future/StreamProvider, '),
            ),

            body: ChangeNotifierProvider<Counter>.value(
              value: Counter(),
              child: Container(
                color: Colors.red,
                child: Column(
                  children: [
                    Widget1(),
                    Widget2()
                  ],
                ),
              ),
            ),
        )
    );
  }
}

class Widget1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    print("Widget1 build...");
    var counter = Provider.of<Counter>(context);

    return Container(
      margin: EdgeInsets.all(10.0),
      color: Colors.orange,
      child: Column(
          children: [
            Text('Widget1 - count: ${counter.count}'),
            ElevatedButton(onPressed: counter.increment, child: Text('Increase')),
            Widget1_1(),
            Widget1_2(),
          ]),
    );
  }
}

class Widget1_1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    print("Widget1_1 build...");

    return Container(
      margin: EdgeInsets.all(10.0),
      color: Colors.yellow,
      child: Text('Widget1_1')
    );
  }
}

class Widget1_2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    print("Widget1_2 build...");

    return Container(
        margin: EdgeInsets.all(10.0),
        color: Colors.yellow,
        child: Text('Widget1_2')
    );  }
}

class Widget2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    print("Widget2 build...");

    return Container(
        padding: EdgeInsets.all(20.0),
        color: Colors.orange,
        child: Text('Widget2')
    );  }
}
