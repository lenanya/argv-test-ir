all: argv argv_unedited.ll

argv: argv.ll
	clang -mllvm -opaque-pointers argv.ll -o argv

argv_unedited.ll: argv.c
	clang argv.c -S -emit-llvm -o argv_unedited.ll
