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
// [Provider Type]        [Provider Create Function]              [Example Use Case]
// Provider               Returns any type	                      A service class / computed property (filtered list)
// StateProvider	        Returns any type	                      A filter condition / simple state object
// FutureProvider	        Returns a Future of any type	          A result from an API call
// StreamProvider	        Returns a Stream of any type	          A stream of results from an API
// NotifierProvider	      Returns a subclass of (Async)Notifier	  A complex state object that is immutable except through an interface
// (StateNotifierProvider)	Returns a subclass of StateNotifier	    A complex state object that is immutable except through an interface. Prefer using a notifierProvider
// (ChangeNotifierProvider)	Returns a subclass of ChangeNotifier	  A complex state object that requires mutability

// 참고
// - Riverpod 2.0부터 StateNotifierProvider는 deprecated. (Async)NotifierProvider로 이전
//   StateProvider는 StateNotifierProvider의 간소화된 역할로써 만들어졌다. 이제 StateNotifierProvider를 쓰지 않으므로 StateProvider도 쓰지 않아야 한다.
// - AsyncNotifier는 Notifier의 비동기 버전이다.
// - FutureProvider는 사용자 상호 작용 후 계산을 직접 변경할 수 있는 방법이 없습니다. FutureProvider는 간단한 사용 사례를 해결하기 위해 설계되었습니다. 예, 파일, asset 읽어오기
//   보다 고급 시나리오의 경우에는 AsyncNotifierProvider 사용하는 것이 좋습니다.
// - ChangeNotifierProvider도 Provider 패키지의 ChangeNotifier를 Riverpod으로 마이그레이션하기 위한 프로바이더. (Async)NotifierProvider를 권하고 있다.

// Providers are "lazy". Defining a provider will not execute the network request. Instead, the network request will be executed when the provider is first read.

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
// 모든 프로바이더에 명명된 생성자와 비슷한 문법의 Modifier를 쓸 수 있다. (명명된 생성자와는 다르다고 함.)
// 현재 두 종류의 제어자가 있다.

// .autoDispose : 프로바이더가 더이상 listen되지 않을 때 자동으로 상태를 destroy한다.
// provider도 결국은 변수 이다. 변수는 선언을 하고 더이상 사용하지 않을 경우 메모리에서 해제 시켜주는것이 좋다. 이 때 사용하는 것이 autoDispose 이다.
// 통상적인 autoDispose 의 유즈 케이스는 다음과 같다.
// - 불필요한 코스트 발생을 피하기 위해 연결을 끊는 경우(예를 들어 Firebase를 사용할 때)
// - 사용자가 화면상에서 떠나고 다시 진입했을 때 상태를 초기화 할 경우
// 프로바이더 생성자 뒤에 .autoDispose만 붙여주면 끝.
final myAutoDisposeProvider = StateProvider.autoDispose((ref) => "0");

// 근데 int 타입 프로바이더는 autoDispose를 쓰니 프로바이더를 사용하는 곳에서 컴파일 에러가 난다. 심지어 리버팟 공식문서에 있는 에제인데..
// 아마 다음 문제와 연관이 있는 거 같다.
// https://riverpod.dev/docs/concepts/modifiers/auto_dispose#the-argument-type-autodisposeprovider-cant-be-assigned-to-the-parameter-type-alwaysaliveproviderbase
final myAutoDisposeProvider2 = StateProvider.autoDispose((ref) => 0);


// .family : 외부 인자를 받아 프로바이더를 만들 수 있게 한다.
//By using the family modifier on any provider type (i.e. Provider, FutureProvider, StreamProvider, and so on), you can pass values into the Provider when you create it.
// 첫번째 제네릭이 아웃풋 타입, 두번째 제네릭이 인풋 타입인 듯
final myFamilyProvider = Provider.family<String, int>((ref, id) => 'I am $id');

// If you want to pass multiple values into the Provider when you create it, you can use the family modifier with a custom type.
class User{
  String name;
  int age;

  User(this.name, this.age);
}

final userInfoProvider = Provider.autoDispose.family<String, User>(
    (ref, user){
      return 'name: ${user.name}, age: ${user.age}';
    },
);

// 불변 상태를 선언합니다.
// 구현을 돕기 위해 Freezed와 같은 패키지를 사용할 수도 있습니다.
@immutable
class Todo {
  const Todo({
    required this.id,
    required this.description,
    required this.completed,
  });

  // 모든 프로퍼티는 클래스에서 'final'이어야 합니다.
  final String id;
  final String description;
  final bool completed;

  // Todo는 불변 객체라서 변경할 수 없으므로
  // 약간 다른 내용으로 할일을 복제할 수 있는 메서드를 구현했습니다.
  Todo copyWith({String? id, String? description, bool? completed}) {
    return Todo(
      id: id ?? this.id,
      description: description ?? this.description,
      completed: completed ?? this.completed,
    );
  }
}


class MyNotifier extends Notifier<Todo>{
  @override
  Todo build() {
    return Todo(id: '123', description: 'Wake up', completed: false);
  }

  void funA(){
    var myVar = Todo; // myVar는 투두 클래스 자체에 대한 레퍼런스가 됨
    var myVar2 = Todo; // 두 변수는 같은 값을 가짐.
    print("what's this : $myVar");
    print("what's this : ${Todo(id: '123', description: 'Wake up', completed: false)}");
    print("are they same? : ${myVar == Todo}");
    print("are they same? : ${myVar is Todo}");
    print("are they same? : ${myVar == myVar2}");
  }
}

final myNotifierProvider = NotifierProvider<MyNotifier, Todo>((){
  return MyNotifier();
});


class IntNotifier extends Notifier<int>{
  @override
  int build() {
    return 1;
  }

  void increment(){
    print('increment');
    state++;
  }

  void decrement(){
    print('decrement');
    Future.delayed(Duration(seconds: 1), (){
      state--;
    });
  }
}

final intNotifierProvider = NotifierProvider<IntNotifier, int>((){
  return IntNotifier();
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
    print('MyApp build');
    // var notifier = ref.watch(intNotifierProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Providers')),
        body: Center(
          child: Column(
            children: [
              Text(ref.watch(helloWorldProvider)),
              Text(ref.watch(myAutoDisposeProvider)),
              // Text(ref.watch(myAutoDisposeProvider2)),
              Text(ref.watch(myFamilyProvider(10))),
              Text(ref.watch(myFamilyProvider(20))),
              Text('${ref.watch(userInfoProvider(User("Kim", 22)))}'),
              Text('${ref.watch(myNotifierProvider.notifier).state}'),
              ElevatedButton(onPressed: (){
                  ref.read(myNotifierProvider.notifier).funA();
                }, child: Text('funA')
              ),
              Text('${ref.watch(intNotifierProvider)}'),
              Text('${ref.watch(intNotifierProvider.notifier)}'),
              Text('${ref.watch(intNotifierProvider.notifier).state}'),
              // Text('${notifier}'),
              ElevatedButton(
                  onPressed: (){
                    ref.read(intNotifierProvider.notifier).increment();
                  },
                  child: Text('increment')
              ),
              ElevatedButton(
                  onPressed: (){
                    ref.read(intNotifierProvider.notifier).decrement();
                  },
                  child: Text('decrement')
              ),
            ],
          ),
        ),
      ),
    );
  }
}
