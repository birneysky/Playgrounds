//
//  KataHelper.hpp
//  KataTest
//
//  Created by birneysky on 2020/8/18.
//

#ifndef KataHelper_hpp
#define KataHelper_hpp

#include <vector>
#include <iostream>
#include <sstream>


template<typename T>
std::ostream& operator<<(std::ostream& out,std::vector<T> vec) {
    std::stringstream stream;
    typename std::vector<T>::iterator begin = vec.begin();
    typename std::vector<T>::iterator end = vec.end();
    if (begin != end) {
        stream << "[" << *begin;
        begin ++;
    } else {
        stream << "[";
    }
    
    std::for_each(begin, end, [&stream](T& value) {
        stream << "," << value;
    });
    stream << "]";
    out << stream.str();
    return out;
}

#endif /* KataHelper_hpp */
