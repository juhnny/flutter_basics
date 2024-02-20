import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  // 안드로이드에서는 Manifest에 요청 가능한 권한 추가
  // iOS에서는 ios/Runner/info.plist 파일, ios/Podfile 파일 수정

  // permission_handler 라이브러리 사용

  // location 권한을 기준으로 작성된 코드
  // Permission.location.request() - 권한이 부여되지 않았을 경우 권한을 요청하고 결과를 반환
  // Permission.location.status - 권한 부여 상태 반환
  //    isGranted - 권한 동의 상태 시 true
  //    isLimited - 권한이 제한적으로 동의 상태 시 true (ios 14버전 이상)
  //    isPermanentlyDeined - 영구적으로 권한 거부 상태 시 true (android 전용, 다시 묻지 않음)
  //        Permission.location.status는 영구 거부 해도 denied 반환
  //        openAppSettings() - 앱 설정 화면으로 이동
  //    isRestricted - 권한 요청을 표시하지 않도록 선택 시 true (ios 전용)
  //    isDenied - 권한 거부 상태 시 ture
  void _locationPermission() async {
    var requestStatus = await Permission.location.request();
    var status = await Permission.location.status;

    if (requestStatus.isGranted && status.isLimited) { // isLimited - 제한적 동의 (ios 14 < )
      // 요청 동의됨
      print("isGranted");

      if (await Permission.locationWhenInUse.serviceStatus.isEnabled) { // gps 켜짐
        // var position = await Geolocator.getCurrentPosition();
        var position = 'NoPosition';
        print("serviceStatusIsEnabled position = ${position.toString()}");

      } else { // gps 꺼짐
        print("serviceStatusIsDisabled");
      }

    } else if (requestStatus.isPermanentlyDenied ||
        status.isPermanentlyDenied) {
      // 권한 요청 거부, 해당 권한에 대한 요청에 대해 다시 묻지 않음 선택하여 설정화면에서 변경해야함. android
      print("isPermanentlyDenied");
      openAppSettings();

    } else if (status.isRestricted) {
      // 권한 요청 거부, 해당 권한에 대한 요청을 표시하지 않도록 선택하여 설정화면에서 변경해야함. ios
      print("isRestricted");
      openAppSettings();

    } else if (status.isDenied) {
      // 권한 요청 거절
      print("isDenied");
    }

    print("requestStatus ${requestStatus.name}");
    print("status ${status.name}");
  }

  void _cameraPermission() async {
    var requestStatus = await Permission.camera.request();
    var status = await Permission.camera.status;

    if (requestStatus.isGranted && status.isLimited) { // isLimited - 제한적 동의 (ios 14 < )
      // 요청 동의됨
      print("isGranted");

      // 카메라 켜기

    } else if (requestStatus.isPermanentlyDenied ||
        status.isPermanentlyDenied) {
      // 권한 요청 거부, 해당 권한에 대한 요청에 대해 다시 묻지 않음 선택하여 설정화면에서 변경해야함. android
      print("isPermanentlyDenied");
      openAppSettings();

    } else if (status.isRestricted) {
      // 권한 요청 거부, 해당 권한에 대한 요청을 표시하지 않도록 선택하여 설정화면에서 변경해야함. ios
      print("isRestricted");
      openAppSettings();

    } else if (status.isDenied) {
      // 권한 요청 거절
      print("isDenied");
    }

    print("requestStatus ${requestStatus.name}");
    print("status ${status.name}");
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
                onPressed: _locationPermission,
                child: Text('Get Location Permission')
              ),
              ElevatedButton(
                onPressed: _cameraPermission,
                child: Text('Get Camera Permission')
              ),
            ],
          ),
        ),
      ),
    );
  }
}