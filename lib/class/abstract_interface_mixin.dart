// 추상 클래스 abstract
// 추상 클래스는 추상 메서드를 가질 수도 있는 클래스. 반드시 추상 메서드만 있어야 하는 건 아니다. 본문을 가진 메서드도 생성 가능.
// 일반 클래스에서는 추상 메서드를 가지고 싶어도 선언할 수 없다.
// 추상 클래스는 객체를 생성할 수 없다.
// 참조형 변수의 타입으로는 사용 가능하다.
// 추상 클래스를 사용하기 위해서는 implements 키워드로 상속?후 추상 메서드 오버라이딩 필요

class Animal{
  void eat(){
    print('Animal eat...');
  }
  // void walk(); // 일반 클래스는 추상 메서드 보유 불가
}

abstract class Person{
  // 추상 클래스도 일반 함수 보유 가능
  void eat(){
    print('Person eat...');
  }
  void walk(); // 추상 함수는 추상 메서드 보유 가능
}

class Developer implements Person{
  // implements 할 때는 일반 메서드도 재정의 필수
  @override
  void eat() {
    // super.eat(); // 상속받은 게 아니기에 super가 없는 듯
    print('Develeper eat..');
  }

  // override 어노테이션은 생략도 가능은 하다. 하지만 있는 게 더 명확해보인다.
  void walk() {
    print('Developer walk..');
  }

  // Developer만의 기능
  void dev(){
    print('Developer dev..');
  }
}

abstract class Junior{
  void overwork();
}

abstract class Happy{
  void happy();
}

// 추상 클래스를 extends 하는 것도 가능한가?
// 가능하다. 추상메소드 walk()를 오버라이드 해줘야 하는 건 implements할 때와 동일.
// extends를 썼을 때는 일반메소드 eat()을 오버라이드할 필요 없다는 게 implements와의 차이점. 이미 super.eat()을 보유하고 있다.
class Student extends Person{
  @override
  void walk() {
    print('Student walk..');
  }

  // Student만의 기능
  void study(){
    print("Student study...");
  }
}

// 일반 클래스를 implements 하는 것도 가능한가?
// 가능하다. 단 implements 할 때는 일반 메소드도 모두 재정의가 필요하다는 것이 차이.
class AnimalImpl implements Animal{
  @override
  void eat() {
    // TODO: implement eat
  }
}

// 이중 상속은 불가
// class Child extends Person, Junior{
//   @override
//   void walk() {}
// }

// 다중 implements는 가능
class HappyJuniorDeveloper implements Person, Junior, Happy{
  @override
  void eat() { // from Person
    print("HappyJuniorDeveloper eat...");
  }

  @override
  void walk() { // from Person
    print("HappyJuniorDeveloper walk...");
  }

  @override
  void overwork() { // from Junior
    print("HappyJuniorDeveloper overwork...");
  }

  @override
  void happy() { // from Happy
    print("HappyJuniorDeveloper happy...");
  }
}

abstract interface class Man{
  int a = 10;
}

void main(){
  Animal animal = Animal();
  animal.eat();

  // Person person = Person(); // 추상 클래스는 객체 생성 불가. 객체 생성을 위해서는 구체화된 서브 타입이 필요.

  Developer developer = Developer();
  developer.eat();
  developer.walk();
  developer.dev();

  Student student = Student();
  student.eat(); // 상속받은 Person.eat()
  student.walk();
  student.study();

  HappyJuniorDeveloper happyJuniorDeveloper = HappyJuniorDeveloper();
  happyJuniorDeveloper.overwork();
  Person happyJuniorDeveloper2 = HappyJuniorDeveloper();
  happyJuniorDeveloper2.eat();
  // happyJuniorDeveloper2.overwork(); // Person에 정의돼있지 않은 기능은 사용 불가
}