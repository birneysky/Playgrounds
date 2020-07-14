//
//  ConstructTree.hpp
//  KataTest
//
//  Created by birneysky on 2020/7/15.
//

#ifndef ConstructTree_hpp
#define ConstructTree_hpp

#include "TreeNode.hpp"

/// 输入某二叉树的前序遍历和后序遍历的结果，请重建该二叉树
/// 假设输入的前序遍历和中序遍历结果都不包含重复数字。
/// 例如 输入前序遍历序列 {1, 2, 4, 7, 3, 5, 6, 8} 和中序遍历序列 {4, 7, 2, 1, 5, 3, 8, 6}, 则重建如下二叉树，返回根节点
///                1
///              /         \
///            2               3
///           /               /       \
///          4              5           6
///            \                     /
///            7                   8
/// @param preorder 前序遍历序列
/// @param inorder 中序遍历序列
/// @param length 序列长度
TreeNode* Construct(int* preorder, int* inorder, int length);


#endif /* ConstructTree_hpp */
