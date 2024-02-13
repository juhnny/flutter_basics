import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics/webview/test.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Carousel slider'
          ),
        ),
        body: CarouselWithIndicatorDemo()
      ),
    );
  }
}

// CarouselSlider를 통해 보여줄 위젯 리스트
List<Widget> exampleSliders = [1, 2, 3, 4, 5].map((i){
  return Builder(
      builder: (BuildContext context){
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            color: Colors.amber,
          ),
          child: Text('text $i', style: TextStyle(fontSize: 16.0),),
        );
      });
}).toList();

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

// CarouselSlider를 통해 보여줄 위젯 리스트
final List<Widget> imageSliders = imgList
    .map((item) => Container(
      margin: EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: (){
          print('click..');
        },
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.network(item, fit: BoxFit.cover, width: 1000.0),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      'No. ${imgList.indexOf(item)} image',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    ))
    .toList();

class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carousel with indicator controller demo'),
        centerTitle: false,
        backgroundColor: Colors.green,
        foregroundColor: Colors.purple,
        elevation: 8,
        // leading: IconButton(icon: Icon(Icons.menu_book), onPressed: null),
        actions: [
          IconButton(
            icon: Icon(Icons.image),
            onPressed: (){

            }),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: (){

            })
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.blue,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Text("Header"),
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
              ),
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('images/big.jpeg'),
                ),
                otherAccountsPictures: [
                  CircleAvatar(
                    backgroundImage: AssetImage('images/big.jpeg'),
                  )
                ],
                accountEmail: Text('dev.yakkuza@gmail.com'),
                accountName: Text('Dev Yakuza'),
                onDetailsPressed: () {
                  print('press details');
                },
                decoration: BoxDecoration(
                    color: Colors.blue[300],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    )),
              ),
              ListTile(
                title: Text('Item1'),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Item2'),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(children: [
            Container(
              color: Colors.yellow,
              child: CarouselSlider(
                items: imageSliders,
                carouselController: _controller,
                options: CarouselOptions(
                    aspectRatio: 16/9,
                    viewportFraction: 0.8,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(milliseconds: 3000),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    initialPage: 3,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imgList.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 12.0,
                        height: 12.0,
                        margin:
                            EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.red)
                                .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ]),
          Container(
            color: Colors.red,
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                )
              ),
              child: GestureDetector(
                onTap: (){
                  print('clicked');
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('택배 신청하기'),
                      Text('정보 등록 시 간편하게 신청 가능합니다.'),
                      SizedBox(height: 10),
                      Text('14:00 이전 신청 시 당일 배송 가능'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 100,
            color: Colors.orange,
          ),
          SizedBox(
            height: 100,
          ),
          Container(
            height: 100,
            color: Colors.yellow,
          ),
        ]),
      ),
    );
  }
}