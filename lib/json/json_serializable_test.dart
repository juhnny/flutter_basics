import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json_serializable_test.g.dart';

// json_serializable
// 코드 자동완성을 통해 Map에서 객체로, 객체에서 Map으로 변환하는 메소드를 만들어주는 패키지
// 모델 클래스에서는 이 메소드들을 이용해 .fromJson 생성자와 toJson 메소드를 다소 간편하게 만들 수 있다.

// 터미널에서 다음 명령어 실행해 파일 자동 생성 : dart run build_runner watch -d

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

String jsonStr = '{"id": 1, "title": "hello", "completed": false, "location": {"latitude":"37.5", "longitude": "127.1"}}';

// JSON 데이터를 매핑하는 모델 클래스
@JsonSerializable(explicitToJson: true)
class Todo {
  // JSON 데이터의 키와 모델 클래스의 속성이 다를 경우 @JsonKey() annotation 사용
  @JsonKey(name: 'id')
  int todoId;
  String title;
  bool completed;
  // 중첩 클래스(nesed class. 모델 클래스 안에서 모델 클래스를 사용)가 사용될 경우 두 클래스 모두에 @JsonSerializable() 필요
  Location location;

  Todo(this.todoId, this.title, this.completed, this.location);

  // 다음 두 함수가 중요
  // jsonDecode() 함수로 만들어진 Map 객체를 클래스에 대입하는 생성자를 factory로 만든 후
  // _$TodoFromJson() 함수를 이용해 실제 JSON 데이터를 매핑해 객체를 생성
  // 코드 자동생성으로 만들어지는 함수 이름은 _$클래스명FromJson(), _$클래스명ToJson()
  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);
}

@JsonSerializable()
class Location {
  String latitude;
  String longitude;

  Location(this.latitude, this.longitude);

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

class _MyAppState extends State<MyApp>{
  Todo? todo;
  String result = '';

  decodeTodo(){
    setState(() {
      Map<String, dynamic> map = jsonDecode(jsonStr);
      todo = Todo.fromJson(map);
      setState(() {
        // result = "todo: ${todo?.id}, ${todo?.title}, ${todo?.completed}, ${todo?.location}";

        // 중첩 클래스인 location의 경우 값으로 "instance of 'Location'"이 출력된다.
        // @jsonSerializable()의 파라미터로 explicitToJson: true 추가해주면 제대로 값이 출력됨
        result = "decode: ${todo?.toJson()}";
      });
    });
  }

  encodeTodo(){
    setState(() {
      result = "encode: ${jsonEncode(todo)}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Json'),),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: (){
                  decodeTodo();
                },
                child: Text('Decode jsonStr'),
              ),
              ElevatedButton(
                onPressed: (){
                  encodeTodo();
                },
                child: Text('Decode Todo'),
              ),
              Text('result: \n$result'),
            ],
          ),
        ),
      ),
    );
  }
}