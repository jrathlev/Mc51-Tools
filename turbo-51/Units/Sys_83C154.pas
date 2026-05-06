// 83C154 processor definition file
// ================================


unit Sys_83C154;

interface

var
  T2CON     : byte absolute $C8;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  IOCON     : byte absolute $F8;

  T2        : boolean absolute $90;
  T2EX      : boolean absolute $91;
  ET2       : boolean absolute $AD;
  PT2       : boolean absolute $BD;
  PCT       : boolean absolute $BF;
  CPRL2     : boolean absolute $C8;
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;
  F1        : boolean absolute $D1;
  ALF       : boolean absolute $F8;
  P1HZ      : boolean absolute $F9;
  P2HZ      : boolean absolute $FA;
  P3HZ      : boolean absolute $FB;
  IZC       : boolean absolute $FC;
  SERR      : boolean absolute $FD;
  T32       : boolean absolute $FE;
  WDT       : boolean absolute $FF;


const
  TIMER2    = $2B;

implementation

end.
