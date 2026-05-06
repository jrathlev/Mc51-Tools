// P-51 processor definition file
// ==============================
// Cybernetic Micro Systems P-51


unit Sys_P-51;

interface

var
  SQRT_LO   : byte absolute $84;
  SQRT_HI   : byte absolute $85;
  SQRT      : byte absolute $86;
  DP_SEL    : byte absolute $A2;
  T2CON     : byte absolute $C8;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
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



const
  TIMER2    = $2B;
  BREAK     = $E2F;

  // special RAM addresses




implementation

end.
