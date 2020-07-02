#include "ListNode.hpp"

/// input: 1->2->4->null
///        1->3->4->null
/// output: 1->1->2->3->4->null
ListNode* MergeTwoLists(ListNode* l1, ListNode* l2) {
    ListNode* result = nullptr;
    if (l1 == nullptr) {
        return l2;
    }

    if (l2 == nullptr) {
        return l1;
    }

    if (l1->val < l2->val) {
        result = l1;
        result->next = MergeTwoLists(l1->next, l2);
    } else {
        result = l2;
        result->next = MergeTwoLists(l1, l2->next);
    }
    return result;
}


