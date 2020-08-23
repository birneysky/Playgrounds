//
//  WaysToChange.cpp
//  KataTest
//
//  Created by birney on 2020/8/18.
//

#include "WaysToChange.hpp"
#include "KataHelper.hpp"

#include <iostream>

/// 该方法可以求解所有硬币的分解的组合，但是其中有重复，会导致一种组合计算了多次
void WaysToChange::showWays(int x, int deep) {
    if (x == 0) {
        std::cout << oneResultSet << std::endl;
        return;
    }
    
    for (int i = 0; i < coins.size();  ++ i) {
        if (x >= coins[i]) {
            oneResultSet.push_back(coins[i]);
            showWays(x - coins[i], deep + 1);
            oneResultSet.erase(oneResultSet.begin() + deep, oneResultSet.end());
        }
    }
}


int WaysToChange::ways1(int x) {
    if (x < 0) {
        return 0;
    } else if (x >=0 && x < 10) {
        return 2;
    } else if (x >= 10 && x < 15) {
        return 4;
    }
    
    int result = 0;
    for (int i = 0; i < coins.size();  ++ i) {
        if (x >= coins[i]) {
            std::cout << x << ":" << coins[i]  << " ";
        }
        result += ways1(x - coins[i]);
        //std::cout << "ways:" << result << std::endl;
    }
    return result;
}

void WaysToChange::showWaysToChange(int n) {
    showWays(n, 0);
}

int WaysToChange::waysToChange1(int n) {
    return ways1(n);
}
