//
//  MinimumTotal.hpp
//  KataTest
//
//  Created by birneysky on 2020/8/16.
//

#ifndef MinimumTotal_hpp
#define MinimumTotal_hpp

#include <vector>

/* 120
 给定一个三角形，找出自顶向下的最小路径和。每一步只能移动到下一行中相邻的结点上。

 相邻的结点 在这里指的是 下标 与 上一层结点下标 相同或者等于 上一层结点下标 + 1 的两个结点。

  

 例如，给定三角形：

 [
      [2],
     [3,4],
    [6,5,7],
   [4,1,8,3]
 ]
 自顶向下的最小路径和为 11（即，2 + 3 + 5 + 1 = 11）。

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/triangle
 **/
class MinimumTotal {
private:
    /// 选择 triangle[rowIndex][colIndex]  时，最小路径和是多少
    int minTotal(std::vector<std::vector<int>>& triangle, int rowIndex, int colIndex);
public:
    int minimumTotal(std::vector<std::vector<int>>& triangle);
};



class MinimumTotal2 {
private:
    std::vector<std::vector<int>> memo;
    /// 选择 triangle[rowIndex][colIndex]  时，最小路径和是多少
    int minTotal(std::vector<std::vector<int>>& triangle, int rowIndex, int colIndex);
public:
    int minimumTotal(std::vector<std::vector<int>>& triangle);
    
    int minimumTotal2(std::vector<std::vector<int>>& triangle);
};

#endif /* MinimumTotal_hpp */
