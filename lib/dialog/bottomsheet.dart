
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(),
          body: HomeScreen()
      ),
    );
  }
}

// showBottomSheet()나 showModalBottomSheet() 함수를 이용한다.
// showBottomSheet() : 바텀싯이 화면에 떠도 원래 화면에 있는 위젯에 이벤트를 가할 수 있다.
// showModalBottomSheet() : ~ 가할 수 없다.
class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  _dialog(){
    showBottomSheet(
      context: context,
      backgroundColor: Colors.yellow,
      builder: (context){
        return SafeArea( // SafeArea가 안 먹네. showModalBottomSheet()에서는 먹는데
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.add),
                title: Text('ADD'),
                onTap: (){
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.remove),
                title: Text('REMOVE'),
                onTap: (){
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
      }
    );
  }

  _dialog2(){
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.yellow,
      builder: (context){
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.add),
                title: Text('ADD'),
                onTap: (){
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.remove),
                title: Text('REMOVE'),
                onTap: (){
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: _dialog,
              child: Text('showBottomSheet')
          ),
          ElevatedButton(
              onPressed: _dialog2,
              child: Text('showModalBottomSheet')
          ),
        ],
      ),
    );
  }
}