//
//  MinimumTotal.cpp
//  KataTest
//
//  Created by birneysky on 2020/8/16.
//

#include "MinimumTotal.hpp"

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
