import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  late SharedPreferences prefs;

  double sliderValue = 0.0;
  bool switchValue = false;

  // SharedPreferences에 사용자 정의 타입을 저장하는 것도 가능할까? 해보니 가능하다.
  Human human = Human('홍길동');
  TextEditingController textController = TextEditingController();

  _save() async {
    await prefs.setDouble('slider', sliderValue);
    await prefs.setBool('switch', switchValue);

    // 객체를 String화 할 때는 encode 한번만 하면 끝(내부에서 toJson 호출)
    human = Human(textController.text);
    await prefs.setString('human', jsonEncode(human));
  }

  _getInitData() async {
    prefs = await SharedPreferences.getInstance();
    sliderValue = prefs.getDouble('slider') ?? 0.0;
    switchValue = prefs.getBool('switch') ?? false;
    setState(() {});

    Human hum = prefs.get('human') as Human;
    print(hum.name);

    // String을 객체로 만들 때는 decode 후 fromJson을 한 번 더!
    String? humanString = prefs.getString('human');
    print('humanString: $humanString');
    if(humanString != null) {
      Map<String, dynamic> map = jsonDecode(humanString);
      human = Human.fromJson(map);
      textController.text = human.name;
    }
  }

  @override
  void initState() {
    super.initState();
    _getInitData();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('BottomNavigationBar'),),
        body: Center(
          child: Column(
            children: [
              Slider(
                value: sliderValue,
                min: 0,
                max: 10,
                onChanged: (double value){
                  setState(() {
                    sliderValue = value;
                  });
                },
              ),
              Switch(
                value: switchValue,
                onChanged: (value){
                  setState(() {
                    switchValue = value;
                  });
                },
              ),
              TextField(
                controller: textController,
                decoration: InputDecoration(
                  labelText: 'NAME',
                  hintText: 'HINT'
                ),
                onChanged: (String value){},
              ),
              ElevatedButton(
                  onPressed: _save,
                  child: Text('Save')
              ),
              ElevatedButton(
                  onPressed: _getInitData,
                  child: Text('Get')
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Human{
  String name;

  Human(this.name);

  Human.fromJson(Map<String, dynamic> json)
      : name = json['name'];

  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}