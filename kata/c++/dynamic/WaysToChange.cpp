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
/// 这个方法是在答应出了所有排列情况，而题目要求是计算所有组合的个数
void WaysToChange::showWays(int x, int deep) {
    if (x == 0) {
        std::cout << oneResultSet << std::endl;
        return;
    }
    
    for (int i = 0; i < coins.size();  ++ i) {
        int diff = x - coins[i];
        if (diff >= 0 && !used[diff]) {
            oneResultSet.push_back(coins[i]);
            showWays(diff, deep + 1);
            oneResultSet.pop_back();/// 等价于 oneResultSet.erase(oneResultSet.begin() + deep, oneResultSet.end());
        }
    }
}

void WaysToChange::showWays2(int n, int val, int ci) {
    if (val == n) {
        std::cout << oneResultSet << std::endl;
        //oneResultSet.clear();
        return;
    }
    
    for (int j = ci; j < coins.size(); j ++) {
        if (coins[j] + val <= n) {
            oneResultSet.push_back(coins[j]);
            showWays2(n, val + coins[j], j);
            oneResultSet.pop_back();
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
    used = std::vector<int>(n, false);
    showWays(n, 0);
}

void WaysToChange::showWaysToChange2(int n) {
    showWays2(n, 0, 0);
}

int WaysToChange::waysToChange1(int n) {
    return ways1(n);
}
