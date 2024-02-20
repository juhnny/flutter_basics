
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin{
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('TabBarView'),
            bottom: TabBar(
              controller: controller,
              tabs: [
                Tab(text: 'One',),
                Tab(text: 'Two',),
                Tab(text: 'Three',),
                // Tab(text: 'One', icon: Icon(Icons.alarm),),
                // Tab(text: 'Two', icon: Icon(Icons.alarm),),
                // Tab(text: 'Three', icon: Icon(Icons.alarm),),
              ],
              // tabAlignment: TabAlignment.center,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            bottomOpacity: 0.5,
          ),
          body: TabBarView(
            controller: controller,
            children: [
              HomeScreen(),
              HomeScreen(),
              HomeScreen(),
            ],
          )
      ),
    );
  }
}

// TabBarView
// 탭바뷰는 탭 화면을 구성하는 위젯
// 탭 화면은 탭 버튼 개수만큼 필요하며 한번에 하나만 출력해야 함
// TabBar를 눌렀을 때 TabBarView가 화면에 나오는 건 controller가 자동으로 처리해줌. 단, TabBar와 TabBarView에 같은 controller를 지정해줘야 함.
// 애니메이션을 주려면 SingleTickerProviderStateMixin 속성을 with로 설정하고, TabController를 생성할 때 vsync를 this로 설정한다.
class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Screen'),
        ],
      ),
    );
  }
}