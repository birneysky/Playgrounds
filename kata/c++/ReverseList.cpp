#include"ListNode.hpp"

ListNode* ReverseList(ListNode* pHead) {
	ListNode* pre = nullptr;
	ListNode* cur = pHead;
	while(cur) {
		ListNode* next = cur->next;
		cur->next = pre;
		pre = cur;
		cur = next;
		if(next)
			next = next->next;
	}
	return pre;
}


int main(int argc, char* argv[]) {
	std::vector<int> nums1{1, 2, 4, 5, 6, 7, 9};
	ListNode* l1 = new ListNode(nums1);
	std::cout << l1 << std::endl;
	ListNode* l2 = ReverseList(l1);
	std::cout << l2;
}


