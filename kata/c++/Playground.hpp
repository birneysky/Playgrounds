//
//  Playground.hpp
//  KataTest
//
//  Created by Bruce on 2022/6/2.
//

#ifndef Playground_hpp
#define Playground_hpp

#include <stdio.h>

/// 2020 高考真题，将钢琴上的 12 个键依次记为 a1, a2,  ... a12 ,假设 1 <= i < j < k <= 12, 若 k - j = 3 并且 j - i = 4, 则称 ai , aj, ak 为原位大三和旋
///  若 k - j = 4 并且  j - i = 3 ， 则称 ai, aj, ak 为原位小三和旋， 用这个 12 个琴键可以构成的原位大三和旋与原位小三和旋的个数之和是多少
/// @param keyCount 琴键个数
int ChordCount(const int& keyCount);

#endif /* Playground_hpp */
