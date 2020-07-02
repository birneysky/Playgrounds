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





