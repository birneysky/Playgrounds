#include<stack>
#include<cassert>

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


int main(int argc, char* argv[]) {
	MinStack ms1;
	ms1.push(-2);
	ms1.push(0);
	ms1.push(-3);
	assert(ms1.getMin()==-3);
	return 0;
}

