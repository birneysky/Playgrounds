//
//  Person.hpp
//  FW
//
//  Created by Bruce on 2024/1/2.
//

#ifndef Person_hpp
#define Person_hpp

#include <string>

struct Person {
private:
    std::string name;
    int age;
public:
    Person(std::string name, int age);
    std::string getName();
    int getAge();
};

#endif /* Person_hpp */
