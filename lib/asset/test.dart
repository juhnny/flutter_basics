import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

// 애셋은 AssetBundle 클래스의 loadString()이나 load() 함수로 이용
// loadString은 애셋의 데이터를 문자열로 불러오며, load()는 반환타입이 Byte Data인 이미지나 바이너리 데이터를 불러오는 함수

// AssetBundle은 추상클래스이므로 직접 생성해서 사용할 수 없고, rootBundle이나 DefaultAssetBundle을 이용해서 AssetBundle 타입의 객체로 사용해야 함
// - rootBundle: 애플리케이션 전역에서 사용하는 AssetBundle. flutter/services.dart에 선언된 AssetBundle 타입의 속성이다.
// - DefaultAssetBundle: 위젯에서 사용하는 AssetBundle
// rootBundle을 이용하면 애플리케이션 전역에서 애셋을 이용할 수 있다.
// 하지만 될 수 있으면 DefaultAssetBundle을 사용하는 게 좋다.(왜?)
// DefaultAssetBundle은 위젯에서 사용하는 AssetBundle을 만들어주므로 rootBundle보다 테스트가 쉽다.
// 그러나 DefaultAssetBundle을 이용하려면 BuildContext 객체가 있어야 하며 이를 이용할 수 없을 땐 어쩔 수 없이 rootBundle을 이용해야 한다.
// if you have the BuildContext (inside a widget) you can use DefaultAssetBundle.
// This is recommended because it allows switching asset bundles at runtime, which is useful for multilingual assets.
class MyApp extends StatelessWidget{
  // rootBundle을 이용해 애셋 파일을 읽어 반환하는 함수
  // Future는 비동기 데이터를 의미
  Future<String> useRootBundle() async {
    String result = '';
    try{
      result = await rootBundle.loadString('assets/texts/my_text.txt');
    } catch(e){
      result = 'error';
      print('Error loading file: $e');
    }
    return result;
  }

  Future<String> useDefaultAssetBundle(BuildContext context) async {
    return await DefaultAssetBundle.of(context).loadString('assets/texts/my_text.txt');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              // Image.asset은 내부적으로 AssetBundle 클래스를 이용
              Image.asset('images/big.jpeg'),
              // FutureBuilder는 비동기 데이터를 이용해 화면을 구성하는 위젯
              // future에 전달한 Future가 반환한 값이 snapshot으로 전달되며 이 값으로 화면 구성
              FutureBuilder(
                future: useRootBundle(),
                builder: (context, snapshot){
                  return Text('rootBundle: ${snapshot.data}');
                }
              ),
              FutureBuilder(
                future: useDefaultAssetBundle(context),
                builder: (context, snapshot){
                  return Text('DefaultAssetBundle: ${snapshot.data}');
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
