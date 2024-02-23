// throw에서 예외 대신 다른 걸 던져도 된다.
import 'dart:async';
import 'dart:io';

void fun1(){
  throw TimeoutException('My exception');
}

// 아무 객체나 던져도 된다. 이건 몰랐네.
void fun2(){
  throw Object();
}
void fun3(){
  throw 'error';
}



// try~on~finally 처리
void fun4(){
  try {
    fun1(); // throw 발생
    print('윗줄에서 에러나면 이 줄은 실행 안 됨');
    fun3(); // 근데 얘가 실행되면 문자열이 반환되는데 on으로 잡을 수 있나? 바로 finally로 가나?

  } on IOException { // catch문 없는 catch block
    print('IOException');

  } on TimeoutException catch(e) { // catch를 쓰면 발생할 예외를 전달받을 수 있음
    print('Timeout: $e');

  } finally {
    // 예외에 상관없이 무조건 실행할 코드
    print('Finally..');
  }

  // 예외 종류를 가리지 않겠다면 다음처럼 심플하게도 가능
  try {

  } catch(e){

  }
}

