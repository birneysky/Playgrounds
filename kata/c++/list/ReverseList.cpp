#include"ListNode.hpp"

ListNode* ReverseList(ListNode* pHead) {
    ListNode* pre = nullptr;
    ListNode* cur = pHead;
    while (cur != nullptr) {
        ListNode* next = cur->next;
        cur->next = pre;
        pre = cur;
        cur = next;
    }
    return pre;
}





