COMMON_FLAGS=/nologo  /MD /W3 /GX  
CFLAGS_REL= $(COMMON_FLAGS)  /ox /GA /G6  /GF /Fdpdb.pdb -c	 
CC=cl.exe
OBJS_RELEASE= tp2.o
HEADER = vecteur.h exceptions.h

LIBS=  

tp2.exe: $(OBJS_RELEASE)  makefile
	link  -subsystem:console -out:tp2.exe $(OBJS_RELEASE)  $(LIBS)  /OPT:NOWIN98 /INCREMENTAL:NO /nologo /machine:I386


tp2.o:  tp2.cpp $(HEADER)
	$(CC)  $(CFLAGS_REL) tp2.cpp -Fotp2.o


