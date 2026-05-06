// W79E201 processor definition file
// =================================


unit Sys_W79E201;

interface

var
  CKCON     : byte absolute $8E;
  P0R       : byte absolute $8F;
  CHPCON    : byte absolute $9F;
  P4        : byte absolute $A5;
  SADDR     : byte absolute $A9;
  SFRAL     : byte absolute $AC;
  SFRAH     : byte absolute $AD;
  SFRFD     : byte absolute $AE;
  SFRCN     : byte absolute $AF;
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
  ADCCON    : byte absolute $E1;
  ADCH      : byte absolute $E2;
  ADCCEN    : byte absolute $E4;
  EIE       : byte absolute $E8;
  EIP       : byte absolute $F8;

  T2        : boolean absolute $90;
  T2EX      : boolean absolute $91;
  FE        : boolean absolute $9F;
  ET2       : boolean absolute $AD;
  EADC      : boolean absolute $AE;
  PT2       : boolean absolute $BD;
  PADC      : boolean absolute $BE;
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
  ADCONV    = $6B;

implementation

end.
