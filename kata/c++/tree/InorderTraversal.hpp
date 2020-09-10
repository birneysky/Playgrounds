//
//  InorderTraversal.hpp
//  KataTest
//
//  Created by birney on 2020/9/10.
//

#ifndef InorderTraversal_hpp
#define InorderTraversal_hpp
#include "TreeNode.hpp"

/*
 给定一个二叉树，返回它的中序 遍历。

 示例:

 输入: [1,null,2,3]
    1
     \
      2
     /
    3

 输出: [1,3,2]
 进阶: 递归算法很简单，你可以通过迭代算法完成吗？

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/binary-tree-inorder-traversal
 **/

class InorderTraversal {
private:
    void inorderTraversal(TreeNode* root, std::vector<int>& result) {
        if (root == NULL) {
            return;
        }
        inorderTraversal(root->left, result);
        result.push_back(root->val);
        inorderTraversal(root->right, result);
    }
public:
    std::vector<int> inorderTraversal(TreeNode* root) {
        std::vector<int> result;
        inorderTraversal(root, result);
        return result;
    }
};

#endif /* InorderTraversal_hpp */
