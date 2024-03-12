import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Providers
// https://riverpod.dev/docs/concepts/providers

// 프로바이더는 변형이 여럿 있지만 동일하게 동작한다.
// 가장 일반적인 사용법은 글로벌 상수로 선언하는 것이다.
// Do not be frightened by the global aspect of providers. Providers are fully immutable. Declaring a provider is no different from declaring a function
// 프로바이더는 원하는 만큼 제한 없이 선언할 수 있다.
// Provider 패키지와 다르게 Riverpod에서는 같은 타입을 반환하는 복수의 프로바이더를 만들 수 있다.

// Different Types of Providers
// Provider Type          Provider Create Function                Example Use Case
// Provider               Returns any type	                      A service class / computed property (filtered list)
// StateProvider	        Returns any type	                      A filter condition / simple state object
// FutureProvider	        Returns a Future of any type	          A result from an API call
// StreamProvider	        Returns a Stream of any type	          A stream of results from an API
// NotifierProvider	      Returns a subclass of (Async)Notifier	  A complex state object that is immutable except through an interface
// StateNotifierProvider	Returns a subclass of StateNotifier	    A complex state object that is immutable except through an interface. Prefer using a notifierProvider
// ChangeNotifierProvider	Returns a subclass of ChangeNotifier	  A complex state object that requires mutability

// 프로바이더는 언제나 final이어야 한다.
// Provider는 가장 기본적인 프로바이더다. 변하지 않는 객체를 노출시킨다.
final helloWorldProvider = Provider(
  // 공유될 상태를 만드는 create 함수.
  // 언제나 ref 객체를 파라미터로 받는다. This object allows us to read other providers, perform some operations when the state of our provider will be destroyed, and much more.
  (ref){
    // 함수에서 반환된 객체는 프로바이더로 전달된다.
    // 단, 프로바이더 종류에 따라 반환 가능한 객체는 달라진다.
    // Provider는 어떤 객체든 반환 가능하고, StreamProvider는 Stream을 반환해야 한다.
    return "Hello world";
  },
);

// Provider Modifiers
// 모든 프로바이더는 각각의 특별한 내장 기능들이 있다.
// 이 기능들은 ref 객체에 새로운 기능을 더하고 프로바이더가 사용되는 방식에 변화를 주기도 한다.
// 모든 프로바이더에 명명된 생성자와 비슷한 문법의 Modifier를 쓸 수 있다.
// 현재 두 종류의 제어자가 있다.
// .autoDispose : 프로바이더가 더이상 listen되지 않을 때 자동으로 상태를 destroy한다.
// .family : 외부 인자를 받아 프로바이더를 만들 수 있게 한다.
class User{
  String name;
  User(this.name);
}
final userProvider = Provider.autoDispose.family(
    (ref, userId){
      return User('$userId');
    },
);

final intProvider = Provider((_){
  return 0;
});

final counterProvider = Provider((_){
  int value = 0;

  void increase(){
    value++;
  }

  return value;
});

final counterStateProvider = StateProvider((ref){
  // int value = 0;

  void increase(){
    // value++;
  }

  return 0;
});

// For providers to work, you must add ProviderScope at the root of your Flutter applications
void main(){
  runApp(
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Test')),
        body: Center(
          child: Column(
            children: [
              Text(ref.watch(helloWorldProvider)),

              Text('${ref.watch(intProvider)}'),

              Text('${ref.watch(counterProvider)}'),
              FloatingActionButton(
                child: Text('+'),
                onPressed: (){
                  // ref.watch(counterProvider).increase(); // 일반 provider라 그런가 인식 못하네
                }),

              Text('${ref.watch(counterStateProvider)}'),
              FloatingActionButton(
                child: Text('+'),
                onPressed: (){
                  ref.watch(counterStateProvider.notifier).state++;
                  // ref.watch(counterStateProvider.notifier).increase(); // 여전히 멤버 함수를 인식 못하네
                  // ref.watch(counterStateProvider).increase(); // 여전히 멤버 함수를 인식 못하네
                }),

              Text('${ref.watch(counterStateProvider)}'),
              FloatingActionButton(
                child: Text('+'),
                onPressed: (){
                  ref.watch(counterStateProvider.notifier).state++;
                  // ref.watch(counterStateProvider.notifier).increase(); // 여전히 멤버 함수를 인식 못하네
                  // ref.watch(counterStateProvider).increase(); // 여전히 멤버 함수를 인식 못하네
                }),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Text('increase'),
          onPressed: (){
            int count = ref.watch(intProvider);
            count++;
          },
        ),
      ),
    );
  }
}
