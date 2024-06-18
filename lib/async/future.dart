
// Future.wait
// 여러 비동기작업을 동시에 시작시키고 끝날 때까지 기다린다.
Future<int> future1(){
  return Future.delayed(Duration(milliseconds: 1000), (){
    print('Future 1 Done');
    return 1;
  });
}

Future<int> future2(){
  return Future.delayed(Duration(milliseconds: 990), (){
    print('Future 2 Done');
    return 2;
  });
}

Future<int> future3(){
  return Future.delayed(Duration(milliseconds: 2000), (){
    print('Future 3 Done');
    return 3;
  });
}

Future<void> futures() async{
  print('Futures start');
  var result = await Future.wait([
    future1(),
    future2(),
    future3(),
  ]);
  print('Futures result: $result}');
}

void main(){
  futures();
}