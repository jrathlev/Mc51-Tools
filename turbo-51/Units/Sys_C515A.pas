// C515A processor definition file
// ===============================


unit Sys_C515A;

interface

var
  WDTREL    : byte absolute $86;
  PCON1     : byte absolute $88;
  XPAGE     : byte absolute $91;
  IEN0      : byte absolute $A8;
  IP0       : byte absolute $A9;
  SRELL     : byte absolute $AA;
  SYSCON    : byte absolute $B1;
  IEN1      : byte absolute $B8;
  IP1       : byte absolute $B9;
  SRELH     : byte absolute $BA;
  IRCON     : byte absolute $C0;
  CCEN      : byte absolute $C1;
  CCL1      : byte absolute $C2;
  CCH1      : byte absolute $C3;
  CCL2      : byte absolute $C4;
  CCH2      : byte absolute $C5;
  CCL3      : byte absolute $C6;
  CCH3      : byte absolute $C7;
  T2CON     : byte absolute $C8;
  CRCL      : byte absolute $CA;
  CRCH      : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  ADCON0    : byte absolute $D8;
  ADDATH    : byte absolute $D9;
  ADDATL    : byte absolute $DA;
  P6        : byte absolute $DB;
  ADCON1    : byte absolute $DC;
  P4        : byte absolute $E8;
  P5        : byte absolute $F8;

  EWPD      : boolean absolute $8F;
  INT3      : boolean absolute $90;
  CC0       : boolean absolute $90;
  INT4      : boolean absolute $91;
  CC1       : boolean absolute $91;
  INT5      : boolean absolute $92;
  CC2       : boolean absolute $92;
  INT6      : boolean absolute $93;
  CC3       : boolean absolute $93;
  INT2      : boolean absolute $94;
  T2EX      : boolean absolute $95;
  CLKOUT    : boolean absolute $96;
  T2        : boolean absolute $97;
  ET2       : boolean absolute $AD;
  WDT       : boolean absolute $AE;
  EAL       : boolean absolute $AF;
  EADC      : boolean absolute $B8;
  EX2       : boolean absolute $B9;
  EX3       : boolean absolute $BA;
  EX4       : boolean absolute $BB;
  EX5       : boolean absolute $BC;
  EX6       : boolean absolute $BD;
  SWDT      : boolean absolute $BE;
  EXEN2     : boolean absolute $BF;
  IADC      : boolean absolute $C0;
  IEX2      : boolean absolute $C1;
  IEX3      : boolean absolute $C2;
  IEX4      : boolean absolute $C3;
  IEX5      : boolean absolute $C4;
  IEX6      : boolean absolute $C5;
  TF2       : boolean absolute $C6;
  EXF2      : boolean absolute $C7;
  T2I0      : boolean absolute $C8;
  T2I1      : boolean absolute $C9;
  T2CM      : boolean absolute $CA;
  T2R0      : boolean absolute $CB;
  T2R1      : boolean absolute $CC;
  I2FR      : boolean absolute $CD;
  I3FR      : boolean absolute $CE;
  T2PS      : boolean absolute $CF;
  F1        : boolean absolute $D1;
  MX0       : boolean absolute $D8;
  MX1       : boolean absolute $D9;
  MX2       : boolean absolute $DA;
  ADM       : boolean absolute $DB;
  BSY       : boolean absolute $DC;
  ADEX      : boolean absolute $DD;
  CLK       : boolean absolute $DE;
  BD        : boolean absolute $DF;
  ADST      : boolean absolute $E8;


const
  TIMER2    = $2B;
  ADCONV    = $43;
  EXTI2     = $4B;
  EXTI3     = $53;
  EXTI4     = $5B;
  EXTI5     = $63;
  EXTI6     = $6B;
  WAKEUP    = $7B;

implementation

end.
