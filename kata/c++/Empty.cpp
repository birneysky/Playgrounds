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


int ChordCount(const int& keyCount) {
    int result = 0;
    /// 1 <= i < j < k <= keyCount
    for (int i = 1; i <= keyCount - 2; i++) {
        for (int j = 2; j <= keyCount - 1; j++) {
            for (int k = 3; k <= keyCount; k++) {
                if ((k - j == 3 && j - i == 4) ||
                    (k - j == 4 && j - i == 3)) {
                    result ++;
                }
            }
        }
    }
    return result;
}
