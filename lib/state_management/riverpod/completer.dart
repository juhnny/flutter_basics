import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  runApp(ProviderScope(
    child: MyApp(),
  ));
}

@immutable
class Counter{
  int count;
  int sum;

  Counter({this.count = 01, this.sum = 0});

  void increment(){
    count++;
    print('increment - count: $count');
  }

  // copyWith 메소드
  // 생성자 대신 copyWith를 이용하는 이유 :
  // 프로퍼티가 몇 개 없다면 생성자를 이용해도 되겠지만, 프로퍼티가 10개쯤 있다면 쓸데없이 코드가 길어질 것이다. 객체 밖에서 값을 get하지 못할 수도 있고.
  // 그러니 객체 그대로, 혹은 필요한 속성만 바꿔서 새 객체를 만들어 반환하는, 클래스 내에서 정의한 인스턴스 메소드가 필요해진다.
  // ??를 통해 각 파라미터 값을 확인하여 null이 아니면 파라미터 값을 넣고, null이면 원본 객체의 값을 넣어 리턴한다.
  Counter copyWith({int? count, int? sum}){
    return Counter(count: count ?? this.count, sum: sum ?? this.sum);
  }
}

class CounterNotifier extends Notifier<Counter>{
  @override
  Counter build() {
    print('CounterNotifier build');
    return Counter();
  }

  void plus(){
    state.count++;
    print('CounterNotifier plus - ${state.count}');
  }

  void refresh(){
    state = Counter(count: state.count, sum: state.sum);
  }

  void plusWithNewObject(){
    state = Counter(count: state.count + 1, sum: state.sum);
  }

  void plusWithCopyWith(){
    state = state.copyWith(count: state.count + 1);
  }

  void plusFuture(){
    Future.delayed(Duration(seconds: 1), (){
      state = state.copyWith(count: state.count + 2);
    });
  }

  void getData() async{
    final response = await http.get(Uri.https('boredapi.com', '/api/activity'));
    print(response.body);
    saveData(response.body);
  }

  void saveData(String str) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('myData', str);
  }

  void loadData() async {
    var prefs = await SharedPreferences.getInstance();
    var data = await prefs.getString('myData');
    print('Loaded Data: $data');
  }

}

final counterNotifierProvider = NotifierProvider<CounterNotifier, Counter>((){
  print('counterNotifierProvider createFun');

  return CounterNotifier();
});


final futureStringProvider = FutureProvider<String>((ref) async{
  String result = '';
  await Future.delayed(Duration(seconds: 1), (){
    result = 'Done';
  });
  return result;
});

final prefsFutureProvider = FutureProvider((ref) async{
  late SharedPreferences result;
  result = await SharedPreferences.getInstance();
  return result;
});

// SharedPreference 객체를 넘겨받는 것만으로는 부족하다.
// save, load, clear 등의 기능을 제공해야 하니 클래스로 만들어 사용하자.
class SharedPrefsService {

  SharedPreferences? prefs;

  void init() async {
    prefs = null;
    print('init prefs: $prefs');
    prefs = await SharedPreferences.getInstance();
    print('init prefs hash: ${prefs.hashCode}');
  }

  bool get hasInitialized => prefs != null;

  Object? get(String key) async {
    prefs = await SharedPreferences.getInstance();
    Object? data = await prefs!.get(key); // 'myData'
    print('Loaded Data: ${data.toString()}');
    return data;
  }

  Future<bool> set(String key, dynamic data) async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.setString(key, data.toString());
  }

  Future<bool> has(String key) async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.containsKey(key);
  }

  // Completer
  // Completer가 필요한 이유
  // prefs 인스턴스가 완전히 확보된 다음으로 작업을 미루기 위하여

  // 사실 remove라는 기능은 null 연산자로 접근해 사용해도 반환값이 오해를 불러오진 않는다.
  // 지웠으면 성공, 못지웠으면 실패, null이어도 실패
  // prefs가 null이라서 false가 뜬 거여도 성공할때까지 시도하겠지.

  // 그런데 만약 has() 같은 작업에서 데이터가 존재함에도 prefs가 null일 때 호출을 했고 false가 떴다면?
  // 새로 set()을 시도해서 기존 데이터를 덮어쓰기 하게 될 수도 있다.
  // clear()에서도 오류가 있으면 안된다. 로그아웃하면서 사용자 데이터를 지웠다고 생각했는데 다음에 앱을 열었는데 안 지워져있는 상황이 생길 수도 있다.
  Future<bool> remove(String key) async{
    prefs = await SharedPreferences.getInstance();
    return prefs!.remove(key);
  }
  // 이렇게 작성할 수도 있겠다.
  Future<bool> remove2(String key) async{
    return await prefs?.remove(key) ?? false;
  }
  // 참고: Future로 값을 반환하는 법
  Future<int> getFutureValue(){
    return Future.value(11111);
  }

  Future<bool> clear() async{
    prefs = await SharedPreferences.getInstance();
    return prefs!.clear();
  }

  int count = 0;

}

final prefsProvider = Provider<SharedPrefsService>((ref){
  SharedPrefsService prefsService = SharedPrefsService();
  prefsService.init();
  return prefsService;
});

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Unclean Architecture')),
        body: HomePage(),
      ),
    );
  }
}

final intProvider = Provider<int>((ref){
  print('intProvider createFun');
  // var counter = ref.watch(counterNotifierProvider);
  var count = ref.watch(counterNotifierProvider.select((counter) => counter.count));
  // return 100 + counter.count;
  return 100 + count;
});


class HomePage extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Counter counter = ref.watch(counterNotifierProvider);
    CounterNotifier counterNotifier = ref.watch(counterNotifierProvider.notifier);
    int value = ref.watch(intProvider);
    var futureString = ref.watch(futureStringProvider);
    AsyncValue<SharedPreferences> futurePrefs = ref.watch(prefsFutureProvider);
    SharedPrefsService prefs = ref.watch(prefsProvider);

    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Text('counter: ${counter}, hash: ${counter.hashCode}'),
            Text('counter: ${counter.count}'),
            Text('counter: ${counterNotifier}'),
            Text('counter: ${counterNotifier.state}'),
            Text('counter: ${counterNotifier.state.count}'),
            Text('value: $value'),
            // Riverpod은 상태가 변경되었다고 감지하는 기준으로 레퍼런스가 바뀌었는지를 본다.
            // state로 지정한 object의 레퍼런스는 그대로 둔 채 그 내부 프로퍼티만 바꿔서는 상태가 변경되었다고 판단하지 않는다.
            // 그러므로 mutable state 대신 immutable state를 사용하고 깊은 복사를 이용해 state를 변경해야 한다.
            // Notifier가 바라보고 있는 건 Counter 객체다. count 프로퍼티를 바꾼다고 해서 객체가 바뀌진 않는다.
            ElevatedButton(onPressed: (){
              ref.read(counterNotifierProvider).increment();
            }, child: Text('Increment'),),

            // 마찬가지. Notifier가 바라보고 있는 건 Counter 객체다. count 프로퍼티를 바꾼다고 해서 객체가 바뀌진 않는다.
            ElevatedButton(onPressed: (){
              ref.read(counterNotifierProvider.notifier).plus();
            }, child: Text('Plus'),),

            // 새 객체를 만들어주니 그제서야 위젯이 업데이트된다.
            // 새 Counter 객체를 만들어야 하니 Counter 객체 내부에서 할 수는 없다. Notifier에 state 변경 메소드가 있어야겠다.
            ElevatedButton(onPressed: (){
              ref.read(counterNotifierProvider.notifier).refresh();
            }, child: Text('Refresh'),),

            // 덧셈과 새 객체 생성을 동시에.. 드디어 제대로 동작한다.
            ElevatedButton(onPressed: (){
              ref.read(counterNotifierProvider.notifier).plusWithNewObject();
            }, child: Text('Plus With New Object'),),

            // 좀 더 프로답게 copyWith 메소드를 만들어주자.
            ElevatedButton(onPressed: (){
              ref.read(counterNotifierProvider.notifier).plusWithCopyWith();
            }, child: Text('Plus With copyWith'),),

            // 비동기 작업도 해볼까
            ElevatedButton(onPressed: (){
              ref.read(counterNotifierProvider.notifier).plusFuture();
            }, child: Text('Plus Future'),),

            // 네트워크 작업도 해볼까
            ElevatedButton(onPressed: (){
              ref.read(counterNotifierProvider.notifier).getData();
            }, child: Text('Get Data'),),

            // Shared Prefs 저장/불러오기도 해볼까
            ElevatedButton(onPressed: (){
              ref.read(counterNotifierProvider.notifier).loadData();
            }, child: Text('Load Data'),),

            // FutureProvider 연습
            Text('FutureString: ${futureString}'),
            Center(
              child: switch(futureString){
                AsyncData(:final value) => Text('success - $value'),
                AsyncError() => Text('error'),
                _ => Text('others')
              },
            ),
            // SharedPreferences를 FutureProvider로 만들어보자
            Text('futurePrefs: ${futurePrefs}, hash: ${futurePrefs.hashCode}'),
            Center(
              child: switch(futurePrefs){
                AsyncData(:final value) => Text('success - $value'),
                AsyncError() => Text('error'),
                _ => Text('others')
              },
            ),

            // SharedPreferences를 일반 Provider로 만들어보자
            Text('prefs: ${prefs}, hash: ${prefs.hashCode}'),
            ElevatedButton(
              onPressed: (){
                ref.read(prefsProvider).init();
              },
              child: Text('init'),
            ),
            ElevatedButton(
              onPressed: () async {
                var data = await ref.read(prefsProvider).get('myData');
                print('data: $data');
              },
              child: Text('get'),
            ),
            ElevatedButton(
              onPressed: () async {
                var result = await ref.read(prefsProvider).has('myData');
                print('result: $result');
              },
              child: Text('has'),
            ),
            ElevatedButton(
              onPressed: () {
                var result = ref.read(prefsProvider).remove('myData');
                result.then((value) => print('result: $value'));
              },
              child: Text('remove'),
            ),
            ElevatedButton(
              onPressed: () {
                var result = ref.read(prefsProvider).clear();
                result.then((value) => print('result: $value'));
              },
              child: Text('clear'),
            ),

            // Future를 결과로 받았을 땐 두가지 방식으로 쓸 수 있다.
            // 첫번째는 async, await
            // 두번째는 Future를 받아 then을 쓰는 법

            // await, async 사용하는 법
            ElevatedButton(
              onPressed: () async {
                var result = await ref.read(prefsProvider).remove('myData');
                print('result: $result');
              },
              child: Text('await'),
            ),

            // Future를 받아 then, onError 사용하는 법
            ElevatedButton(
              onPressed: () {
                Future result = ref.read(prefsProvider).has('myData');
                result.then((value) => print('result: $value'));
                result.onError((error, stackTrace) => print('onError: ${error.toString()}'));
              },
              child: Text('has(then)'),
            ),

            // await, async를 쓰면 예외처리가 안되냐.. 하면,
            // then을 동시에 사용하면서 예외처리를 하는 것도 가능하다.
            ElevatedButton(
              onPressed: () async {
                bool result = await ref.read(prefsProvider).has('myData')
                    .then((value) => value)
                    .catchError((error){
                      print('catchError error: ${error.toString()}');
                      return false; // 에러인데 굳이 false를 리턴해야 하는 것도 별로네..
                      // throw error; // catchError에서 다시 throw를 하는 것도 이상하지 않나?
                    })
                    .whenComplete(() => print('whenComplete'));
                print('result: $result');
              },
              child: Text('has(await + then)'),
            ),

            // 가독성 면에서 async, await을 쓸 경우 차라리 try-catch-finally를 쓰는 듯하다.
            ElevatedButton(
              onPressed: () async {
                try{
                  bool result = await ref.read(prefsProvider).has('myData');
                  print('result: $result');
                } catch(error){
                  print('catchError error: ${error.toString()}');
                } finally{
                  print('finally');
                }
              },
              child: Text('has(await + try-catch)'),
            ),

          ],
        ),
      ),
    );
  }
}