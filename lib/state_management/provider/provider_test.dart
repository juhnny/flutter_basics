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

void main(){
  runApp(MyApp());
}
// 상태를 이용할 위젯 상위에 프로바이더 등록
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Provider'),
        ),

        // .value 생성자를 이용하면 곧바로 상태에 값 지정 가능
        // 제네릭으로 상태의 타입 명시 가능. 기초 타입 뿐만 아니라 커스텀 타입도 가능
        // body: Provider<int>.value(
        //   value: 10,
        //   child: Container(
        //     color: Colors.red,
        //   ),
        // ),

        // 기본 생성자를 이용하면 create 속성에 함수를 넣어 이 함수에서 반환하는 값을 상태로 이용할 수 있다.
        body: Provider<int>(
          create: (context){
            int sum = 0;
            for(int i = 1; i <= 10; i++){
              sum += i;
            }
            return sum;
          },
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
    int data = Provider.of<int>(context);

    return Text('data: $data');
  }
}