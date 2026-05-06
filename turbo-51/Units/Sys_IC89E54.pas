// IC89E54 processor definition file
// =================================
// ICSI IC89E54, IC89E58, and IC89E64


unit Sys_IC89E54;

interface

var
  P40AL     : byte absolute $84;
  P40AH     : byte absolute $85;
  AUXR      : byte absolute $8E;
  P41AL     : byte absolute $94;
  P41AH     : byte absolute $95;
  P2EAL     : byte absolute $9E;
  P2EAH     : byte absolute $9F;
  P42AL     : byte absolute $AC;
  P42AH     : byte absolute $AD;
  P2ECON    : byte absolute $AE;
  P43AL     : byte absolute $B4;
  P43AH     : byte absolute $B5;
  XICON     : byte absolute $C0;
  P4CONA    : byte absolute $C2;
  P4CONB    : byte absolute $C3;
  T2CON     : byte absolute $C8;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  P4        : byte absolute $D8;  // not present at the 40-pin DIP package


  T2        : boolean absolute $90;  // P1
  T2EX      : boolean absolute $91;


  ET2       : boolean absolute $AD;


  PT2       : boolean absolute $BD;

  IT2       : boolean absolute $C0;  // XICON
  IE2       : boolean absolute $C1;
  EX2       : boolean absolute $C2;
  PX2       : boolean absolute $C3;
  IT3       : boolean absolute $C4;
  IE3       : boolean absolute $C5;
  EX3       : boolean absolute $C6;
  PX3       : boolean absolute $C7;

  CPRL2     : boolean absolute $C8;  // T2CON
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;


  INT3      : boolean absolute $DA;  // P4 (not present at the 40-pin DIP package)
  INT2      : boolean absolute $DB;


const
  TIMER2    = $2B;
  EXTI2     = $33;
  EXTI3     = $3B;

implementation

end.
