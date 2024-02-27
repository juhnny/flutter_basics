import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(ParentScreen());
}

// 18-1 위젯의 상태 관리하기

// 상태란 변경되는 데이터
// 위젯의 상태를 관리하는 경우는 크게 3가지
// - 위젯 자체의 상태를 이용
// - 상위 위젯의 상태를 이용
// - 위젯 자체의 상태와 상위 위젯의 상태를 함께 이용
// 첫번째는 상태 데이터를 해당 위젯에서 선언하고 관리하면 그만. 보통 StatefulWidget으로 만든다.

// 인스타그램 같은 게시물 화면을 생각해보자.
// 한 화면 내에 네 개의 StatefulWidget이 있을 경우 각각 서버에서 데이터를 가져와 관리하게 만들면 그만일까?
// 위젯은 나뉘어져 있지만 각 위젯이 관리하는 데이터는 모두 게시물 하나를 구성하는 데이터. 상위위젯 한 곳에서 한번만 네트워킹 하는 것이 효율적
// 게다가 A 하위 위젯이 B 하위 위젯과 공유해야 하는 데이터가 있다면? 이 경우에도 상위 위젯에서 데이터를 관리하는 게 효율적
// 상위위젯 한 곳에서 데이터를 관리하고 통신하면 하위위젯들은 Stateless로 만들고 상위 위젯만 Stateful로 만들면 된다.

// ParentWidget 내에 좋아요 아이콘 위젯과 좋아요 개수를 보여주는 위젯이 있다고 해보자.
// 두 위젯은 좋아요 개수 데이터를 받아와야 하고, 아이콘 위젯은 부모의 상태를 바꿔주는 함수도 전달받아야 한다. 생성자를 통해 전달한다.
class ParentScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ParentScreenState();
  }
}

class _ParentScreenState extends State<ParentScreen>{
  bool liked = false;
  int count = 0;

  _toggleLike() {
    setState(() {
      liked = !liked;
      liked? count++: count--;
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
              IconWidget(liked: liked, onToggle: _toggleLike,),
              ContentWidget(count: count),
              // 하지만 전달이 몇 단계를 거쳐 이뤄져야 한다면 생성자가 상당히 복잡해질 것이다.
              // 생성자를 통해 전달하지 않고도 상위 위젯의 상태, 하위 위젯의 상태를 얻는 방법이 있다.
              // findAncestorStateOfType, GlobalKey 의 사용법은 다음 파일에서 알아보자.
            ],
          ),
        ),
      ),
    );
  }
}

class IconWidget extends StatelessWidget{
  bool liked;
  Function onToggle;

  IconWidget({this.liked = false, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        liked? Icons.thumb_up : Icons.thumb_up_outlined,
        size: 50,
      ),
      color: Colors.red,
      onPressed: (){
        onToggle();
      },
    );
  }
}

class ContentWidget extends StatelessWidget{
  int count;

  ContentWidget({required this.count});

  @override
  Widget build(BuildContext context) {
    return Text('Like: $count');
  }
}