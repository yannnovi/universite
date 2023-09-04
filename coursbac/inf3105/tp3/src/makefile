COMMON_FLAGS=/nologo  /MD /W3 /GX /DMSVC
CFLAGS_REL= $(COMMON_FLAGS)  /ox /GA /G6  /GF /Fdpdb.pdb -c	 
CC=cl.exe
OBJS_RELEASE= tp3.o 
HEADER = personne.h etudiant.h exceptions.h dossieretudiant.h

LIBS=  

tp3.exe: $(OBJS_RELEASE)  makefile
	link  -subsystem:console -out:tp3.exe $(OBJS_RELEASE)  $(LIBS)  /OPT:NOWIN98 /INCREMENTAL:NO /nologo /machine:I386


tp3.o:  tp3.cpp $(HEADER)
	$(CC)  $(CFLAGS_REL) tp3.cpp -Fotp3.o


