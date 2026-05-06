// T83C5101 processor definition file
// ==================================
// Atmel T83C5101, T87C5101, T83C5102


unit Sys_83C5101;

interface

var
  AUXR      : byte absolute $8E;  // dummy
  CKCON     : byte absolute $8F;
  AUXR1     : byte absolute $A2;
  SADDR     : byte absolute $A9;
  IPH       : byte absolute $B7;
  SADEN     : byte absolute $B9;
  P4        : byte absolute $C0;
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;


  T2        : boolean absolute $90;  // P1
  T2EX      : boolean absolute $91;

  FE        : boolean absolute $9F;

  ET2       : boolean absolute $AD;


  PT2       : boolean absolute $BD;

  PROG      : boolean absolute $C0;  // P4
  TEST      : boolean absolute $C1;

  CPRL2     : boolean absolute $C8;  // T2CON
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;



const
  TIMER2    = $2B;

implementation

end.
