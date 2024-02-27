import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(ParentScreen());
}

// 18-1 위젯의 상태 관리하기

// findAncestorStateOfType
// 얻고자 하는 조상 위젯의 상태 클래스를 제네릭으로 지정하면 해당 타입의 상태를 찾아서 전달해준다.
// 이 예제에서는 IconWidget과 ContentWidget에서 이를 이용해 부모 위젯의 상태를 가져온다.
//
// GlobalKey
// 하위위젯을 생성할 때 키를 지정하고 이 키의 currentState 속성을 이용하면 상위 위젯에서 하위 위젯의 상태를 얻을 수 있다.
// 일반적으로 GlobalKey는 부모 위젯에서 생성되고 자식 위젯에게 전달됩니다.
// 일종의 레퍼런스 객체인 듯
// 이 예제에서는 ParentWidget에서 손자위젯(GrandChildWidget)에게 전달할 GlobalKey를 만들어 자식위젯(ChildWidget)에게 전달하고, 자식 위젯은 이 키를 이용해 손자 위젯을 만든다.
// 이제 ParentWidget에서 자식 위젯을 참조할 수 있다.
class ParentScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ParentScreenState();
  }
}

class _ParentScreenState extends State<ParentScreen>{
  bool liked = false;
  int count = 0;

  GlobalKey<_GrandChildWidgetState> grandChildKey = GlobalKey();
  bool isDarkMode = false;

  _toggleLike() {
    setState(() {
      liked = !liked;
      liked? count++: count--;
    });
  }

  getDayOrNight(){
    _GrandChildWidgetState? childState = grandChildKey.currentState;
    setState(() {
      isDarkMode = childState?.isDarkMode ?? false;
      print("isDarkMode: ${childState?.isDarkMode}");
      print("isDarkMode: $isDarkMode");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              IconWidget(),
              ContentWidget(),
              ChildWidget(childKey: grandChildKey),
              ElevatedButton(
                onPressed: getDayOrNight,
                child: Text('Apply Dark Mode'))
            ],
          ),
        ),
        backgroundColor: isDarkMode? Colors.grey : Colors.white,
      ),
    );
  }
}

class IconWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    _ParentScreenState? state = context.findAncestorStateOfType<_ParentScreenState>();

    return IconButton(
      icon: Icon(
        (state?.liked ?? false)? Icons.thumb_up : Icons.thumb_up_outlined,
        size: 50,
      ),
      color: Colors.red,
      onPressed: state?._toggleLike,
    );
  }
}

class ContentWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    _ParentScreenState? state = context.findAncestorStateOfType<_ParentScreenState>();

    return Text('Like: ${state?.count}');
  }
}

class ChildWidget extends StatelessWidget{
  GlobalKey<_GrandChildWidgetState>? childKey;

  ChildWidget({this.childKey});

  @override
  Widget build(BuildContext context) {
    return GrandChildWidget(key: childKey,);
  }
}

class GrandChildWidget extends StatefulWidget{
  GrandChildWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GrandChildWidgetState();
  }
}

class _GrandChildWidgetState extends State<GrandChildWidget>{
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Dark mode'),
        Switch(
            value: isDarkMode,
            onChanged: (bool){
              setState(() {
                isDarkMode = bool;
              });
            }
        ),
      ],
    );
  }
}