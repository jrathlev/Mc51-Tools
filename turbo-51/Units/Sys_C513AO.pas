// C513AO processor definition file
// ================================


unit Sys_C513AO;

interface

var
  WDTREL    : byte absolute $86;
  PCON1     : byte absolute $88;  // mapped
  SYSCON    : byte absolute $B1;
  WDCON     : byte absolute $C0;
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RC2L      : byte absolute $CA;
  RC2H      : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  SSCCON    : byte absolute $E8;
  STB       : byte absolute $E9;
  SRB       : byte absolute $EA;
  SSCMOD    : byte absolute $EB;
  SCF       : byte absolute $F8;
  SCIEN     : byte absolute $F9;
  VR0       : byte absolute $FC;  // mapped
  VR1       : byte absolute $FD;  // mapped
  VR2       : byte absolute $FE;  // mapped

  EWPD      : boolean absolute $8F;  // mapped
  T2        : boolean absolute $90;
  T2EX      : boolean absolute $91;
  SCLK      : boolean absolute $92;
  SRI       : boolean absolute $93;
  STO       : boolean absolute $94;
  SLS       : boolean absolute $95;
  ET2       : boolean absolute $AD;
  ESSC      : boolean absolute $AE;
  PT2       : boolean absolute $BD;
  PSSC      : boolean absolute $BE;
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
  BRS0      : boolean absolute $E8;
  BRS1      : boolean absolute $E9;
  BRS2      : boolean absolute $EA;
  CPHA      : boolean absolute $EB;
  CPOL      : boolean absolute $EC;
  MSTR      : boolean absolute $ED;
  TEN       : boolean absolute $EE;
  SCEN      : boolean absolute $EF;
  TC        : boolean absolute $F8;
  WCOL      : boolean absolute $F9;


const
  TIMER2    = $2B;
  SSCINT    = $43;
  WAKEUP    = $7B;

implementation

end.
