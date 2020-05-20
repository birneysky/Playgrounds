#include<iostream>

void Reverse(char* pBegin, char* pEnd) {
	if (!pBegin || !pEnd) {
		return;
	}
	while (pBegin < pEnd) {
		char temp = *pBegin;
		*pBegin = *pEnd;
		*pEnd = temp;
		pBegin ++;
		pEnd --;
	}
}

char* ReverseSentence(char* pData) {
	if (!pData) {
		return nullptr;
	}

	char* pBegin = pData;
	char* pEnd = pBegin;
	while (pBegin < pEnd) {
		char temp = *pBegin;
		*pBegin = *pEnd;
		*pEnd = temp;
		pBegin ++;
		pEnd --;
	}
	Reverse(pBegin, ++pEnd);

	pBegin = pEnd = pData;
	while (pBegin < pEnd) {
		if (*pBegin == ' ' && *pEnd == ' ') {
			pBegin ++;
			pEnd ++;
		} else if(*pBegin != ' ' && *pEnd == ' ') {
			Reverse(pBegin, --pEnd);
			pBegin = ++ pEnd;
		} else {
			pEnd ++;
		}
	}

	return pData;
}


int main(int argc, char* argv[]) {
//	ReverseSentence("abc");
	char pBegin[] = "are you ok";
	ReverseSentence(pBegin);
	std::cout << pBegin;
}
