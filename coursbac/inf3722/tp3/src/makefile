CFLAGS_REL= -c
CC=g++

OBJS= tp3.o test.o
LIBS=  -lc

tp3: $(OBJS) makefile
	g++   -o tp3 $(OBJS) $(LIBS) 
        

tp3.o: tp3.cpp
	$(CC)  $(CFLAGS_REL) tp3.cpp  -o tp3.o

test.o: test.cpp
	$(CC)  $(CFLAGS_REL) test.cpp  -o test.o
