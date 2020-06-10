package main

import "fmt"

type  TreeNode struct {
	value int
	left* TreeNode
	right* TreeNode
}

func createTreeNode(val int) *TreeNode {
	return &TreeNode{value: val, left:nil, right: nil}
}

func main() {
	var root TreeNode
	fmt.Println(root)
	root = TreeNode {value: 3}
	root.left = &TreeNode{}
	root.right = &TreeNode{value: 5, left: nil, right: nil}
	root.right.left = new(TreeNode)
	root.right.right = createTreeNode(3)
	fmt.Println(root)
}