//
//  Solution79.hpp
//  kata
//
//  Created by Bruce on 2022/6/6.
//

#ifndef Solution79_hpp
#define Solution79_hpp

/**
 给定一个 m x n 二维字符网格 board 和一个字符串单词 word 。如果 word 存在于网格中，返回 true ；否则，返回 false 。

 单词必须按照字母顺序，通过相邻的单元格内的字母构成，其中“相邻”单元格是那些水平相邻或垂直相邻的单元格。同一个单元格内的字母不允许被重复使用。

 输入：board = [["A","B","C","E"],
               ["S","F","C","S"],
               ["A","D","E","E"]],
      word = "ABCCED"
 
 输出：true
 
 
 
 输入：board = [["A","B","C","E"],
               ["S","F","C","S"],
               ["A","D","E","E"]],
      word = "SEE"
 输出：true
 */

class Solution79 {
public:
    bool exist(vector<vector<char>>& board, string word) {
#if 1
        return true;
#endif
    }
};

#endif /* Solution79_hpp */
