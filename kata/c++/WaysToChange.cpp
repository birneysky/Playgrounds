//
//  WaysToChange.cpp
//  KataTest
//
//  Created by birney on 2020/8/18.
//

#include "WaysToChange.hpp"
#include <iostream>

int WaysToChange::ways(int x) {
    if (x < 0) {
        return 0;
    } else if (x == 0) {
        std::cout << std::endl;
        return 1;
    }
    
    int result = 0;
    for (int i = 0; i < coins.size();  ++ i) {
        if (x >= coins[i]) {
            std::cout << x << ":" << coins[i]  << " ";
        }
        result += ways(x - coins[i]);
        //std::cout << "ways:" << result << std::endl;
    }
    return result;
}


int WaysToChange::waysToChange(int n) {
    return ways(n);
}
