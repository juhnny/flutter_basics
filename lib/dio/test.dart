import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                  // GET 방식으로 요청하기
                  // 다른 예제에서는 생략했지만 try-catch를 해주는 게 좋겠다.
                  try {
                    // 파라미터는 URL에 직접 ?로 추가해도 되고 queryparameters 변수에 Map 객체로 지정해도 된다.
                    // var response = await Dio().get('https://reqres.in/api/users?page=2');
                    var response = await Dio().get(
                        'https://reqres.in/api/users',
                      queryParameters: {
                          'page': 2,
                      }
                    );
                    if(response.statusCode == 200){
                      setState(() {
                        result = response.data.toString();
                      });
                    }
                  } catch(e) {
                    print(e);
                  }

                },
                child: Text('GET'),
              ),
              ElevatedButton(
                onPressed: () async {
                  try{
                    // POST, PUT, DELETE 방식도 가능
                    // post() 사용할 경우
                    var response = await Dio().post(
                      'https://reqres.in/api/users',
                       data :{
                        'name': "jun",
                        'job': "teacher"
                      },
                    );
                    if(response.statusCode == 200 || response.statusCode == 201){
                      setState(() {
                        result = response.data.toString();
                      });
                    } else {
                      print('http error...: ${response.headers}');
                    }

                  } catch(e) {
                    print('error...');
                  }

                },
                child: Text('POST'),
              ),
              ElevatedButton(
                onPressed: () async {
                  try{
                    // request 메소드를 이용하고 방식은 options로 지정할 수도 있다.
                    var response = await Dio().request(
                      'https://reqres.in/api/users',
                       data :{
                        'name': "jun",
                        'job': "teacher"
                      },
                      options: Options(method: 'POST'),
                    );
                    if(response.statusCode == 200 || response.statusCode == 201){
                      setState(() {
                        result = response.data.toString();
                      });
                    } else {
                      print('http error...: ${response.headers}');
                    }

                  } catch(e) {
                    print('error...');
                  }

                },
                child: Text('Request'),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Dio 객체 생성 시 옵션으로 다양한 설정 가능
                  var dio = Dio(BaseOptions(
                    baseUrl: 'https://reqres.in/api/',
                    connectTimeout: Duration(seconds: 5),
                    sendTimeout: Duration(seconds: 5),
                    receiveTimeout: Duration(seconds: 5),
                    headers: {
                      HttpHeaders.contentTypeHeader: 'application/json',
                      HttpHeaders.acceptHeader: 'application/json'
                    },
                  ));
                  var response = await dio.get('users?page=2');
                  setState(() {
                    result = response.data.toString();
                  });
                },
                child: Text('Dio with options'),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Dio에서는 여러 요청을 리스트로 동시에 처리할 수 있다.
                  // Future.wait을 이용해 모든 요청이 끝날 때까지 기다린다.
                  // 결과도 리스트로 온다.
                  var dio = Dio(BaseOptions(baseUrl: 'https://reqres.in/api/'));
                  List<Response<dynamic>> response = await Future.wait([
                    dio.get('users?page=2'),
                    dio.get('users?page=3')
                  ]);

                  String temp = '';
                  response.forEach((element) {
                    if(element.statusCode == 200){
                      temp = temp + "\n\n" +element.data.toString();
                    }
                    setState(() {
                      result = temp;
                    });
                  });
                },
                child: Text('Multiple requests'),
              ),
              Image.asset('images/big.jpeg'),
              ElevatedButton(
                onPressed: () async {
                  // 파일 전송하기
                  // 파일을 전송하려면 파일을 MultipartFile 객체로 준비해야 한다.
                  // MultipartFile 객체 하나가 전송할 파일 하나를 의미하며, MultipartFile 객체 여러개를 List에 담아 한번에 전송할 수도 있다.
                  // 파일을 읽어들여 만들 수도 있고, 파일을 읽어들인 바이트 데이터를 읽어들여 만들 수도 있다.
                  var dio = Dio(BaseOptions(baseUrl: 'https://reqres.in/api/'));
                  // 짜증나. 아무리 my_text.txt 파일을 여기저기 만들어봐도 PathNotFoundException가 발생한다. 구글링해도 마땅한 답이 안나온다.
                  // var multipartFile = await MultipartFile.fromFile('../my_text.txt');
                  // var multipartFile = await MultipartFile.fromFile('assets/texts/my_text.txt', filename: 'upload.txt'); // filename은 옵션

                  // 바이트 데이터를 이용할 땐 이렇게 한다... 고 예시는 있지만 방식이 바뀌었는지 에러가 난다.
                  // var multipartFile2 = MultipartFile.fromBytes(
                  //   imageData,
                  //   filename: 'upload_image',
                  //   contentType: MediaType("image", "jpg"),
                  // );

                  // MultipartFile을 전송하려면 FormData 객체에 담아야 한다.
                  // FormData는 MultipartFile 뿐만 아니라 서버에 전송할 여러가지 데이터를 표현하는 객체
                  // 파일을 전송하려면 POST 방식을 이용해야 한다.
                  var formData = FormData.fromMap({
                    // 키는 서버에서 요구하는 키를 사용한다.
                    'name':"Jun",
                    // 짜증나. 아무리 my_text.txt 파일을 여기저기 만들어봐도 PathNotFoundException가 발생한다. 구글링해도 마땅한 답이 안나온다.
                    // 'file': await MultipartFile.fromFile('assets/texts/my_text.txt', filename: 'upload.txt') // filename은 옵션
                  });
                  var response = await dio.post('/info', data: formData);

                  setState(() {
                    result = response.data.toString();
                  });
                },
                child: Text('MultipartFile'),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Interceptor
                  // 인터셉터를 이용하면 요청이나 응답을 가로챌 수 있다.
                  // 서버 연동 시마다 똑같이 실행할 코드를 작성할 수 있다.
                  // Interceptor를 상속받는 클래스를 만들거나 이미 만들어진 InterceptorsWrapper 클래스를 이용할 수 있다.
                  var dio = Dio();
                  // dio.interceptors.add(MyInterceptor());
                  try {
                    dio.interceptors.add(InterceptorsWrapper(
                      onRequest: (options, handler){
                        print('InterceptorsWrapper request... ${options.method}, ${options.path}');
                        print('InterceptorsWrapper request... ${options.data}');
                        // handler.next()를 호출해야 서버에 요청이 간다.
                        handler.next(options);

                        // handler.next 대신 handler.resolve를 호출하면 임의의 데이터를 만들어서 서버에서 응답한 것처럼 처리할 수도 있다
                        // handler.resolve(Response(requestOptions: options, data:'fake data'));

                        // 요청 대기시키기
                        // dio.lock(), dio.unlock()이 있었는데 다른 방식으로 바뀐 거 같다.
                      },
                      onResponse: (response, handler){
                        print('InterceptorsWrapper reponse... ${response.statusCode}, ${response.requestOptions.path}');
                        print('InterceptorsWrapper reponse... ${response.data}');
                        // handler.next()를 호출해야 결과값이 반환된다.
                        handler.next(response);
                      },
                      onError: (err, handler){
                        print('InterceptorsWrapper error... ${err.response?.statusCode}, ${err.requestOptions.path}');
                      }
                    ));

                    // 통신 내용을 Log로 찍어주는 interceptor
                    dio.interceptors.add(LogInterceptor(
                      logPrint: (object){
                        debugPrint(object.toString());
                      }
                    ));
                  } catch (e, s) {
                    print(s);
                  }
                  var response = await dio.post(
                    'https://reqres.in/api/users',
                    data: {
                      "name": "Jun",
                      "job": "Student",
                    }
                  );
                  setState(() {
                    result = response.data.toString();
                  });
                },
                child: Text('Custom Interceptor'),
              ),

              Text('$result'),
            ],
          ),
        ),
      ),
    );
  }
}

class MyInterceptor extends Interceptor{
  // 아래 세 함수를 모두 재정의할 필요는 없다. 필요한 것만 작성하면 된다.
  // 요청을 가로챔
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('request... ${options.method}, ${options.path}');
    print('request... ${options.data}');
    // supoer.onRequest를 호출해야 서버에 요청이 간다.
    super.onRequest(options, handler);
  }
  // 응답을 가로챔
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('reponse... ${response.statusCode}, ${response.requestOptions.path}');
    print('reponse... ${response.data}');
    // supoer.onResponse를 호출해야 결과값이 반환된다(아마도)
    super.onResponse(response, handler);
  }
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    print('error... ${err.response?.statusCode}, ${err.requestOptions.path}');
  }
}