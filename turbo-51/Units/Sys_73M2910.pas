// 73M2910/2910A processor definition file
// =======================================


unit Sys_73M2910;

interface

var
  USR1      : byte absolute $90;
  DIR1      : byte absolute $91;
  IDIR      : byte absolute $92;
  HDLC0     : byte absolute $C0;
  HDLC1     : byte absolute $C1;
  TXC       : byte absolute $C2;
  HSTAT     : byte absolute $C3;
  HIE       : byte absolute $C4;
  HINT      : byte absolute $C5;
  HRXD      : byte absolute $C6;
  HTXD      : byte absolute $C7;
  T2CON     : byte absolute $C8;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  USR2      : byte absolute $D8;
  DIR2      : byte absolute $D9;
  CLKCTRL   : byte absolute $DA;









  T2EX      : boolean absolute $92;
  T2        : boolean absolute $93;
  ET2       : boolean absolute $AD;
  EX2       : boolean absolute $AE;
  PT2       : boolean absolute $BD;
  PX2       : boolean absolute $BE;
  PHDLC     : boolean absolute $BF;
  PTXCTRL0  : boolean absolute $C0;
  PTXCTRL1  : boolean absolute $C1;
  RXDCTRL0  : boolean absolute $C2;
  RXDCTRL1  : boolean absolute $C3;
  PRXD      : boolean absolute $C4;
  WPTXD     : boolean absolute $C6;
  WRXD      : boolean absolute $C7;
  CPRL2     : boolean absolute $C8;
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;


const
  TIMER2    = $2B;
  EXTI2     = $33;
  HDLC      = $3B;

implementation

end.
