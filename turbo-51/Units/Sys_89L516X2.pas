// 89L516X2 processor definition file
// ==================================
// Megawin MPC89L516X2


unit Sys_89L516X2;

interface

var
  AUXR      : byte absolute $8E;
  AUXR1     : byte absolute $A2;
  SADDR     : byte absolute $A9;
  IPH       : byte absolute $B7;
  SADEN     : byte absolute $B9;
  P4        : byte absolute $C0;  // not present at the 40-pin DIP package
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  WDTCR     : byte absolute $E1;
  IFD       : byte absolute $E2;
  IFADRH    : byte absolute $E3;
  IFADRL    : byte absolute $E4;
  IFMT      : byte absolute $E5;
  SCMD      : byte absolute $E6;
  ISPCR     : byte absolute $E7;


  T2        : boolean absolute $90;  // P1
  T2EX      : boolean absolute $91;

  FE        : boolean absolute $9F;

  ET2       : boolean absolute $AD;


  PT2       : boolean absolute $BD;

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
