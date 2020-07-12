#include "PrintListReverseingly.hpp"
#include <iostream>
#include <stack>

void PrintListReverseingly(ListNode* pHead) {
    if (!pHead) {
        std::cout << "Null";
        return;
    }
    
    PrintListReverseingly(pHead->next);
    std::cout << "-->" << pHead->val;
}

/// 使用 栈来实现
void PrintListReverseingly2(ListNode* pHead) {
    std::stack<ListNode*> stack;
    ListNode* head = pHead;
    while (head) {
        stack.push(head);
        head = head->next;
    }
    
    std::cout << "NULL-->";
    while (!stack.empty()) {
        ListNode* node = stack.top();
        std::cout << node->val;
        stack.pop();
        if (node != pHead) {
            std::cout << "-->";
        } else {
            std::cout << std::endl;
        }
    }
    
}


void PrintList(ListNode* pHead) {
    if (!pHead) {
        std::cout << "Null" << std::endl;
        return;
    }
    
    std::cout << pHead->val << "-->";
    PrintList(pHead->next);
}
