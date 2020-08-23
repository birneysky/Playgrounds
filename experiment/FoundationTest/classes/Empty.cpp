#include<iostream>
#include "Empty.hpp"

Empty::Empty() {
    std::cout << "Empty" << std::endl;
}

Empty::~Empty() {
    std::cout << "~Empty" << std::endl;
}


VEmpty::VEmpty() {
    std::cout << "VEmpty" << std::endl;
}

VEmpty::~VEmpty() {
    std::cout << "~VEmpty" << std::endl;
}
