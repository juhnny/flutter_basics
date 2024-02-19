import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  String result = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                    // 응답 결과는 http.Response 타입으로 전달됨
                    // 헤더를 지정하고 싶다면 Map에 담아 인수로 지정
                    Map<String, String> headers = {
                      "content-type": "application/json",
                      "accept": "application/json",
                    };
                    http.Response response = await http.get(
                      Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
                      headers: headers,
                    );

                    setState(() {
                      if(response.statusCode == 200){
                        result = response.body;
                      }
                    });
                },
                child: Text('GET'),
              ),
              ElevatedButton(
                onPressed: () async {
                  // try문이 없다고 컴파일 에러가 나진 않지만 추가하는 게 좋은 듯
                  try{
                    // post(), put(), delete() 방식도 가능
                    // POST 방식 사용 시 본문에 포함할 데이터는 body 파라미터에 Map 형식으로 전달
                    http.Response response = await http.post(
                      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
                      body: {'title':'hello', 'body':'world', 'userId':'1'},
                    );

                    if(response.statusCode == 200 || response.statusCode == 201){
                      setState(() {
                        result = response.body;
                      });

                    } else {
                      print('http error...');
                    }

                  } catch(e) {
                    print('error...');
                  }

                },
                child: Text('POST'),
              ),
              ElevatedButton(
                onPressed: () async {
                  // 반복해서 요청할 경우
                  // 같은 URL로 반복해서 요청할 때는 매번 서버와 접속했다 끊었다 반복하는 것이 비효율적이므로
                  // Client 객체를 통해 한번 연결된 접속을 유지할 수 있다.
                  var client = http.Client();
                  try{ // try문이 없다고 컴파일 에러가 나진 않지만 추가하는 게 좋은 듯
                    http.Response response = await client.post(
                      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
                      body: {'title':'client', 'body':'world', 'userId':'2'},
                    );
                    print('http statusCode: ${response.statusCode}');

                    if(response.statusCode == 200 || response.statusCode == 201){
                      // 반복 요청
                      response = await client.get(
                          Uri.parse('https://jsonplaceholder.typicode.com/posts/1')
                      );
                      print('http statusCode: ${response.statusCode}');
                      setState(() {
                        result = response.body;
                      });

                    } else {
                      print('http error...');
                    }

                  } finally {
                    client.close();
                  }
                },
                child: Text('Client'),
              ),
              Text('$result'),
            ],
          ),
        ),
      ),
    );
  }
}