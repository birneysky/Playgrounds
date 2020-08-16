//
//  MinPathSum.cpp
//  KataTest
//
//  Created by birneysky on 2020/8/16.
//

#include "MinPathSum.hpp"

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

int MinPathSum::minPathSum(std::vector<std::vector<int>>& grid) {
    return minSum(grid, 0, 0);
}
