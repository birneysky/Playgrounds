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
	while (*pEnd != '\0') {
		pEnd ++;
	}
	Reverse(pBegin, --pEnd);

	pBegin = pEnd = pData;
	while (*pBegin != '\0') {
		if (*pBegin == ' ') {
			pBegin ++;
			pEnd ++;
		} else if(*pEnd == ' ' || *pEnd == '\0') {
			Reverse(pBegin, --pEnd);
			pBegin = ++ pEnd;
		} else {
			pEnd ++;
		}
	}

	return pData;
}


