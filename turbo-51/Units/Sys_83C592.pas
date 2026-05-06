// 83C592 processor definition file
// ================================
// Philips P83C592 and P80C592


unit Sys_83C592;

interface

{$IDATA }
var
  S0CON     : byte absolute $98;
  S0BUF     : byte absolute $99;
  IEN0      : byte absolute $A8;
  CML0      : byte absolute $A9;
  CML1      : byte absolute $AA;
  CML2      : byte absolute $AB;
  CTL0      : byte absolute $AC;
  CTL1      : byte absolute $AD;
  CTL2      : byte absolute $AE;
  CTL3      : byte absolute $AF;
  IP0       : byte absolute $B8;
  P4        : byte absolute $C0;
  P5        : byte absolute $C4;
  ADCON     : byte absolute $C5;
  ADCH      : byte absolute $C6;
  TM2IR     : byte absolute $C8;
  CMH0      : byte absolute $C9;
  CMH1      : byte absolute $CA;
  CMH2      : byte absolute $CB;
  CTH0      : byte absolute $CC;
  CTH1      : byte absolute $CD;
  CTH2      : byte absolute $CE;
  CTH3      : byte absolute $CF;
  CANSTA    : byte absolute $D8;
  CANCON    : byte absolute $D9;
  CANDAT    : byte absolute $DA;
  CANADR    : byte absolute $DB;
  IEN1      : byte absolute $E8;
  TM2CON    : byte absolute $EA;
  CTCON     : byte absolute $EB;
  TML2      : byte absolute $EC;
  TMH2      : byte absolute $ED;
  STE       : byte absolute $EE;
  RTE       : byte absolute $EF;
  IP1       : byte absolute $F8;
  PWM0      : byte absolute $FC;
  PWM1      : byte absolute $FD;
  PWMP      : byte absolute $FE;
  T3        : byte absolute $FF;


  CT0I      : boolean absolute $90;  // P1
  INT2      : boolean absolute $90;
  CT1I      : boolean absolute $91;
  INT3      : boolean absolute $91;
  CT2I      : boolean absolute $92;
  INT4      : boolean absolute $92;
  CT3I      : boolean absolute $93;
  INT5      : boolean absolute $93;
  T2        : boolean absolute $94;
  RT2       : boolean absolute $95;
  CTX0      : boolean absolute $96;
  CTX1      : boolean absolute $97;


  ES0       : boolean absolute $AC;
  ES1       : boolean absolute $AD;
  EAD       : boolean absolute $AE;


  PS0       : boolean absolute $BC;
  PS1       : boolean absolute $BD;
  PAD       : boolean absolute $BE;

  CMSR0     : boolean absolute $C0;  // P4
  CMSR1     : boolean absolute $C1;
  CMSR2     : boolean absolute $C2;
  CMSR3     : boolean absolute $C3;
  CMSR4     : boolean absolute $C4;
  CMSR5     : boolean absolute $C5;
  CMT0      : boolean absolute $C6;
  CMT1      : boolean absolute $C7;

  CTI0      : boolean absolute $C8;  // TM2IR
  CTI1      : boolean absolute $C9;
  CTI2      : boolean absolute $CA;
  CTI3      : boolean absolute $CB;
  CMI0      : boolean absolute $CC;
  CMI1      : boolean absolute $CD;
  CMI2      : boolean absolute $CE;
  T2OV      : boolean absolute $CF;

  F1        : boolean absolute $D1;

  RBS       : boolean absolute $D8;  // CANSTA
  DO        : boolean absolute $D9;
  TBS       : boolean absolute $DA;
  TCS       : boolean absolute $DB;
  RS        : boolean absolute $DC;
  TS        : boolean absolute $DD;
  BS        : boolean absolute $DF;

  ECT0      : boolean absolute $E8;  // IEN1
  ECT1      : boolean absolute $E9;
  ECT2      : boolean absolute $EA;
  ECT3      : boolean absolute $EB;
  ECM0      : boolean absolute $EC;
  ECM1      : boolean absolute $ED;
  ECM2      : boolean absolute $EE;
  ET2       : boolean absolute $EF;

  PCT0      : boolean absolute $F8;  // IP1
  PCT1      : boolean absolute $F9;
  PCT2      : boolean absolute $FA;
  PCT3      : boolean absolute $FB;
  PCM0      : boolean absolute $FC;
  PCM1      : boolean absolute $FD;
  PCM2      : boolean absolute $FE;
  PT2       : boolean absolute $FF;


const
  CAN       = $2B;
  T2CAP0    = $33;
  T2CAP1    = $3B;
  T2CAP2    = $43;
  T2CAP3    = $4B;
  ADCONV    = $53;
  T2CMP0    = $5B;
  T2CMP1    = $63;
  T2CMP2    = $6B;
  TIMER2    = $73;

implementation

end.
