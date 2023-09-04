CFLAGS_REL=  /nologo  /MD /W3 /GX  /ox /GA /G6  /GF  -c	 
CC=cl.exe
OBJS_RELEASE= tp1.obj   
HEADER= 

LIBS=  kernel32.lib odbccp32.lib comctl32.lib rpcrt4.lib 

tp1.exe: $(OBJS_RELEASE) makefile 
	link  /nologo /machine:I386 /MAP /subsystem:console  -out:tp1.exe $(OBJS_RELEASE)  $(LIBS) /OPT:NOWIN98 /INCREMENTAL:NO 

tp1.obj:  tp1.cpp $(HEADER)
	$(CC)  $(CFLAGS_REL) tp1.cpp 

