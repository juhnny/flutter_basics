// Dart에서 함수는 톱 레벨, 클래스 내, 함수 내에 선언할 수 있다.

// 함수 오버로딩을 지원하지 않는다.
// 왜? 옵셔널 매개변수가 있어서 같은 이름의 함수를 여러개 만들 필요 없다.

// 함수의 매개변수는 타입을 명시하거나, var로 선언하거나, 명시하지 않을 수 있다.
// var 타입은 선언과 동시에 초기화하면 그 타입으로 결정되지만, 선언만 별도로 하면 dynamic 타입이 된다.
// var 타입 매개변수의 타입도 컴파일 시에는 알 수 없으므로 dynamic 타입이 된다.
// 타입을 명시하지 않아도 dynamic 타입이 된다.
void main(){
  fun1(1);

  fun2(1);
  fun2("abc");
  fun2(null);

  fun3(1);
  fun3("abc");
  fun3(null);
}

void fun1(int? a){
  a = 1;
  a = null;
}

void fun2(var b){
  b = 1;
  b = "abc";
  b = null;
}

void fun3(c){
  c = 1;
  c = "abc";
  c = null;
}

// 함수 반환 타입은 생략하면 dynamic이 된다.
// dynamic 반환 함수에서 return문으로 데이터를 반환하지 않으면 자동으로 null을 반환한다.
fun4(){
}

// 이건 내가 만든 예시. 반환 타입이 두 종류인데 컴파일 에러는 생기지 않는다.
fun5(){
  if(fun4() == null){
    return true;
  } else {
    return 'true';
  }
}

// 함수 호출 시에는 기본적으로 매개변수의 타입과 순서에 맞게 인자를 전달해야 한다.
void fun6(int a, String b, bool c){
  fun6(1, "abc", true);
}

// Dart에서는 함수의 매개변수를 선택적으로 지정하는 optional을 지원한다. 두가지 형태가 있다.
// - 명명된 매개변수 named parameter
// - 옵셔널 위치 매개변수 optional positional parameter

// 명명된 매개변수
// 옵셔널이므로 데이터를 전달하지 않을 수 있으며, 전달 시에는 '이름: 값' 형태로 이름을 함께 전달한다.
// 선언 시에는 매개변수 타입과 이름을 중괄호로 묶어 표현. 중괄호 표현은 여러번 할 수 없고, 순서상 일반 파라미터들보다 나중에 와야 한다.
// 기본인자(default argument)를 지정할 수 있고 지정하지 않을 경우 초기값이 null이므로 nullable로 선언하지 않으면 에러
void fun7(int a, {String? b, bool c = false}){
  fun7(1);
  fun7(1, c: true);
  fun7(1, c: true, b: "hello"); // 옵셔널끼리 순서가 바뀌어도 무방
}

// void fun8({int a, String? b}, bool c = false){} // 오류
// void fun9(int a, {String? b}, {bool c} = false}){} // 오류

// 명명된 매개변수 호출 규칙
// - 데이터를 전달하지 않을 수 있다.
// - 데이터를 전달할 때는 이름을 명시해야 한다.
// - 데이터를 전달할 때 선언된 순서와 일치하지 않아도 된다.

// 필수 매개변수 선언하기 - required
// 명명된 매개변수에 required 키워드를 붙이면 명명된 '필수' 매개변수가 된다.
// Q. 그러면 일반 매개변수로 선언하면 되잖아?
// 명명된 매개변수는 호출 시 이름을 명시해서 값을 전달하므로 가독성이 좋아지고, 매개변수 순서를 지키지 않아도 되서 편리.
void fun10({required int a}){
  fun10(a: 2);
}

// 옵셔널 위치 매개변수 optional positional parameter
// 데이터 전달은 선택이지만 전달 순서는 지켜줘야 하는 매개변수.
// 오히려 이름을 지정하면 오류
// 대괄호로 묶고, 일반 매개변수보다 뒤에 써줘야 하고, 기본인자 사용 가능
void fun11(int a, [String? b, bool? c]){
  fun11(1, "abc", true);
  // fun11(1, true, "abc"); // 순서와 타입이 맞지 않아 오류
  // fun11(a: 1, b: "abc"); // 이름을 지정해서 오류
  fun11(1, "abc"); // 일부만 전달할 때는 타입에 주의
  // fun11(1, true); // 오류
}


// 함수 타입 인수
// 함수를 대입할 수 있는 타입을 함수 타입function type이라고 함
// 다트에서는 모든 데이터가 객체이므로 함수도 객체.
// 다른 함수 객체에 대입하거나 함수의 매개변수, 반환값 등으로 쓸 수 있다.
void some() {}

// 다른 함수 객체에 대입
Function data = some;

int plus(int a){
  return a++;
}

int multiply(int a){
  return a * 2;
}

// 함수를 매개변수로 받기
int testFun(Function argFun, int a){
  return argFun(a);
}

// 함수를 반환하기
Function returnFun(int a){
  if(a == 0) {
    return plus;
  } else {
    return multiply;
  }
}

// 반환된 함수 사용
void testFun2(){
  print('result: ${returnFun(10)}');
}

// Function 타입의 반환 타입 제한
// 타입을 Function이라고만 쓰면 모든 함수를 대입 가능
bool negative(bool truth){
  return !truth;
}

void fun20(int f(int a)){
  fun20(plus);
  // fun20(negative); // 반환 타입이 bool이라서 오류
}

// 깡쌤이 알려준 선언은 위 표현이지만 에디터가 이렇게 바꾸라고 권하네. 나도 이게 더 맞는 표현 같다.
void fun21(int Function(int a) f){
  fun20(plus);

  fun20((int value){
    return value;
  });

  // fun20(negative); // 반환 타입이 bool이라서 오류
}


// 익명 함수 anonymouse functions
// 이름이 생략된 함수. 람다 함수 lambda function이라고도 한다.

// 함수 변수에 대입한 익명함수. 익명함수는 이름이 없으므로 독자적으로 사용할 수 없고 함수 타입에 대입할 함수를 정의할 때 사용
Function func = (arg){
  return arg;
};

// 함수를 함수를 데이터처럼 이용하게 해주는 기법은 함수형 프로그래밍의 근간이 됨
// List 클래스의 forEach 함수도 매개변수로 함수를 받는다.
// forEach 함수 정의
//   void forEach(void action(E element)) {
//     for (E element in this) action(element);
//   }
void test22(){
  List list = [1, 2, 3];
  list.forEach((element) {
    print('$element');
  });

  // 오 근데 이렇게 for문을 중괄호 없이 쓸 수도 있구나.
  for (int n in list) plus(n);
}
