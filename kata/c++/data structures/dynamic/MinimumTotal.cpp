//
//  MinimumTotal.cpp
//  KataTest
//
//  Created by birneysky on 2020/8/16.
//

#include "MinimumTotal.hpp"


/*
 std::vector<std::vector<int>> triangle {
     {-1},
     {2,3},
     {1,-1,-3}
 };
 这里特别容易犯错，认为只要每一步使得和最小，最终的结果就是最小的。
 如上面的三角数组，如果按照上述思路路径应该是 -1 --> 2 --> -1 这种情况下和为 0
 其实不然，正确的路径是 -1 --> 3 --> -3 这里和为 -1
 所以每一步使得和最小，并不能使得最终和最小，因为有可能某个路径上存在一个特别小的负值
 **/

/// 这个方案并不能求出最小值
int minimumTotal(std::vector<std::vector<int>>& triangle) {
    int res = triangle[0][0];
    int colIndex = 0;
    for (int row = 1; row < triangle.size(); row ++) {
        int lVal = triangle[row][colIndex];
        int rVal = triangle[row][colIndex+1];
        if (rVal < lVal) {
            colIndex = colIndex + 1;
        }
        res += std::min(lVal, rVal);
    }
    return res;
}



int MinimumTotal::minTotal(std::vector<std::vector<int>>& triangle, int rowIndex, int colIndex) {
    if (rowIndex == triangle.size() -1) {
        return triangle[rowIndex][colIndex];
    }
    
    int lVal = triangle[rowIndex][colIndex] + minTotal(triangle, rowIndex + 1, colIndex);
    int rVal = triangle[rowIndex][colIndex] + minTotal(triangle, rowIndex + 1, colIndex + 1);
    return std::min(lVal, rVal);
}


int MinimumTotal::minimumTotal(std::vector<std::vector<int>>& triangle) {
    return minTotal(triangle, 0, 0);
}



int MinimumTotal2::minTotal(std::vector<std::vector<int>>& triangle, int rowIndex, int colIndex) {
    if (rowIndex == triangle.size() -1) {
        return triangle[rowIndex][colIndex];
    }
    
    if (memo[rowIndex][colIndex] != -1) {
        return memo[rowIndex][colIndex];
    }
    
    int lVal = triangle[rowIndex][colIndex] + minTotal(triangle, rowIndex + 1, colIndex);
    int rVal = triangle[rowIndex][colIndex] + minTotal(triangle, rowIndex + 1, colIndex + 1);
    return memo[rowIndex][colIndex] = std::min(lVal, rVal);
}


int MinimumTotal2::minimumTotal(std::vector<std::vector<int>>& triangle) {
    memo = std::vector<std::vector<int>>(triangle.size(), std::vector<int>(triangle.size(), -1));
    return minTotal(triangle, 0, 0);
}

/// 动态规划法
/// 定义函数 f(i,j) 为从 0,0 位置一直到位置 i,j 的最短路径和
///  转移方程为 f(i,j) = triangle[i,j) + min(f(i-1,j), f(i-1,j+1)
/// 基于这样的定义，假设三角形高度为 h, 最后一行长度为 L 问题的解为 min( f(h-1,0),  f(h-0,1), ....... f(h-1,L-1))
int MinimumTotal2::minimumTotal2(std::vector<std::vector<int>>& triangle) {
    size_t nRow = triangle.size();
    size_t nCol = triangle[nRow - 1].size();
    std::vector<std::vector<int> > memo(nRow, std::vector<int>(nCol));

    memo[0][0] = triangle[0][0];
    for (int i = 1; i < triangle.size(); ++ i) {
        for (int j = 0; j < triangle[i].size(); j++) {
            if (j == 0) {
                memo[i][j] = triangle[i][j] + memo[i-1][j];
            } else if (i == j) {
                memo[i][j] = triangle[i][j] + memo[i-1][i-1];
            } else  { /// if (j - 1 > 0 && j < triangle[i].size())
                memo[i][j] = triangle[i][j] + std::min(memo[i-1][j-1], memo[i-1][j]);
            }
        }
    }
    return *std::min_element(memo[nRow - 1].begin(), memo[nRow - 1].end());
}
