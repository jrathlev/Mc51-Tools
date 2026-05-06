// 90C54 processor definition file
// ===============================
// Hynix GMS90C54, GMS90L54, GMS97C54, GMS97L54,
// GMS90C56, GMS90L56, GMS97C56, GMS97L56,
// GMS90C58, GMS90L58, GMS97C58, GMS97L58, GMS99C58


unit Sys_90C54;

interface

var
  AUXR0     : byte absolute $8E;
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RC2L      : byte absolute $CA;
  RC2H      : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;


  T2        : boolean absolute $90;  // P1
  T2EX      : boolean absolute $91;


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

  F1        : boolean absolute $D1;


const
  TIMER2    = $2B;

implementation

end.
