import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 통신을 할 때 객체를 그대로 사용할 수는 없다. 객체는 기기의 메모리에서만 유효한 데이터이기 때문
// 통신에는 구조화된 데이터 표현 방법이 필요한데 JSON을 가장 많이 사용한다.
// 인코딩은 Map 형식의 데이터를 문자열로 변환하는 작업이며, 데이터를 서버에 전송할 때 필요.
// 디코딩은 JSON 문자열을 Map 타입으로 변환하는 작업이며 서버로부터 전송받은 데이터를 사용할 때 필요

// jsonDecode, jsonEncode

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

// JSON 형식 문자열
String jsonStr = '{"id": 1, "title": "hello", "completed": false}';
String jsonArrayStr = '[{"id": 1, "title": "hello", "completed": false}, {"id": 2, "title": "world", "completed": true}]';

// JSON 데이터를 매핑하는 모델 클래스
class Todo {
  int id;
  String title;
  bool completed;

  Todo(this.id, this.title, this.completed);

  Todo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        completed = json['completed'];

  // toJson 함수는 jsonEncode 함수 내부에서 호출하므로 이름을 toJson으로 써야 함
  Map<String, dynamic> toJson() =>
      {'id': id, 'title': title, 'completed': completed};
}

class _MyAppState extends State<MyApp>{
  Todo? todo;
  String result = '';

  onPressDecode() {
    setState(() {
      // 키는 String이지만 값은 다양한 문자열, 숫자, 불리언 타입일 수 있으므로 dynamic으로 선언
      Map<String, dynamic> map = jsonDecode(jsonStr);
      result = "id: ${map['id']}";
    });
  }

  onPressDecodeArray() {
    setState(() {
      // 키는 String이지만 값은 다양한 문자열, 숫자, 불리언 타입일 수 있으므로 dynamic으로 선언
      List list = jsonDecode(jsonArrayStr);
      var element0 = list[0];
      result = "object: ${element0}, id:${element0['id']}, title: ${list[0]['title']}";
    });
  }

  onPressEncode(Object object){
    setState(() {
      result = jsonEncode(object);
    });
  }

  decodeTodo(){
    setState(() {
      Map<String, dynamic> map = jsonDecode(jsonStr);
      todo = Todo.fromJson(map);
      setState(() {
        result = "todo: ${todo?.id}, ${todo?.title}, ${todo?.completed}";
      });
    });
  }

  encodeTodo(){
    setState(() {
      result = jsonEncode(todo);
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
                  onPressDecode();
                },
                child: Text('Decode jsonStr'),
              ),
              ElevatedButton(
                onPressed: (){
                  onPressDecodeArray();
                },
                child: Text('Decode jsonArrayStr'),
              ),
              ElevatedButton(
                onPressed: (){
                  Map<String, dynamic> map = Map();
                  map['name'] = 'kim';
                  map['age'] = 13;
                  onPressEncode(map);
                },
                child: Text('Encode Map'),
              ),
              ElevatedButton(
                onPressed: (){
                  Map<String, dynamic> map = {'name':'kim', 'age': 13};
                  Map<String, dynamic> map2 = {'name':'park', 'age': 20};
                  List list = [map, map2];
                  onPressEncode(list);
                },
                child: Text('Encode List'),
              ),
              ElevatedButton(
                onPressed: (){
                  decodeTodo();
                },
                child: Text('Decode Todo'),
              ),
              ElevatedButton(
                onPressed: (){
                  encodeTodo();
                },
                child: Text('Encode Todo'),
              ),
              Text('result: \n$result'),
            ],
          ),
        ),
      ),
    );
  }
}