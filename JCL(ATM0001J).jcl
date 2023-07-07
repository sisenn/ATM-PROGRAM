//ATM0001J   JOB 1,NOTIFY=&SYSUID
//***************************************************/
//* Copyright Contributors to the COBOL Programming Course
//* SPDX-License-Identifier: CC-BY-4.0
//***************************************************/
//COBRUN  EXEC IGYWCL
//COBOL.SYSIN  DD DSN=&SYSUID..CBL(ATM0001),DISP=SHR
//LKED.SYSLMOD DD DSN=&SYSUID..LOAD(ATM0001),DISP=SHR
//***************************************************/
// IF RC < 5 THEN
//***************************************************/
//STEP2 EXEC PGM=ATM0001
//STEPLIB   DD DSN=&SYSUID..LOAD,DISP=SHR
//ACCTINP   DD DSN=&SYSUID..VSAM.ATM1,DISP=SHR
//SYSOUT    DD SYSOUT=*,OUTLIM=15000
//CEEDUMP   DD DUMMY
//SYSUDUMP  DD DUMMY
//SYSIN     DD *
1000484096
2145
4
PHONE   
VODAFONE  
2365915387
2250
NO
/*
//***************************************************/
// ELSE
// ENDIF
