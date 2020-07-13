//
//  FindMatrix.hpp
//  kata
//
//  Created by birneysky on 2020/7/2.
//

#ifndef FindMatrix_h
#define FindMatrix_h

/// 在一个二维数组中，每一行都按照从左到右的顺序排序，
/// 每一个列都按照从上到下递增的顺序排序
/// 请完成一个函数，输入这样一个二维数组和一个整数
/// 判断数组中是否含有该整数。
///
///  1  2  8  9
///  2  4  9  12
///  4  7  10 13
///  6  8  11 15

bool Find(int* matrix, int rows, int columns, int number);

#endif /* FindMatrix_h */
