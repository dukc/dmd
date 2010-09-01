// PERMUTE_ARGS:

extern(C) int printf(const char*, ...);

/*******************************************/

interface IStream
{
    int read();
}

interface OStream
{
    int write();
}

class IO : IStream, OStream
{
    int read() { return 7; }
    int write() { return 267; }
}

void foo(IStream i, OStream o)
{
    printf("foo(i = %p, o = %p)\n", i, o);
    assert(i.read() == 7);
    assert(o.write() == 267);
}

void test1()
{
    IO io = new IO();
    printf("io = %p\n", io);
    foo(io, io);
    delete io;
}

/*******************************************/

interface I { }
class C : I
{
    ~this() { printf("~C()\n"); }
}

void test2()
{
    I i = new C();
    delete i;

  {
    scope I j = new C();
  }
}

/*******************************************/

interface I3 {
    void h();
}
interface K3 {
    void f();
}

interface J3 : I3, K3 {}

class A3 : J3 {
    void f(){ }
    void h(){ } 
}

void test3()
{
    auto a = new A3();
    J3 b = a;
    K3 c = a;
    assert(&b.f == &c.f); // Bugzilla 3706
}

/*******************************************/

int main()
{
    test1();
    test2();
    test3();

    printf("Success\n");
    return 0;
}
