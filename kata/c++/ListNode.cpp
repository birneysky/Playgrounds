#include"ListNode.hpp"

ListNode::ListNode():val(0), next(nullptr) {

}

ListNode::ListNode(int x):val(x), next(nullptr) {

}

ListNode::ListNode(const std::vector<int>& nums) {
	ListNode* pHead = this;
	for( int i = 0; i < nums.size(); ++ i) {
		pHead->val = nums[i];
		if (i != nums.size() -1) {
			pHead->next = new ListNode();
		} else {
			pHead->next = nullptr;
		}
		pHead = pHead->next;
	}
}


std::ostream& operator<<(std::ostream& os, const ListNode* pHead) {
	std::stringstream sstream;
	const ListNode* head = pHead;
	while( head != nullptr ) {
		sstream << head->val << "-->";
		head = head->next;
	}
	sstream << "nullptr" << std::endl;
	os << sstream.str();
	return os;
}
