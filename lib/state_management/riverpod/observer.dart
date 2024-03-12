import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider Observer
// ProviderObserver 는 ProviderContainer 의 변화를 관찰하여, provider 의 상태를 모니터링 할 수 있게 해줍니다. providerObserver 를 통해 현재 앱에서 사용되는 상태(state)들을 모니터링 할 수 있고, 문제 발생시 원인을 파악하는데 도움을 줄 수 있다
//
// ProviderOberver 클래스를 상속 받아서 사용할 수 있고, 아래 3가지 메소드를 override 해서 사용할 수 있다.
//
// didAddProvider : provider 가 초기화 될때 마다 호출
// didDisposeProvider : provider 가 Dispose 될때 마다 호출
// didUpdateProvider : provider 값이 변경 될때 마다 호출
class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(
      ProviderBase provider,
      Object? previousValue,
      Object? newValue,
      ProviderContainer container,
      ) {
    print('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "$newValue"
}''');
  }

}

void main() {
  runApp(
    ProviderScope(observers: [Logger()], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

final counterProvider = StateProvider((ref) => 0, name: 'counter');

class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Counter example')),
      body: Center(
        child: Text('$count'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(counterProvider.notifier).state++,
        child: const Icon(Icons.add),
      ),
    );
  }
}