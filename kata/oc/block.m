int main(int arg, char* argv[]) {
	int (^add)(void) = ^{
		return 3 + 2;
	};

	add();	
	return 0;

}
