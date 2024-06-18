import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics/retrofit/rest_client.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(onPressed: (){

                final dio = Dio();
                dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
                RestClient(dio).version({'appName':'com.pildservice.madang', 'os':'aos'})
                    .then((value) {
                      print(value is Map);
                      print(value is String);
                      // print('value: ${value.toString()}');
                      // print('value: ${value['body'].toString()}');
                  return null;
                }).catchError((e, s){
                  print(e);
                  print(s);
                });

              }, child: Text('Call')),

              ElevatedButton(onPressed: (){

                final dio = Dio();
                dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
                RestClient(dio).namedExample('apiKeyxxx', 'scopexxx', 'typexxx', 5)
                    .then((value) {
                      print(value);
                  return null;
                }).catchError((e, s){
                  print(e);
                  print(s);
                });

              }, child: Text('Need Example')),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, Object> get headers {
    return {
      'accept': "application/json",
      // todo 지정해야 하는지?
      // 'content-type': "",
    };
  }
}