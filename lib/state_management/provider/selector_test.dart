import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Provider 라이브러리 사용해보기

// Selector
// Consumer와 같은 목적으로 사용한다.
// Consumer가 프로바이더 하나를 통째로 이용하면서 변경될 위젯과 아닌 위젯을 구분하는 느낌이라면
// Selector는 프로바이더의 특정 데이터만 지정하여 이용할 수 있다.

// Widget2에 있는 Selector를 보면 Counter.count2만 선택했으므로 count2 값이 변경될 때만 재빌드된다.
// 반면 Widget1은 count가 변경되든, count2가 변경되든 재빌드된다.

// 구조
// MyAPP              (State)
// - HomeWidget       (프로바이더 사용 O)
//    - Widget1       (프로바이더 사용 O)
//        - Widget1_1 (프로바이더 사용 X)
//        - Widget1_2 (프로바이더 사용 X)
//    - Widget2       (프로바이더 사용 O)
void main(){
  runApp(MyApp());
}

class Counter with ChangeNotifier {
  int _count = 0;
  int get count => _count;
  int _count2 = 0;
  int get count2 => _count2;

  void increment() {
    _count++;
    // 단순히 상태 데이터가 변경됐다고 하위 위젯을 다시 빌드하지는 않으며 notify를 해줘야 함
    notifyListeners();
  }

  void increment2() {
    _count2++;
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

            body: MultiProvider(
              providers: [
                ChangeNotifierProvider<Counter>.value(
                  value: Counter(),
                ),
                ChangeNotifierProvider<Counter>.value(
                  value: Counter(),
                ),
              ],
              child: Container(
                padding: EdgeInsets.all(20.0),
                color: Colors.grey,
                child: Column(
                  children: [
                    Text('MyApp(State)'),
                    HomeWidget(),
                  ],
                )
              ),
            )
        )
    );
  }
}

class HomeWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    print("HomeWidget build...");

    return Container(
      padding: EdgeInsets.all(10.0),
      color: Colors.red,
      child: Column(
        children: [
          Text('HomeWidget'),
          ElevatedButton(
              onPressed: (){
                var counter = Provider.of<Counter>(context, listen: false); // listen: true로 하니 에러 나네.
                counter.increment(); // 상태값이 변할 때 (아마도) ElevatedButton이 재빌드될 것이다.
              },
              child: Text('Counter1 increment')
          ),
          ElevatedButton(
              onPressed: (){
                // Provider가 MyApp에 있으니 MyApp에서 빌드하는 위젯들은 모두 새로 빌드됨
                var counter = Provider.of<Counter>(context, listen: false);
                counter.increment2();
              },
              child: Text('Counter2 increment')
          ),

          // Widget1이 재빌드될 때 Widget1_1d은 함꼐 재빌드되고, Widget1_2는 재빌드되지 않게 하고 싶다면...
          Consumer<Counter>(
            // 상태 변경 시 재빌드 되지 않게 할 위젯은 child에 작성
            child: Widget1_2(),
            // 상태 변경 시 재빌드할 위젯은 builder에 작성
            // child 속성에 작성한 위젯을 child 파라미터로 전달 받아 이 안에서 빌드에 사용한다.
            builder: (context, model, child){
              print("HomeWidget Consumer<Counter> builder..");
              return Column(
                children: [
                  Widget1(model, child!), // 파라미터로 받은 child의 타입은 Widget?이니 뱅 연산자 추가
                ],
              );
            },
          ),
          // Widget2는 프로바이더를 이용하지 않고, 상위 위젯 중에도 프로바이더를 이용 중인 위젯이 없으므로 상태값이 바뀌어도 재빌드되지 않는다.
          Widget2(),
        ],
      ),
    );
  }
}

class Widget1 extends StatelessWidget{
  Counter counter;
  Widget? child;

  Widget1(this.counter, this.child);

  @override
  Widget build(BuildContext context) {
    print("Widget1 build...");

    return Container(
      margin: EdgeInsets.all(10.0),
      color: Colors.orange,
      child: Column(
          children: [
            Text('Widget1 - count: ${counter.count}'),
            Widget1_1(),
            child!
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
    );
  }
}

class Widget2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    print("Widget2 build...");

    return Container(
        padding: EdgeInsets.all(20.0),
        color: Colors.orange,
        // Selector 사용
        // selector 속성에서 반환한 데이터가 builder에 지정한 함수의 두번째 매개변수로 전달됨. 해당 데이터가 변경될 때만 builder 위젯을 다시 빌드한다.
        child: Selector<Counter, int>(
          selector: (context, model) => model.count2,
          builder: (_, data, __){
            print("Widget2 Consumer<Counter> builder..");
            return Text('Widget2 - count2: ${data}');
          },
        )
    );
  }
}
