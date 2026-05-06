// 89E51A processor definition file
// ================================
// Megawin MPC89E51A, MPC89E52A, MPC89E53A,
// MPC89E54A, MPC89E58A, MPC89E515A,
// MPC89L51A, MPC89L52A, MPC89L53A,
// MPC89L54A, MPC89L58A, MPC89L515A


unit Sys_89E51A;

interface

var
  AUXR      : byte absolute $8E;
  AUXR1     : byte absolute $A2;
  SADDR     : byte absolute $A9;
  IPH       : byte absolute $B7;
  SADEN     : byte absolute $B9;
  XICON     : byte absolute $C0;
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
  P4        : byte absolute $E8;  // not present at the 40-pin DIP package


  T2        : boolean absolute $90;  // P1
  T2EX      : boolean absolute $91;

  FE        : boolean absolute $9F;

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


  INT3      : boolean absolute $EA;  // P4
  INT2      : boolean absolute $EB;  // (not present at the 40-pin DIP package)


const
  TIMER2    = $2B;
  EXTI2     = $33;
  EXTI3     = $3B;

implementation

end.
