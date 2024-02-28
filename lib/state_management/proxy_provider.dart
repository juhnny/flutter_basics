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

// ProxyProvider는 다른 상태를 조합해 상태를 만들어낼 때 사용
// ProxyProvider는 제네릭을 두 개 선언한다. <A, B> 라고 쓸 경우
// A는 전달받을 상태 타입, B는 A를 참조해 만들어낼 상태 타입이 된다.
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

class Sum{
  int _sum = 0;
  // getter
  int get sum => _sum;
  // setter
  void set sum(value){
    _sum = 0;
    for(int i = 1; i <= value; i++){
      _sum += i;
    }
    // 단순히 상태 데이터가 변경됐다고 하위 위젯을 다시 빌드하지는 않으며 notify를 해줘야 함
  }

  Sum(Counter counter){
    sum = counter.count;
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
            ChangeNotifierProvider<Counter>.value(value: Counter()),
            ProxyProvider<Counter, Sum>(
              update: (context, model, sum){
                print("ProxyProvider update()");
                if(sum != null){
                  sum.sum = model.count;
                  return sum;
                } else {
                  return Sum(model);
                }
              }
            ),
            ProxyProvider2<Counter, Sum, String>(
                update: (context, model, sum, String){
                  print("ProxyProvider2 update()");
                  return 'count: ${model.count}, sum: ${sum.sum}';
                }
            ),
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
    var counter = Provider.of<Counter>(context);
    var sum = Provider.of<Sum>(context);
    var str = Provider.of<String>(context);

    return Column(
        children: [
          Text('count: ${counter.count}'),
          Text('sum: ${sum.sum}'),
          Text('str: ${str}'),
          ElevatedButton(onPressed: counter.increment, child: Text('Increase'))
    ]);
  }
}