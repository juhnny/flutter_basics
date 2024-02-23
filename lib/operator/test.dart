// 나누기 연산자
// / 만 쓰면 결과를 실수로 반환, ~/를 쓰면 소수점 아래를 버리고 결과를 정수로 반환
import 'package:flutter_basics/function/test.dart';

double a = 10 / 3;
// int b = 10 / 3; // 오류
int c = 10 ~/ 3;

// 타입 확인과 변환
// is 를 쓰면 타입 확인(과 동시에 자동 형 변환도!)
// as를 쓰면 명시적 형 변환
class User{
  String name = "Ko";
  int age = 10;

  void some(){}
}

void f1(int a){
  Object obj = User();

  // obj.some(); // 오류

  if(obj is User){ // 타입 확인과 동시에 자동 형 변환
    obj.some();
  }

  (obj as User).some(); // 명시적 형 변환

  (obj as String).trim(); // 음. 이런 불가능한 형변환도 일단 린트 에러는 안 나네
}

// 반복해서 접근하기
// .. 연산자는 같은 객체를 반복 접근할 때 편리한 cascade 연산자
// ?.. 연산자는 Nullable 객체일 때 사용
void f2(User? user){
  user
    ?..name = "Kim"
    ..age = 20 // ?.. 연산자는 cascade에서 첫번째에 위치해야 하고 두번째부터는 .. 사용
    ..some();
}
