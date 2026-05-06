// C508 processor definition file
// ==============================


unit Sys_C508;

interface

var
  WDTL      : byte absolute $84;
  WDTH      : byte absolute $85;
  WDTREL    : byte absolute $86;
  PCON1     : byte absolute $88;  // mapped
  XPAGE     : byte absolute $91;
  DPSEL     : byte absolute $92;
  IEN2      : byte absolute $9A;
  IEN0      : byte absolute $A8;
  IP0       : byte absolute $A9;
  SRELL     : byte absolute $AA;
  SYSCON    : byte absolute $B1;
  IEN1      : byte absolute $B8;
  IP1       : byte absolute $B9;
  SRELH     : byte absolute $BA;
  IEN3      : byte absolute $BE;
  IRCON     : byte absolute $C0;
  CCEN      : byte absolute $C1;
  T2CCL1    : byte absolute $C2;
  T2CCH1    : byte absolute $C3;
  T2CCL2    : byte absolute $C4;
  T2CCH2    : byte absolute $C5;
  T2CCL3    : byte absolute $C6;
  T2CCH3    : byte absolute $C7;
  T2CON     : byte absolute $C8;
  CRCL      : byte absolute $CA;
  CRCH      : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  CP2L      : byte absolute $D2;
  CP2H      : byte absolute $D3;
  CMP2L     : byte absolute $D4;
  CMP2H     : byte absolute $D5;
  CCIE      : byte absolute $D6;
  BCON      : byte absolute $D7;
  ADCON0    : byte absolute $D8;
  ADDATH    : byte absolute $D9;
  ADDATL    : byte absolute $DA;
  P4        : byte absolute $DB;
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
  CT2CON    : byte absolute $F1;
  CCL0      : byte absolute $F2;
  CCH0      : byte absolute $F3;
  CCL1      : byte absolute $F4;
  CCH1      : byte absolute $F5;
  CCL2      : byte absolute $F6;
  CCH2      : byte absolute $F7;
  P5        : byte absolute $F8;
  COTRAP    : byte absolute $F9;
  EINT      : byte absolute $FB;
  VR0       : byte absolute $FC;  // mapped
  VR1       : byte absolute $FD;  // mapped
  VR2       : byte absolute $FE;  // mapped
  TRCON     : byte absolute $FF;


  WS        : boolean absolute $8C;  // PCON1 (mapped)
  EWPD      : boolean absolute $8F;

  COUT3     : boolean absolute $90;  // P1
  CTRAP     : boolean absolute $91;
  CC0       : boolean absolute $92;
  COUT0     : boolean absolute $93;
  CC1       : boolean absolute $94;
  COUT1     : boolean absolute $95;
  CC2       : boolean absolute $96;
  COUT2     : boolean absolute $97;


  ET2       : boolean absolute $AD;
  WDT       : boolean absolute $AE;


  EADC      : boolean absolute $B8;  // IEN1
  EX2       : boolean absolute $B9;
  EX3       : boolean absolute $BA;
  EX4       : boolean absolute $BB;
  EX5       : boolean absolute $BC;
  EX6       : boolean absolute $BD;
  SWDT      : boolean absolute $BE;

  IADC      : boolean absolute $C0;  // IRCON
  IEX2      : boolean absolute $C1;
  IEX3      : boolean absolute $C2;
  IEX4      : boolean absolute $C3;
  IEX5      : boolean absolute $C4;
  IEX6      : boolean absolute $C5;
  TF2       : boolean absolute $C6;

  T2I0      : boolean absolute $C8;  // T2CON
  T2I1      : boolean absolute $C9;
  T2CM      : boolean absolute $CA;
  T2R0      : boolean absolute $CB;
  T2R1      : boolean absolute $CC;
  I2FR      : boolean absolute $CD;
  I3FR      : boolean absolute $CE;
  T2PS      : boolean absolute $CF;

  F1        : boolean absolute $D1;

  MX0       : boolean absolute $D8;  // ADCON0
  MX1       : boolean absolute $D9;
  MX2       : boolean absolute $DA;
  ADM       : boolean absolute $DB;
  BSY       : boolean absolute $DC;
  CLK       : boolean absolute $DE;
  BD        : boolean absolute $DF;

  T2CC0     : boolean absolute $F8;  // P5
  INT3      : boolean absolute $F8;
  T2CC1     : boolean absolute $F9;
  INT4      : boolean absolute $F9;
  T2CC2     : boolean absolute $FA;
  INT5      : boolean absolute $FA;
  T2CC3     : boolean absolute $FB;
  INT6      : boolean absolute $FB;
  INT2      : boolean absolute $FC;
  INT9      : boolean absolute $FD;
  INT8      : boolean absolute $FE;
  INT7      : boolean absolute $FF;


const
  TIMER2    = $2B;  // timer 2 interrupt
  ADCONV    = $43;  // A/D converter interrupt
  EXTI2     = $4B;  // external interrupt 2
  EXTI3     = $53;  // external interrupt 3
  EXTI4     = $5B;  // external interrupt 4
  EXTI5     = $63;  // external interrupt 5
  EXTI6     = $6B;  // external interrupt 6
  PWRDWN    = $7B;  // power-down interrupt
  CAPCOM    = $93;  // CAPCOM emergency interrupt
  COMT2I    = $9B;  // compare timer 2 interrupt
  CAPCMI    = $A3;  // capture/compare match interrupt
  COMT1I    = $AB;  // compare timer 1 interrupt
  EXTI7     = $D3;  // external interrupt 7
  EXTI8     = $DB;  // external interrupt 8
  EXTI9     = $E3;  // external interrupt 9

implementation

end.
