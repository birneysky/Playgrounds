#include<cstdio>
struct __block_impl {
	void* isa;
	int Flags;
	int reserved;
	void* FuncPtr;
};

struct __main_block_desc_0 {
	size_t reverved;
	size_t Block_size;
};

struct __main_block_impl_0 {
	struct __block_impl impl;
	struct __main_block_desc_0* Desc;
	__main_block_impl_0(void* fp, struct __main_block_desc_0* desc, int flags = 0) {
		impl.isa = nullptr;
		impl.Flags = flags;
		impl.FuncPtr = fp;
		Desc = desc;
	}
};

struct __main_block_desc_0 __main_block_desc_0_DATA = {0, sizeof(struct __main_block_impl_0)};

static int __main_block_func_0(struct __main_block_impl_0 * __cself) {
	return 3 + 2;
}

int main(int argc, char* argv[]) {
	__main_block_impl_0 impl_0((void*)__main_block_func_0, &__main_block_desc_0_DATA);
	int (*add)(void) = (int (*)())&impl_0;
	return 0;
}
