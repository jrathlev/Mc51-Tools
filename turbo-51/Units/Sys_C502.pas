// C502 processor definition file
// ==============================


unit Sys_C502;

interface

var
  WDTREL    : byte absolute $86;
  XPAGE     : byte absolute $91;
  DPSEL     : byte absolute $92;
  XCON      : byte absolute $94;
  SRELL     : byte absolute $AA;
  SYSCON    : byte absolute $B1;
  SRELH     : byte absolute $BA;
  WDCON     : byte absolute $C0;
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RC2L      : byte absolute $CA;
  RC2H      : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  BAUD      : byte absolute $D8;

  T2        : boolean absolute $90;
  T2EX      : boolean absolute $91;
  ET2       : boolean absolute $AD;
  PT2       : boolean absolute $BD;
  SWDT      : boolean absolute $C0;
  WDT       : boolean absolute $C1;
  WDTS      : boolean absolute $C2;
  OWDS      : boolean absolute $C3;
  CPRL2     : boolean absolute $C8;
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;
  F1        : boolean absolute $D1;
  BD        : boolean absolute $DF;


const
  TIMER2    = $2B;

implementation

end.
