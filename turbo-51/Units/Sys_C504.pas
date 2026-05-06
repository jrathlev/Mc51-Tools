// C504 processor definition file
// ==============================


unit Sys_C504;

interface

var
  WDTREL    : byte absolute $86;
  PCON1     : byte absolute $88;
  P1ANA     : byte absolute $90;
  ITCON     : byte absolute $9A;
  IEN0      : byte absolute $A8;
  IEN1      : byte absolute $A9;
  P3ANA     : byte absolute $B0;
  SYSCON    : byte absolute $B1;
  IP0       : byte absolute $B8;
  IP1       : byte absolute $B9;
  WDCON     : byte absolute $C0;
  CT2CON    : byte absolute $C1;
  CCL0      : byte absolute $C2;
  CCH0      : byte absolute $C3;
  CCL1      : byte absolute $C4;
  CCH1      : byte absolute $C5;
  CCL2      : byte absolute $C6;
  CCH2      : byte absolute $C7;
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RC2L      : byte absolute $CA;
  RC2H      : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  TRCON     : byte absolute $CF;
  CP2L      : byte absolute $D2;
  CP2H      : byte absolute $D3;
  CMP2L     : byte absolute $D4;
  CMP2H     : byte absolute $D5;
  CCIE      : byte absolute $D6;
  BCON      : byte absolute $D7;
  ADCON0    : byte absolute $D8;
  ADDATH    : byte absolute $D9;
  ADDATL    : byte absolute $DA;
  ADCON1    : byte absolute $DC;
  CCPL      : byte absolute $DE;
  CCPH      : byte absolute $DF;
  CT1CON    : byte absolute $E1;
  COINI     : byte absolute $E2;
  CMSEL0    : byte absolute $E3;
  CMSEL1    : byte absolute $E4;
  CCIR      : byte absolute $E5;
  CT1OFL    : byte absolute $E6;
  CT1OFH    : byte absolute $E7;

  T2        : boolean absolute $90;
  AN0       : boolean absolute $90;
  T2EX      : boolean absolute $91;
  AN1       : boolean absolute $91;
  CC0       : boolean absolute $92;
  AN2       : boolean absolute $92;
  COUT0     : boolean absolute $93;
  AN3       : boolean absolute $93;
  CC1       : boolean absolute $94;
  COUT1     : boolean absolute $95;
  CC2       : boolean absolute $96;
  COUT2     : boolean absolute $97;
  ET2       : boolean absolute $AD;
  AN4       : boolean absolute $B2;
  AN5       : boolean absolute $B3;
  AN6       : boolean absolute $B4;
  AN7       : boolean absolute $B5;
  INT2      : boolean absolute $B6;
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
  MX0       : boolean absolute $D8;
  MX1       : boolean absolute $D9;
  MX2       : boolean absolute $DA;
  ADM       : boolean absolute $DB;
  BSY       : boolean absolute $DC;
  IADC      : boolean absolute $DD;


const
  TIMER2    = $2B;  // timer 2 interrupt
  ADCONV    = $43;  // A/D converter interrupt
  EXTI2     = $4B;  // external interrupt 2
  CAPCOM    = $53;  // CAPCOM emergency interrupt
  COMT2I    = $5B;  // compare timer 2 interrupt
  CAPCMI    = $63;  // capture/compare match interrupt
  COMT1I    = $6B;  // compare timer 1 interrupt
  PWRDWN    = $7B;  // power-down interrupt

implementation

end.
