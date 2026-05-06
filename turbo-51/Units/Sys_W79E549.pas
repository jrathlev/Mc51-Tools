// W79E549 processor definition file
// =================================
// Winbond W79E549, W79L549, W79E649A, W79L649A


unit Sys_W79E549;

interface

var
  CKCON     : byte absolute $8E;
  P4CONA    : byte absolute $92;
  P4CONB    : byte absolute $93;
  P40AL     : byte absolute $94;
  P40AH     : byte absolute $95;
  P41AL     : byte absolute $96;
  P41AH     : byte absolute $97;
  P42AL     : byte absolute $9A;
  P42AH     : byte absolute $9B;
  P43AL     : byte absolute $9C;
  P43AH     : byte absolute $9D;
  CHPCON    : byte absolute $9F;
  XRAMAH    : byte absolute $A1;
  P4CSIN    : byte absolute $A2;
  P4        : byte absolute $A5;
  SADDR     : byte absolute $A9;
  SFRAL     : byte absolute $AC;
  SFRAH     : byte absolute $AD;
  SFRFD     : byte absolute $AE;
  SFRCN     : byte absolute $AF;
  P5        : byte absolute $B1;
  P6        : byte absolute $B2;
  P7        : byte absolute $B3;
  SADEN     : byte absolute $B9;
  PWM5      : byte absolute $C3;
  PMR       : byte absolute $C4;
  STATUS    : byte absolute $C5;
  TA        : byte absolute $C7;
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  PWMCON2   : byte absolute $CE;
  PWM4      : byte absolute $CF;
  WDCON     : byte absolute $D8;
  PWMP      : byte absolute $D9;
  PWM0      : byte absolute $DA;
  PWM1      : byte absolute $DB;
  PWMCON1   : byte absolute $DC;
  PWM2      : byte absolute $DD;
  PWM3      : byte absolute $DE;
  EIE       : byte absolute $E8;
  EIP       : byte absolute $F8;

  T2        : boolean absolute $90;  // serves also as PWM 0 output
  T2EX      : boolean absolute $91;  // serves also as PWM 1 output
  FE        : boolean absolute $9F;
  ET2       : boolean absolute $AD;
  PT2       : boolean absolute $BD;
  CPRL2     : boolean absolute $C8;
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;
  F1        : boolean absolute $D1;
  RWT       : boolean absolute $D8;
  EWT       : boolean absolute $D9;
  WTRF      : boolean absolute $DA;
  WDIF      : boolean absolute $DB;
  POR       : boolean absolute $DE;
  EWDI      : boolean absolute $EC;
  PWDI      : boolean absolute $FC;


const
  TIMER2    = $2B;
  WATCHD    = $63;

implementation

end.
