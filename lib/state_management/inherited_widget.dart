import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

// InheritedWidget
// 여러 위젯이 사용하는 상태를 가지는 상위 위젯을 만드는 클래스
// build() 함수가 없어 자체 화면을 만들지 않으며
// 단지 상태 데이터와 이를 관리하는 함수를 만들어 하위 위젯들에게 제공하는 역할을 한다.

// 참고로 Provider가 InheritedWidget을 이용한다.
// "본질적으로 Provider는 "더 단순한 InheritedWidget"입니다; Provider는 단지 InheritedWidget 래퍼일 뿐이므로 이에 의해 제한을 받습니다." - Riverpod 공식문서 중

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Inherited Widget')),
        body: Column(
            children: [
              ElevatedButton(
                  onPressed: () => setState(() {

                  }),
                  child: Text('Refresh')
              ),
              MyInheritedWidget(TestWidget()),
            ]),
      ),
    );
  }
}

// InheritedWidget을 이용하려면 이를 상속받아 클래스를 만들고 하위 위젯들에서 사용할 상태와 관리 함수를 만들어준다.
class MyInheritedWidget extends InheritedWidget{
  int count = 0;

  // 생성자
  // 하위에 위치시킬 위젯을 매개변수로 받아 상위 생성자에 전달. 이제부터 그 하위에 있는 모든 위젯이 InheritedWidget의 상태를 이용 가능
  MyInheritedWidget(Widget child) : super(child: child);

  increment(){
    print('increment()');

    count++;
  }

  // InheritedWidget이 다시 생성될 때 그 하위 위젯들도 다시 생성되어야 하는지를 판단하는 함수
  // InheritedWidget을 build()에 포함하고 있는 상위 위젯의 상태가 바뀌면 InheritedWidget도 재생성될 수 있다.
  // 일반적으로는 하위 위젯들도 재생성하지만, 상태값들이 이전과 같거나 경우에 따라 하위 위젯들을 새로 그릴 필요가 없을 수도 있다.
  @override
  bool updateShouldNotify(covariant MyInheritedWidget oldWidget) { // covariant: convariant를 사용하여 유형을 원래 매개 변수의 하위 유형으로 바꿀 수 있습니다.
    debugPrint('updateShouldNotify()');
    print('this widget: ${hashCode}');
    print('old widget: ${oldWidget.hashCode}');
    print('Same widget? ${this == oldWidget}');
    print('Same count? ${count == oldWidget.count}');
    return true;
  }

  // 하위 위젯에서 MyInheritedWidget 객체를 얻기 위해 호출하는 함수
  // depend~Type() 함수는 위젯 계층구조에서 함수를 호출한 위젯과 가장 가까운 InheritedWidget을 반환해준다.
  static MyInheritedWidget? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
}

class TestWidget extends StatelessWidget{
  TestWidget(){
    print('TestWidget constructor...');
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState){
        MyInheritedWidget? myInheritedWidget = MyInheritedWidget.of(context);
        // 여길 보면 상태 접근 방식이 Provider와 매우 닮았다는 걸 알 수 있다.
        int counter  = MyInheritedWidget.of(context)!.count;
        Function increment  = MyInheritedWidget.of(context)!.increment;

        return Center(
          child: Container(
            color: Colors.amber,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "TestWidget counter: $counter",
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                  onPressed: () => setState( () => increment() ),
                  child: Text('increment'),
                ),
                ElevatedButton(
                  onPressed: () => setState( () => myInheritedWidget?.count++ ),
                  child: Text('counter++'),
                ),

                // setState를 빼고 InheritedWidget의 값을 바꿔보면 updateShouldNotify()의 영향을 받는다는 걸 알 수 있다.
                ElevatedButton(
                  onPressed: () => increment() ,
                  child: Text('increment'),
                ),
                ElevatedButton(
                  onPressed: () => myInheritedWidget?.count++,
                  child: Text('counter++'),
                ),

                TestSubWidget(),
              ],
            ),
          ),
        );
      }
    );
  }
}
class TestSubWidget extends StatelessWidget{
  TestSubWidget(){
    print('TestSubWidget constructor...');
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState){
        int counter  = MyInheritedWidget.of(context)!.count;

        return Container(
          margin: EdgeInsets.all(20.0),
          height: 100,
          color: Colors.orange,
          child: Center(
            child: Text("TestSubWidget counter: $counter"),
          ),
        );
      }
    );
  }
}