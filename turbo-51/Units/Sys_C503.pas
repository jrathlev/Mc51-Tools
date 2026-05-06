// C503 processor definition file
// ==============================


unit Sys_C503;

interface

var
  WDTREL    : byte absolute $86;
  WDCON     : byte absolute $C0;
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RC2L      : byte absolute $CA;
  RC2H      : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  ADCON0    : byte absolute $D8;
  ADDATH    : byte absolute $D9;
  ADDATL    : byte absolute $DA;
  ADCON1    : byte absolute $DC;

  T2        : boolean absolute $90;
  T2EX      : boolean absolute $91;
  AN2       : boolean absolute $92;
  AN3       : boolean absolute $93;
  AN4       : boolean absolute $94;
  AN5       : boolean absolute $95;
  AN6       : boolean absolute $96;
  AN7       : boolean absolute $97;
  ET2       : boolean absolute $AD;
  EADC      : boolean absolute $AE;
  PT2       : boolean absolute $BD;
  PADC      : boolean absolute $BE;
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
  MX0       : boolean absolute $D8;
  MX1       : boolean absolute $D9;
  MX2       : boolean absolute $DA;
  ADM       : boolean absolute $DB;
  BSY       : boolean absolute $DC;
  IADC      : boolean absolute $DD;


const
  TIMER2    = $2B;
  ADCONV    = $43;

implementation

end.
