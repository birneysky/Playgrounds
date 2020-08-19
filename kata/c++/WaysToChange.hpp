//
//  WaysToChange.hpp
//  KataTest
//
//  Created by birney on 2020/8/18.
//

#ifndef WaysToChange_hpp
#define WaysToChange_hpp

#include <vector>
#include <string>
/// 硬币。给定数量不限的硬币，币值为25分、10分、5分和1分，编写代码计算n分有几种表示法。(结果可能会很大，你需要将结果模上1000000007)
/// 示例1:
/// 输入: n = 5
/// 输出：2
/// 解释: 有两种方式可以凑成总金额:
/// 5=5
/// 5=1+1+1+1+1
/// 示例2:

/// 输入: n = 10
/// 输出：4
/// 解释: 有四种方式可以凑成总金额:
/// 10=10
/// 10=5+5
/// 10=5+1+1+1+1+1
/// 10=1+1+1+1+1+1+1+1+1+1

/// 来源：力扣（LeetCode）
/// 链接：https://leetcode-cn.com/problems/coin-lcci

class WaysToChange {    
private:
    const std::vector<int> coins{1, 5, 10, 25};
    std::vector<int> oneResultSet;
    std::vector<int> used;
    /// 输出打印分解结果的所有排列
    void showWays(int n, int deep);
    
    
    /// 打印分解结果的所有组合
    /// @param n  硬币总数值
    void showWays2(int n, int val);
    /// 从 coins 中的第 0 索引位置开始，计算 n 有几种表示法
    int ways1(int n);
public:
    /// 输出打印分解结果的所有排列
    void showWaysToChange(int n);
    /// 打印分解结果的所有组合
    void showWaysToChange2(int n);
    int waysToChange1(int n);
};

/// 分析
/// 举一个简单的例子比如只有 1， 2， 5 分的三种硬币，那么 6 分钱最多有多少中表示方法
/// ```
///                                                                                                                                           6
///                                                                                        /                                                                                                                   |                                                                                                                 \
///                                                                                       5                                                                                                                    4                                                                                                                 1
///                                             /                                                                                             |                                    \                                     /                                           |                        \                                                                            /            |                  \
///                                            4                                                                                              3                                       0                                 3                                          2                       N/A                                                                      0            N/A               N/A
///                     /                                                   |                  \                                          /                                  |      \                                                    /                |                   \          /            |          \
///                   3                                                      2                 N/A                                   2                                   1       N/A                                            2                 1                 N/A    1             0        N/A
///          /                   |           \                          /                |        \                                /                 |                \
///        2                      1          N/A                   1                 0        N/A                         1               N/A              N/A
///    /        |          \        /    |     \                       /     |    \                                         /       |        \
///   1        0         N/A  0   N/A  N/A               0     N/A   N/A                                0      N/A       N/A
/// ```
/*                                                  6
                           5                        4                    1
           4               3       0   3            2       N          0 N N
   3       2   N    2      1   N    2  1   N     1  0   N
 2 1 N  1 0 N     1 0 N  0 N N    1 0 N  0 N N 0 N N
 **/
#endif /* WaysToChange_hpp */
