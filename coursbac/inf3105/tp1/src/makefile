COMMON_FLAGS=/nologo  /MD /W3 /GX  
CFLAGS_REL= $(COMMON_FLAGS)  /ox /GA /G6  /GF /Fdpdb.pdb -c	 
CC=cl.exe
DEC_OBJS_RELEASE= decode.o
ENC_OBJS_RELEASE= encode.o

LIBS=  

decode.exe: $(DEC_OBJS_RELEASE) $(ENC_OBJS_RELEASE) makefile
	link  -subsystem:console -out:decode.exe $(DEC_OBJS_RELEASE)  $(LIBS)  /OPT:NOWIN98 /INCREMENTAL:NO /nologo /machine:I386
	link  -subsystem:console -out:encode.exe $(ENC_OBJS_RELEASE)  $(LIBS)  /OPT:NOWIN98 /INCREMENTAL:NO /nologo /machine:I386
        

decode.o:  decode.cpp $(HEADER)
	$(CC)  $(CFLAGS_REL) decode.cpp -Fodecode.o

encode.o:  encode.cpp $(HEADER)
	$(CC)  $(CFLAGS_REL) encode.cpp -Foencode.o


