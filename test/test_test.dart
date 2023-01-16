createPersonBySex(String sex, String name,
    {int salary = 0, int beautyIndex = 0}) {
  return Person.fromSex(sex, name, salary: salary, beautyIndex: beautyIndex);
}

class Person {
  String name;
  factory Person.fromSex(String sex, String name,
      {int salary = 0, int beautyIndex = 0}) {
    if (sex == 'male') {
      return Male(name, salary);
    } else if (sex == 'female') {
      return Female(name, beautyIndex);
    }
    return Person(name);
  }

  Person(this.name);

  void printInfo() {
    print('name: $name');
  }
}

class Male extends Person {
  int salary;

  Male(super.name, this.salary);

  @override
  void printInfo() {
    super.printInfo();
    print('salary: $salary');
  }
}

class Female extends Person {
  int beautyIndex;

  Female(super.name, this.beautyIndex);

  @override
  void printInfo() {
    super.printInfo();
    print('beautyIndex: $beautyIndex');
  }
}

void main() {
  var person = createPersonBySex('female', 'Linda', beautyIndex: 5);
  print(person.runtimeType);
  print(person.beautyIndex);

  var person2 = Person.fromSex('female', 'Linda', beautyIndex: 5);
  print(person2.runtimeType);
  if (person2 is Female) {
    Female femalePerson = person2;
    print(femalePerson.beautyIndex);
  }
}
