//
//  Base.hpp
//  FoundationTest
//
//  Created by Bruce on 2026/4/17.
//

#ifndef Base_hpp
#define Base_hpp


#include <iostream>


class Base {
public:
    virtual void f() { std::cout << "base::f" << std::endl;}
    virtual void g() { std::cout << "base::g" << std::endl;}
    virtual void h() { std::cout << "base::h" << std::endl;}
};

class Derive: public Base {
public:
    virtual void f() { std::cout << "Derive::f" << std::endl;}
    virtual void g() { std::cout << "Derive::g" << std::endl;}
    virtual void h() { std::cout << "Derive::h" << std::endl;}
};

#endif /* Base_hpp */
