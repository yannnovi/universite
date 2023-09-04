CFLAGS_REL= -c
CC=g++


LIBS=  -lc

tp2: tp2.o test.o makefile
	g++   -o tp2 tp2.o test.o $(LIBS) 
        

tp2.o: tp2.cpp
	$(CC)  $(CFLAGS_REL) tp2.cpp  -o tp2.o
	
test.o: test.cpp
	$(CC)  $(CFLAGS_REL) test.cpp  -o test.o

