//
//  MinPathSum.cpp
//  KataTest
//
//  Created by birneysky on 2020/8/16.
//

#include "MinPathSum.hpp"
#include <iostream>

/// 这里会漏掉一些路径，所以出错了,
/// 这段代码的问题是，没有理解 minSum 方法的定义，
///  该方法表示的含义是从 [rowIndex,colinde] 开始一直到右下角[nRows, nCols]的最短路径
/// 所以  minSum(grid, rowIndex + 1, colIndex) + grid[rowIndex][colIndex];
///  这行代码已经是从[rowIndex+1,colinde]到[nRows, nCols]路径的最短长度了
int MinPathSum::minSum(const std::vector<std::vector<int> >& grid,
                       int rowIndex, int colIndex) {
    int nRows = (int)grid.size();
    int nCols = (int)grid[0].size();
    if (rowIndex == nRows - 1 || colIndex == nRows - 1) {
        return grid[rowIndex][colIndex];
    }

    int aVal = minSum(grid, rowIndex + 1, colIndex) + grid[rowIndex][colIndex];
    if (colIndex < nCols) {
        aVal += minSum(grid, nRows - 1, colIndex + 1);
    }
    int bVal = minSum(grid, rowIndex, colIndex + 1) + grid[rowIndex][colIndex];
    if (rowIndex < nRows) {
        bVal += minSum(grid, rowIndex + 1, nCols - 1);
    }
    return std::min(aVal, bVal);
    
}

/// 主要思路：由于每次移动只能向右或者向下移动，所以这里最开始被分成了 向右一条路径和向下一条路径，
/// 最后求出这 2  条路径长度的最小值就是这个问题的解
/// 如果 f(i,j) 表示 从 i，j 点开始到矩阵 m 右下角的最短长度，
/// 那么问题的解就是m[0][0] + f(1,0) 与 m[0][0] + f(0,1)) 的最小值
int MinPathSum::minSum2(const std::vector<std::vector<int> >& grid,
                       int rowIndex, int colIndex) {
    int nRows = (int)grid.size();
    int nCols = (int)grid[0].size();
    if (rowIndex == nRows - 1 && colIndex == nCols - 1) {
        return grid[rowIndex][colIndex];
    }
    
    int aVal = 0;
    int bVal = 0;
    
    if (rowIndex + 1 < nRows && colIndex + 1 < nCols) {
        aVal = minSum2(grid, rowIndex + 1, colIndex) + grid[rowIndex][colIndex];
        bVal = minSum2(grid, rowIndex, colIndex + 1) + grid[rowIndex][colIndex];
    } else if (rowIndex + 1 >= nRows) {
        aVal = minSum2(grid, rowIndex, colIndex + 1) + grid[rowIndex][colIndex];
        return aVal;
    } else {
        bVal = minSum2(grid, rowIndex + 1, colIndex ) + grid[rowIndex][colIndex];
        return bVal;
    }

    return std::min(aVal, bVal);
}

int MinPathSum::minSum3(const std::vector < std::vector < int >>& grid, int rowIndex, int colIndex) {
    int nRows = (int)grid.size();
    int nCols = (int)grid[0].size();
    if (rowIndex == nRows - 1 && colIndex == nCols - 1) {
        return grid[rowIndex][colIndex];
    }
    
    int aVal = 0;
    int bVal = 0;
    if (memo[rowIndex][colIndex] != -1) {
        return memo[rowIndex][colIndex];
    }
    if (rowIndex + 1 < nRows && colIndex + 1 < nCols) {
        aVal = minSum3(grid, rowIndex + 1, colIndex) + grid[rowIndex][colIndex];
        bVal = minSum3(grid, rowIndex, colIndex + 1) + grid[rowIndex][colIndex];
    } else if (rowIndex + 1 >= nRows) {
        aVal = minSum3(grid, rowIndex, colIndex + 1) + grid[rowIndex][colIndex];
        return aVal;
    } else {
        bVal = minSum3(grid, rowIndex + 1, colIndex ) + grid[rowIndex][colIndex];
        return bVal;
    }
    memo[rowIndex][colIndex] = std::min(aVal, bVal);
    return memo[rowIndex][colIndex];
}

int MinPathSum::minPathSum(std::vector<std::vector<int>>& grid) {
    return minSum(grid, 0, 0);
}

int MinPathSum::minPathSum2(std::vector < std::vector < int >>& grid) {
    return minSum2(grid, 0, 0);
}


int MinPathSum::minPathSum3(std::vector < std::vector < int >>& grid) {
    memo = std::vector<std::vector<int>>(grid.size(), std::vector<int>(grid[0].size(), -1));
    return minSum3(grid, 0, 0);
}
