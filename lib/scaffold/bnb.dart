import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  int _selectedIndex = 0;
  List<Widget> _widgetList = [
    Text('First'),
    Text('Second'),
    Text('Third'),
  ];

  _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('BottomNavigationBar'),),
        body: Center(
          child: _widgetList.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting, // fixed, shifting
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          // 함수 이름은 상관없지만 void Function(int) 타입의 함수를 넣어줘야 함. 신기하네.
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'First',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Second',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Third',
              backgroundColor: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}