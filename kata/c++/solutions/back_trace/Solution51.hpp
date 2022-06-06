//
//  Solution50.hpp
//  kata
//
//  Created by Bruce on 2022/6/6.
//

#ifndef Solution51_hpp
#define Solution51_hpp

/*
 n 皇后问题 研究的是如何将 n 个皇后放置在 n×n 的棋盘上，并且使皇后彼此之间不能相互攻击。

 给你一个整数 n ，返回所有不同的 n 皇后问题 的解决方案。

 每一种解法包含一个不同的 n 皇后问题 的棋子放置方案，该方案中 'Q' 和 '.' 分别代表了皇后和空位。
 
 输入：n = 4
 输出：[
        [".Q..","...Q","Q...","..Q."],
        ["..Q.","Q...","...Q",".Q.."]
 ]
 
 
 输入：n = 1
 输出：[
        ["Q"]
 ]
 解释：如上图所示，4 皇后问题存在两个不同的解法。
 */

class Solution51 {
public:
    vector<vector<string>> solveNQueens(int n) {
#if 1
        return {};
#endif  
    }
};

#endif /* Solution51_hpp */
