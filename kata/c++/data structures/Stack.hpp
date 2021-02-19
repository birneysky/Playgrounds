//
//  Stack.hpp
//  KataTest
//
//  Created by birneysky on 2020/9/6.
//

#ifndef Stack_hpp
#define Stack_hpp

#include <memory>

namespace Kata {

/// LIFO
class Stack {
private:
    int* data;
    int count;
        
public:
    Stack(int capacity) {
        data = new int[capacity];
        memset(data, 0, sizeof(int) * capacity);
        count = 0;
    }
    
    bool isEmpty() {
        return count == 0;
    }
    
    int size() {
        return count;
    }
    
    void push(int val) {
        data[count++] = val;
    }
    
    int pop() {
        return data[--count];
    }
    
};

}

#endif /* Stack_hpp */
