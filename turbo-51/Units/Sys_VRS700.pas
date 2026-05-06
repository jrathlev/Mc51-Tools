// VRS700 processor definition file
// ================================


unit Sys_VRS700;

interface

var
  RCON      : byte absolute $85;
  DBANK     : byte absolute $86;
  WDTKEY    : byte absolute $97;
  SPWME     : byte absolute $9B;
  WDTC      : byte absolute $9F;
  SPWMD0    : byte absolute $B3;
  SPWMD1    : byte absolute $B4;
  SPWMD2    : byte absolute $B5;
  SPWMD3    : byte absolute $B6;
  SPWMD4    : byte absolute $BB;
  SPWMD5    : byte absolute $BC;
  SPWMD6    : byte absolute $BD;
  SPWMD7    : byte absolute $BE;
  SCONF     : byte absolute $BF;
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  SPWMC0    : byte absolute $D3;
  SPWMC1    : byte absolute $D4;
  SPWMC2    : byte absolute $D5;
  SPWMC3    : byte absolute $D6;
  P4        : byte absolute $D8;
  SPWMC4    : byte absolute $DB;
  SPWMC5    : byte absolute $DC;
  SPWMC6    : byte absolute $DD;
  SPWMC7    : byte absolute $DE;

  T2        : boolean absolute $90;
  T2EX      : boolean absolute $91;
  SPWM0     : boolean absolute $90;
  SPWM1     : boolean absolute $91;
  SPWM2     : boolean absolute $92;
  SPWM3     : boolean absolute $93;
  SPWM4     : boolean absolute $94;
  SPWM5     : boolean absolute $95;
  SPWM6     : boolean absolute $96;
  SPWM7     : boolean absolute $97;
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


const
  TIMER2    = $2B;

implementation

end.
