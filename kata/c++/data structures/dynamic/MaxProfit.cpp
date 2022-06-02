//
//  MaxProfit.cpp
//  KataTest
//
//  Created by birneysky on 2020/8/15.
//

#include "MaxProfit.hpp"


/// 暴力解法
/// @param prices a
int maxProfit(std::vector<int>& prices) {
    int result = 0;
    for (int i = 0; i < prices.size(); i++) {
        for (int j = i + 1; j < prices.size(); j++) {
            int aProfit = prices[j] - prices[i];
            if (aProfit > result) {
                result = aProfit;
            }
        }
    }
    return result;
}


/// 动态规划解法
int maxProfit1(std::vector<int>& prices) {
    if (prices.size() < 2) {
        return 0;
    }
   int minPriceIndex = 0;
   int result = 0;
   for (int i = 1; i < prices.size(); i ++) {
       if (prices[i-1] < prices[minPriceIndex]) {
           minPriceIndex = i - 1;
       }
       int aProfit = prices[i] - prices[minPriceIndex];
       if (aProfit > result) {
           result = aProfit;
       }
   }
   return result;
}
