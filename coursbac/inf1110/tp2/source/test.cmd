echo off
rem $Id: test.cmd,v 1.1 2003/07/15 15:05:27 yann Exp $
date /t
time /t
echo ==========================================================================
echo Verification des cas normaux
echo test1
tp2.exe < test11.txt
echo ==========================================================================
echo Verification des cas normaux
echo test2
tp2.exe < test12.txt
echo ==========================================================================
echo verification des limites
echo test1
tp2.exe < test21.txt
echo ==========================================================================
echo verification des cas hors bornes
echo test1
tp2.exe < test31.txt
echo ==========================================================================
echo verification des cas hors bornes
echo test2
tp2.exe < test32.txt
echo ==========================================================================
echo verification des cas hors bornes
echo test3
tp2.exe < test33.txt
echo ==========================================================================
echo verification des cas hors bornes
echo test4
tp2.exe < test34.txt
date  /t
time /t
