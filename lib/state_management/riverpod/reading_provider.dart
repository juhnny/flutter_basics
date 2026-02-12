import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// Reading a provider
// https://riverpod.dev/docs/concepts/reading
//
// 프로바이더를 읽기 위해서는 가장 먼저 ref 객체를 얻어야 한다.
// ref 객체는 위젯이나 다른 프로바이더에서 프로바이더와 소통할 수 있게 해준다.

// Provider를 통해 ref 얻기
// 모든 프로바이더는 파라미터로 ref 객체를 받는다.

// 위젯에서 ref 얻기
// ConsumerWidget를 사용할 때 : build 함수의 파라미터에서 얻기
// ConsumerStatefulWidget과 ConsumerState을 사용할 때 : ConsumerState의 프로퍼티로 ref가 존재

// StateNotifier를 사용할 때 흔히 이렇게 Provider의 ref 객체를 전달해서 사용한다고 한다.
class User{
  String name;
  int age;

  User(this.name, this.age);

  void post(String str){
    print(str);
  }
}

final userProvider = Provider<User>((ref){
    return User('Park', 23);
  },
);

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier(this.ref) : super(0); // 여기서 super 생성자의 파라미터가 state

  final Ref ref;
  // Notifiers should not have public properties besides the built-in state, as the UI would have no mean to know that state has changed.
  // Notifier 내에는 내장돼있는 state 프로퍼티 외에는 다른 public 프로퍼티가 없어야 한다고 하는데 두번째로 나오는 state가 기본 state를 말하는 건지, 개발자가 추가한 프로퍼티를 말하는 건지 모르겠다.
  // String abc = "abc";

  User getUser() {
    // Counter can use the "ref" to read other providers
    final user = ref.read(userProvider);
    return user;
  }

  void increment(){
    state++;
  }
}

final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier(ref);
});

void main(){
  runApp(
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int counter = ref.watch(counterProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Providers')),
        body: Center(
          child: Column(
            children: [
              Text('${ref.watch(counterProvider)}'),
              Text('$counter'),
              Text(ref.watch(counterProvider.notifier).getUser().name),
              // Text(ref.read(counterProvider.notifier).abc),
              ElevatedButton(
                onPressed: (){
                  ref.read(counterProvider.notifier).increment();
                  ref.read(counterProvider.notifier).getUser().post('Hello');
                },
                child: Text('Increment'))
            ],
          ),
        ),
      ),
    );
  }
}

// ref 사용법
// .watch : 프로바이더의 변경에 반응하고 값을 가져온다. 값이 바뀔 때 그 값을 구독한 위젯이나 프로바이더를 재빌드한다.
// .listen : 프로바이더가 변경될 때마다 (화면 이동이나 모달 띄우기 같은) 어떠한 작업을 해주기 위함. 에러가 났을 때 스낵바를 띄운다거나.
// .read : 프로바이더의 변경은 무시하고 값만을 얻어온다. onClick 같은 이벤트에서 사용

// 주의! watch 메소드를 onPressed 같은 곳에서 비동기적으로 호출하거나 initState 내부처럼 State의 라이프사이클과 관련된 곳에서 사용해도 안된다. 이러한 경우엔 read를 대신 쓴다.
// 주의! listen 메소드 또한 onPressed 같은 곳에서 비동기적으로 호출하거나 initState 내부처럼 State의 라이프사이클과 관련된 곳에서 사용해선 안된다.
// read는 반응형이 아니기 때문에 사용을 피해야 한다. watch나 listen을 썼을 때 문제가 생기는 경우를 제외하면 거의 언제나 watch나 listen을(그 중에서도 watch) 쓰는 게 낫다.

// ref.watch
// Provider의 ref를 이용해 두 프로바이더의 값을 조합한 프로바이더를 만들 수도 있다.
// 예시) 필터 타입을 이용해 할일 목록을 필터링한 목록을 만들어낸다.
// 필터나 할일 목록 둘 중 하나만 바뀌어도 필터링된 목록이 자동으로 업데이트 된다.
// 필터나 할일 목록이 그대로라면 필터링된 목록을 재계산하지 않는다.
enum FilterType{
  none,
  completed,
}

class Todo {
  String title;
  bool isCompleted;

  Todo({required this.title, required this.isCompleted});
}

final filterTypeProvider = Provider<FilterType>((ref) => FilterType.none);
final todosProvider = Provider<List<Todo>>((ref) => []);

final filterdTodosProvider = Provider<List<Todo>>((ref){
  FilterType filter = ref.watch(filterTypeProvider);
  List<Todo> todos = ref.watch(todosProvider);

  switch(filter){
    case FilterType.completed:
      return todos.where((todo) => todo.isCompleted).toList();
    case FilterType.none:
      return todos;
  }
});

// ref.listen
// watch가 관찰중인 프로바이더가 변경될 때 프로바이더나 위젯을 재빌드하기 위함이라면 listen은 원하는 함수를 실행시키기 위함
// 프로바이더에서도 쓸 수 있고, 위젯이 빌드 메소드 안에서 쓸 수도 있다.
final someProvider = Provider<int>((ref){
  // listen의 파라미터로는 관찰할 프로바이더와 변경이 감지됐을 때 실행할 콜백 함수다.
  // 콜백함수의 파라미터로는 이전 값과 다음 값이 전달된다.
  ref.listen(todosProvider, (previous, next) {
    print('Todos changed - prev: ${previous?.length}, next: ${next.length}');
  });
  return 0;
});

// ref.read
// 상태 변화를 관찰하지는 않고 값만 가져오므로 사용자 이벤트에 주로 사용된다.
// build 메소드 안에서 (watch를 쓰면 안되는 경우가 아니라면) read 대신 watch를 써야 하는 이유. https://riverpod.dev/docs/concepts/reading#dont-use-refread-inside-the-build-method
// - 프로그램은 수정된다. 지금은 변하지 않도록 해둔 상태도 언제 변하게 될지 모른다. read를 사용했던 곳에 문제가 생기면 추적이 어려워진다.
// - 프로바이더는 재빌드 횟수를 줄이는 다양한 방법을 제공한다. watch를 써도 (프로바이더 설계만 잘 해뒀다면) 불필요하게 재생성되는 일을 똑같이 막을 수 있다.
// - ref.refresh()를 호출하면 StateController 객체가 새로 생성된다. read를 써뒀다면 이미 dispose돼서 사용할 수 없는 controller 객체를 참조하고 있게 된다. watch를 쓰면 참조하는 controller도 따라 바뀐다.


// Using "select" to filter rebuilds
// 기본적으로 프로바이더를 관찰하는 건 상태 객체 전체를 관찰하는 것이다.
// 때로는 프로바이더나 위젯에서 필요한 게 상태 객체의 일부 프로퍼티일 수 있다.

// User의 name이 바뀌는 것에만 관심이 있다고 하면..
// Whenever the User changes, Riverpod will call this function and compare the previous and new result.
// If they are different (such as when the name changed), Riverpod will rebuild the widget.
// However, if they are equal (such as when the age changed), Riverpod will not rebuild the widget.
final userNameProvider = Provider<String>((ref){
  String name = ref.watch(userProvider.select((user) => user.name));
  // listen과 함께 쓰는 것도 가능
  // You don't have to return a property of the object. Any value that overrides == will work. For example you could do.
  ref.listen(userProvider.select((user) => "Hello ${user.name}"),
      (previous, next) {
        // 원하는 작업
      }
  );
  return name;
},
);