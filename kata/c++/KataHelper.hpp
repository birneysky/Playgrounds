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
#include <list>

template<typename T>
std::ostream& operator<<(std::ostream& out,std::vector<T>& vec) {
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

template<typename T>
std::ostream& operator<<(std::ostream& out, std::list<T>& list) {
    std::stringstream stream;
    if (list.size() <= 0) {
        stream << "list is empty";
        out << stream.str();
        return out;
    }
    for (auto it = list.begin(); it != list.end(); it++ ) {
        stream << *it << "-->";
    }
    stream << "nullptr";
    out << stream.str();
    return out;
}

template<typename T>
bool operator==(const std::vector<T>& t1, const std::vector<T> t2) {
    if(t1.size() != t2.size()) {
        return false;
    }
    
    for (int i = 0; i < t1.size(); i ++) {
        if( t1[i] != t2[i]) {
            return false;
        }
    }
    return true;
}

#endif /* KataHelper_hpp */
