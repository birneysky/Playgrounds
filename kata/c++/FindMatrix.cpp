#include "FindMatrix.hpp"

///  1  2  8  9
///  2  4  9  12
///  4  7  10 13
///  6  8  11 15

bool Find(int* matrix, int rows, int columns, int number) {
    if (!matrix) {
        return false;
    }
    int rowIndex = 0;
    int colIndex = columns - 1;
    
    while (rowIndex < rows && colIndex >= 0) {
        int target  = *(matrix + rowIndex * rows + colIndex);
        if (target == number) {
            return true;
        } else if (number < target) {
            colIndex --;
        } else {
            rowIndex ++;
        }
    }
	return false;
}

