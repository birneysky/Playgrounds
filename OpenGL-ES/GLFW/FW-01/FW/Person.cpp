//
//  Person.cpp
//  FW
//
//  Created by Bruce on 2024/1/2.
//

#include "Person.hpp"
#include <stdio.h>
#include <string>


Person::Person(std::string name, int age) {
    this->name = name;
    this->age = age;
}

std::string Person::getName() {
    return name;
}

int Person::getAge() {
    return age;
}
