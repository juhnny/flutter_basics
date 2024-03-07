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

// 기본 Provider는 상태를 저장만 할 수 있고 값 변화를 전파하진 못하는 모양이다.
// 변경된 상태를 하위 위젯에 적용하려면 ChangeNotifierProvider를 써야 한다.
// ChangeNotifierProvider에 등록할 상태 데이터는 ChangeNotifier를 구현해야 한다.

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

// 상태를 이용할 위젯 상위에 프로바이더 등록
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('ChangeNotifierProvider'),
        ),

        // ChangeNotifierProvider는 자신에게 등록된 모델 클래스에서 notifyListeners() 함수 호출을 감지해 child에 등록된 위젯을 다시 빌드해준다.
        body: ChangeNotifierProvider<Counter>.value(
          value: Counter(),
          child: SubWidget()
        ),
      )
    );
  }
}

class SubWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // 하위 위젯에서는 Provider.of()로 상태 데이터를 얻을 수 있다.
    // 제네릭은 프로바이더가 제공하는 상태 데이터의 타입
    var counter = Provider.of<Counter>(context);

    return Column(
        children: [
          Text('data: ${counter.count}'),
          ElevatedButton(onPressed: counter.increment, child: Text('Increase'))
    ]);
  }
}