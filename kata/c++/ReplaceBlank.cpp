#include "ReplaceBlank.hpp"

void ReplaceBlank(char string[], int length) {
    int originalLenth = 0;
    int blankCount = 0;
    while (string[originalLenth] != '\0') {
        if (string[originalLenth] == ' ') {
            blankCount ++;
        }
        originalLenth ++;
    }
    
    int newLength = originalLenth + blankCount * 2;
    int indexOfNew = newLength;
    int indexOfOriginal = originalLenth;
    while (indexOfOriginal < indexOfNew && indexOfOriginal >= 0) {
        if (string[indexOfOriginal] == ' ') {
            string[indexOfNew --] = '0';
            string[indexOfNew --] = '2';
            string[indexOfNew --] = '%';
        } else {
            string[indexOfNew] = string[indexOfOriginal];
            indexOfNew --;
        }
        indexOfOriginal --;
    }
    
}
