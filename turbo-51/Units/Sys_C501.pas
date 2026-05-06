// C501 processor definition file
// ==============================
// Infineon C501-1R, C501-1E, C501-L, C501GV
// 
// Hynix GMS90C32, GMS90C52, GMS97C52,
// GMS90L32, GMS90L52, GMS97L52,
// GMS90C320, GMS90L320


unit Sys_C501;

interface

var
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
