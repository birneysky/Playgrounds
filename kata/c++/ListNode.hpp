#include<iostream>
#include<sstream>
#include<vector>

class ListNode {

public:
	int val;
	ListNode* next;
public:
	ListNode(int x);
	ListNode();
	ListNode(const std::vector<int>& nums);

	friend std::ostream& operator <<(std::ostream& os, const ListNode* head);
};
		

