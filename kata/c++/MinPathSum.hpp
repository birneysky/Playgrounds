//
//  MinPathSum.hpp
//  KataTest
//
//  Created by birneysky on 2020/8/16.
//

#ifndef MinPathSum_hpp
#define MinPathSum_hpp

#include <vector>


/* 64
 给定一个包含非负整数的 m x n 网格，请找出一条从左上角到右下角的路径，使得路径上的数字总和为最小。

 说明：每次只能向下或者向右移动一步。

 示例:

 输入:
 [
   [1,3,1],
   [1,5,1],
   [4,2,1]
 ]
 输出: 7
 解释: 因为路径 1→3→1→1→1 的总和最小。

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/minimum-path-sum
 **/
class MinPathSum {
private:
    /// 返回从 grid[rowIndex][colIndex] 为起点的最小和
    int minSum(const std::vector < std::vector < int >>& grid, int rowIndex, int colIndex);
    
    int minSum2(const std::vector < std::vector < int >>& grid, int rowIndex, int colIndex);
    
    /// 记录从位置 i,j 开始到矩阵右下角的最短路径和
    std::vector<std::vector<int>> memo;
    int minSum3(const std::vector < std::vector < int >>& grid, int rowIndex, int colIndex);
public:
    int minPathSum(std::vector < std::vector < int >>& grid);
    int minPathSum2(std::vector < std::vector < int >>& grid);
    int minPathSum3(std::vector < std::vector < int >>& grid);
};
#endif /* MinPathSum_hpp */
