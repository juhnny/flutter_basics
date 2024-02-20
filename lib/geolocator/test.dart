import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  // 안드로이드에서는 Manifest에 요청 가능한 권한 추가

  // iOS에서는 ios/Runner/info.plist 파일에 다음 키 추가
  // <key>NSLocationWhenInUseUsageDescription</key>
  // <string>This app needs access to location when open.</string>
  // ios/Podfile 파일에는 다음 코드 추가

  // geolocator 라이브러리 사용
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // OS 설정의 Location Services 스위치가 켜져있는지를 체크
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // 권한 요청 다이얼로그를 띄우는 함수 requestPermission()
      // 사용자가 선택한 결과를 반환받아 다시 한번 체크
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('BottomNavigationBar'),),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: (){
                    Future<Position> future = _determinePosition();
                    future.then((value) => print(value.toString()));
                    future.catchError((error) => print('catchError: $error'));
                  },
                  child: Text('Get Location')
              ),
            ],
          ),
        ),
      ),
    );
  }
}