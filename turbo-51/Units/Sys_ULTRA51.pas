// Ultra51 processor definition file
// =================================
// (Winedge U51F128 and U51F64)


unit Sys_ULTRA51;

interface

var
  PAGETYPE  : byte absolute $9A;
  PAGEA     : byte absolute $9B;
  PAGEB     : byte absolute $9C;
  PAGEC     : byte absolute $9D;
  WDTRST    : byte absolute $9F;
  DPSEL     : byte absolute $A2;
  P0_DIR    : byte absolute $A4;
  P1_DIR    : byte absolute $A5;
  P2_DIR    : byte absolute $A6;
  P3_DIR    : byte absolute $A7;
  CSMCON    : byte absolute $A9;
  CSMRBS    : byte absolute $AA;
  KBIRQSEL  : byte absolute $AB;
  P0ALT     : byte absolute $AC;
  P1ALT     : byte absolute $AD;
  P2ALT     : byte absolute $AE;
  P3ALT     : byte absolute $AF;
  MR0       : byte absolute $C0;
  MR1       : byte absolute $C1;
  MR2       : byte absolute $C2;
  MR3       : byte absolute $C3;
  MR4       : byte absolute $C4;
  INSTRSEL  : byte absolute $C5;
  T2CON     : byte absolute $C8;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  SIO1BUF   : byte absolute $D3;
  SIO1CON   : byte absolute $D4;
  SIO1BAUD  : byte absolute $D5;
  PIF       : byte absolute $D8;
  SIO2BUF   : byte absolute $DB;
  SIO2CON   : byte absolute $DC;
  SIO2BAUD  : byte absolute $DD;
  MLDDF     : byte absolute $E1;
  MLDIXR    : byte absolute $E2;
  MLDCR     : byte absolute $E3;
  ADCCON    : byte absolute $E4;
  ADCBUF    : byte absolute $E5;
  PIE       : byte absolute $E8;
  RTCCR     : byte absolute $F1;
  RTCIR     : byte absolute $F2;
  RTCDR     : byte absolute $F3;
  KEYCODE0  : byte absolute $F5;
  KEYCODE1  : byte absolute $F6;
  KEYCODE2  : byte absolute $F7;
  PIP       : byte absolute $F8;


  T2        : boolean absolute $90;  // P1
  T2EX      : boolean absolute $91;
  SDI1      : boolean absolute $95;
  SDO1      : boolean absolute $96;
  SCLK1     : boolean absolute $97;


  KEY0      : boolean absolute $A0;  // P2
  KEY1      : boolean absolute $A1;
  KEY2      : boolean absolute $A2;
  KEY3      : boolean absolute $A3;
  KEY4      : boolean absolute $A4;
  KEY5      : boolean absolute $A5;
  KEY6      : boolean absolute $A6;
  KEY7      : boolean absolute $A7;

  ET2       : boolean absolute $AD;

  SHTCLK    : boolean absolute $B2;
  MLDOUT    : boolean absolute $B6;
  SCLK2     : boolean absolute $B7;

  PT2       : boolean absolute $BD;

  CPRL2     : boolean absolute $C8;  // T2CON
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;


  SIO1IF    : boolean absolute $D9;  // PIF
  SIO2IF    : boolean absolute $DA;
  MLDIF     : boolean absolute $DB;
  RTCIF     : boolean absolute $DC;
  ADCIF     : boolean absolute $DD;
  KEYIF     : boolean absolute $DE;

  SIO1IE    : boolean absolute $E9;  // PIE
  SIO2IE    : boolean absolute $EA;
  MLDIE     : boolean absolute $EB;
  RTCIE     : boolean absolute $EC;
  ADCIE     : boolean absolute $ED;
  KEYIE     : boolean absolute $EE;

  SIO1IP    : boolean absolute $F9;  // PIP
  SIO2IP    : boolean absolute $FA;
  MLDIP     : boolean absolute $FB;
  RTCIP     : boolean absolute $FC;
  ADCIP     : boolean absolute $FD;
  KEYIP     : boolean absolute $FE;


const
  TIMER2    = $2B;
  SIO1      = $3B;
  SIO2      = $43;
  MELODY    = $4B;
  RTC       = $53;
  ADC       = $5B;
  KEYBOARD  = $63;
  SWINT     = $73;  // trap

implementation

end.
