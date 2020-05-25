#include<iostream>

class Empty {
public:
	Empty() {}
	~Empty() {}
};

class VEmpty {
public:
	VEmpty() {};
	virtual ~VEmpty() {}

};

int main(int arg, char* arv[]) {
	Empty t;
	/// c++ 空对象内存中占用一个字节
	std::cout << sizeof(class Empty) << std::endl;
	std::cout << sizeof(t) << std::endl;
	/// c++ 带有虚函数，类中添加虚函数表指针
	std::cout << sizeof(class VEmpty) << std::endl;
}
