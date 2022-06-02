//
//  ClimbStairs.cpp
//  KataTest
//
//  Created by birneysky on 2020/8/16.
//

#include "ClimbStairs.hpp"
#include <vector>

/// 最容易想到的解法
int climbStairs(int n) {
    if (n == 0) {
        return 1;
    }
    
    if (n == 1) {
        return 1;
    }
    
    return climbStairs( n -1 ) + climbStairs(n-2);
}

/// 记忆化搜索
int Solution::caculateWays(int n) {
    if (n == 0) {
        return 1;
    }
    
    if (n == 1) {
        return 1;
    }
    
    if (meno[n] == 0) {
        meno[n] = caculateWays(n-1)+caculateWays(n-2);
    }
    
    return meno[n];
}


int Solution::climbStairs2(int n) {
    meno = std::vector<int>(n+1, 0);
    int result = caculateWays(n);
    return result;
}
/// 动态规划解法
/// f(n) = f(n-1) + f(n-2)
int climbStairs3(int n) {
    std::vector<int> meno(n+1, 0);
    meno[0] = 1;
    meno[1] = 1;
    
    for (int i = 2; i <= n; i++) {
        meno[i] = meno[i-1] + meno[i-2];
    }
    return meno[n];
}
