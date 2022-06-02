//
//  Empty.hpp
//  kata
//
//  Created by birneysky on 2020/7/2.
//

#ifndef Empty_h
#define Empty_h


class Empty {
public:
    Empty();
    ~Empty();
};

class VEmpty {
public:
    VEmpty();
    virtual ~VEmpty();

};

template<class T>
class TestObject {
private:
    T a;
public:
    TestObject() {}
    T getA() { return a; }
};

#endif /* Empty_h */
