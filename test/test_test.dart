class A {
  int a;
  int b;

  A(this.a, this.b);

  void printa() {
    print(this.a);
  }

  void printb() {
    print(this.b);
  }
}

class B extends A {
  B(this.a, this.b) : super(1, 2);
  int a;
  @override
  int b;
}

void main() {
  B b = B(3, 4);
  print(b.a);
  b.printa();
  print(b.b);
  b.printb();
}
