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

// FutureProvider
// create  속성에 지정한 함수에서 반환한 값으로 상태값이 바뀐다.

// StreamProvider
// create 속성에 지정한 스트림에서 발생한 데이터들로 상태값이 바뀐다.
void main(){
  runApp(MyApp());
}

Stream<int> streamFun() async* {
  for(int i = 1; i <= 5; i++){
    await Future.delayed(Duration(seconds: 1));
    yield i;
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
                FutureProvider<String>(
                  create: (context) => Future.delayed(Duration(seconds: 3), () => "world"),
                  initialData: 'Hello',
                ),
                StreamProvider<int>(
                    create: (context) => streamFun(),
                    initialData: 0
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
    var futureState = Provider.of<String>(context);
    var streamState = Provider.of<int>(context);

    return Column(
        children: [
          Text('count: $futureState'),
          Text('sum: $streamState'),
        ]);
  }
}
