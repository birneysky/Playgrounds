//
//  MinStack.hpp
//  kata
//
//  Created by birneysky on 2020/7/2.
//

#ifndef MinStack_h
#define MinStack_h

#include<stack>

class MinStack {
private:
    std::stack<int> m_data;
    std::stack<int> m_min;
public:
    MinStack() {
    }

    void push(int x) {
        m_data.push(x);
        if(m_min.empty()) {
            m_min.push(x);
            return;
        }

        if(x < m_min.top()) {
            m_min.push(x);
        } else {
            m_min.push(m_min.top());
        }
    
    }

    void pop() {
        m_data.pop();
        m_min.pop();
    }

    int top() {
        return m_data.top();
    }

    int getMin() {
        return m_min.top();
    }
};

#endif /* MinStack_h */
