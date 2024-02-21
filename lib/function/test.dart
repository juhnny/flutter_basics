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
// 기본값을 지정할 수 있고 지정하지 않을 경우 초기값이 null이므로 nullable로 선언하지 않으면 에러
void fun7(int a, {String? b, bool c = false}){
  fun7(1);
  fun7(1, c: true);
  fun7(1, c: true, b: "hello"); // 옵셔널끼리 순서가 바뀌어도 무방
}

void fun8(int a, {String? b, bool c = false}){}
void fun9(int a, {String? b, bool c = false}){}
void fun10(int a, {String? b, bool c = false}){}

