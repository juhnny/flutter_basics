import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

// StatelessWidget은 처음 생성할 때의 정보로만 화면이 구성되고 상태를 업데이트하지 않는다.
// 정적인 화면을 만들 때 사용한다.
class MyApp extends StatelessWidget{
  bool enabled = false;
  String stateText = "disabled";

  // 클릭하더라도 화면에 값이 업데이트되지 않는다.
  void checkState(){
    if(enabled) {
      stateText = "enabled";
      enabled = false;
    } else {
      stateText = "disabled";
      enabled = true;
    }
    print("enabled: $enabled, stateText: $stateText"); // 값은 변경되지만 화면에 반영되지 않음
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Stateless Widget"),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: checkState,
                icon: (enabled ? Icon(Icons.check_box, size: 20,) : Icon(Icons.check_box_outline_blank, size: 20,)),
                color: Colors.red,
              ),
              Container(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  '$stateText',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}