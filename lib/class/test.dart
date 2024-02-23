// 객체 생성 시 new 연산자를 이용해도 되고 생략해도 됨

// 클래스에 선언한 변수나 함수를 멤버라고 하고
// 멤버에는 객체 멤버와 클래스 멤버(혹은 정적 멤버)가 있다.
// 정적 멤버는 static 예약어로 선언한다.

// 생성자와 멤버 초기화
// 모든 클래스는 생성자를 가지며 개발자가 만들지 않더라도 컴파일러가 자동으로 클래스와 같은 이름의 기본 생성자를 만들어준다.
class User{
  // User(){}
}
// 멤버 초기화
class User2{
  late String name;

  User2(String name){
    this.name = name;
  }
}

// 초기화 목록
// 생성자 선언 시 초기화 목록 initializer list을 사용할 수도 있다.
class User3{
  String name;

  User3(String name) : this.name = name {}
}

// 초기화 목록은 단순히 파라미터를 멤버에 대입하는 용도보다는
// 리스트에서 요소를 가져온다던가 함수를 사용해 멤버를 초기화할 때 더 자주 사용한다.
// 다른 생성자를 This(), super() 등으로 호출하는 구문을 작성하기도 한다.
class User4{
  late String name;
  late int age;

  User4(List<String> names, List<int> ages)
      : this.name = names[0],
        this.age = ages[0] { }
}

class User5{
  late String name;

  // 생성자의 초기화목록이 실행되는 시점은 객체 생성 이전이므로 클래스 함수(static 함수)만 호출할 수 있다.
  User5(String name, int age)
      : this.name = fun(name){ }

  static String fun(String name){
    return name.toUpperCase();
  }
}

// 명명된 생성자
//
// 명명된 생성자가 가장 중요하고 자주 사용된다.
// 다른 언어에서는 생성자 오버로딩을 지원하지만 다트에서는 이 방식을 사용한다. 생성자 오버로딩 하면 에러
class User6{
  late String name;
  late int age;

  User6(String name, int age)
      : this.name = name,
        this.age = age { }
  // 생성자 오버로딩 하면 에러
  // User6(){}
  User6.first(){}
  User6.second(){}

  User6.fourth(String name){
    // this(name, 0); // 생성자 본문에서 this()로 다른 생성자를 호출할 수 없다.
    User6(name, 0); // 클래스 이름 붙은 생성자는 되는데? 이건 다른 생성자로 redirect하는 게 아니라 객체 생성인 듯
  }

  User6.fifth(String name) : this(name, 0); // this()를 쓰려면 초기화 목록에 써야 한다.
  User6.fifth2(String name) : this.first(); // 명명된 생성자도 this로 사용 가능
  // User6.sixth(String name) : this(name, 0){} // this()를 사용하면 바디(중괄호 영역)는 사용 불가
  // User6.seventh(String name) : this(name, 0), this.age = 0; // this()와 다른 초기화목록을 같이 사용할 수 없다.
  

}

// 팩토리 생성자 factory constructor
//
// 클래스 외부에서 생성자처럼 이용되지만 실제로는 클래스 타입의 객체를 반환하는 함수. 
// 팩토리 생성자는 생성자 호출만으로 객체가 생성되지 않고, 적절한 객체를 반환해줘야 한다.
// 싱글톤 패턴, 캐시 알고리즘, 상속 관계에 따른 다형성 구현에 유용
// 팩토리 생성자에서 사용할 별도의 생성자를 잊지 말고 같이 써주자.
// 반환 타입을 명시할 수 없고 클래스 타입으로 고정
class First{
  // factory 예약어를 붙이고 객체를 반환하지 않으면 오류
  // factory First(){}

  // 클래스와 다른 타입을 반환해도 오류
  // factory First(){
  // return null;
  // }
}

// 올바른 예
class Second{
  // private 생성자
  Second._instance();
  
  factory Second(){
    return Second._instance();
  }
}
main1(){
  var sec = Second();
}

// 캐시 알고리즘
// 객체를 생성할 때 식별자에 해당하는 객체가 없으면 새로 만들고 있으면 그 객체를 반환한다.
class Client{
  late String id;
  static Map<String, Client> _cache = <String, Client>{};
  
  Client._instance(this.id);
  
  factory Client(String id){
    if(_cache[id] == null){
      _cache[id] = Client._instance(id);
    }
    return _cache[id]!;
  }
}
main2(){
  Client client = Client("123");
  Client client2 = Client("123");
  print('client == client2 : ${client == client2}');

  Client._cache; // 근데 얘는 접근이 안 돼야 하는 거 아닌가? static이라 어쩔 수 없나?
  Client._cache["123"]; // 흠.. getter, setter를 프라이빗으로 만들어야 하나?
}


// 상수 생성자 constant constructor
//
// 모든 변수를 초기값으로만 사용하도록 강제하는 방법
// 상수 생성자는 const 예약어로 선언하며 본문(중괄호 영역)을 가질 수 없다.
// 상수 생성자가 선언된 클래스의 모든 멤버는 final로 선언돼야 한다.
class Third{
  final int a;

  const Third(this.a);
}

// 상수 객체 생성
// 같은 값으로 생성한 객체를 재활용할 목적으로 사용
// const 객체를 생성하려면 const 생성자가 필요하다.
class Fourth{}
main3(){
  var third = const Third(1);
  // var fourth = const Fourth(); // const 객체로 선언했지만 const 생성자가 없어 오류

  // const를 붙여 상수 객체로 선언하면서 생성자에 전달한 값(초깃값)이 똑같으면 객체를 다시 생성하지 않고 이전에 생성한 객체를 그대로 재사용한다.
  // 상수 생성자를 선언한 클래스더라도 일반 객체로 선언하면 서로 다른 객체가 생성된다.

  var obj1 = const Third(1);
  var obj2 = const Third(1); // obj2는 obj1과 같은 객체를 재사용
  var obj3 = Third(1); // obj2와 obj3는 다른 객체
  var obj4 = Third(1); // obj3과 obj4는 다른 객체
  var obj5 = const Third(2); // 새로운 객체 생성
}