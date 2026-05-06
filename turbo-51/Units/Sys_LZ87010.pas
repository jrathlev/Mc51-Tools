// LZ87010 processor definition file
// =================================
// Sharp LZ87010


unit Sys_LZ87010;

interface

var
  DPL1      : byte absolute $84;
  DPH1      : byte absolute $85;
  DPS       : byte absolute $86;
  P5        : byte absolute $91;
  P8        : byte absolute $93;
  CLKCFG    : byte absolute $94;
  ALTFEN1   : byte absolute $95;
  FLASHCFG  : byte absolute $96;
  FLASHTB   : byte absolute $97;
  T5CON     : byte absolute $A1;
  T5STA     : byte absolute $A2;
  T5CMP     : byte absolute $A3;
  T5CMP0L   : byte absolute $A4;
  T5CMP0H   : byte absolute $A5;
  T5CMP1L   : byte absolute $A6;
  T5CMP1H   : byte absolute $A7;
  P9        : byte absolute $A9;
  WDTCTL    : byte absolute $AC;
  WDTCNT    : byte absolute $AD;
  T5CNTL    : byte absolute $AE;
  T5CNTH    : byte absolute $AF;
  TCMPOE    : byte absolute $B3;
  ICCON     : byte absolute $B4;
  ICSAR     : byte absolute $B5;
  ICUSAR    : byte absolute $B6;
  ICDATA    : byte absolute $B7;
  IPH       : byte absolute $B9;
  ICHCNT    : byte absolute $BC;
  ICLCNT    : byte absolute $BD;
  ICDBUG    : byte absolute $BE;
  ICSTAT    : byte absolute $BF;
  P6        : byte absolute $C0;
  ADCDL     : byte absolute $C1;
  ADCDH     : byte absolute $C2;
  ADCC      : byte absolute $C3;
  DACC      : byte absolute $C4;
  XMCFG     : byte absolute $C5;
  BRGCNTL   : byte absolute $C6;
  BRGCNTH   : byte absolute $C7;
  SCON1     : byte absolute $C8;
  SBUF1     : byte absolute $C9;
  WGCTL0    : byte absolute $CA;
  WGCTL1    : byte absolute $CB;
  WGCFG0    : byte absolute $CC;
  WGCFG1    : byte absolute $CD;
  WGINX0    : byte absolute $CE;
  WGINX1    : byte absolute $CF;
  T2CON     : byte absolute $D1;
  T2STA     : byte absolute $D2;
  T2CMP     : byte absolute $D3;
  T2CMP0L   : byte absolute $D4;
  T2CMP0H   : byte absolute $D5;
  T2CMP1L   : byte absolute $D6;
  T2CMP1H   : byte absolute $D7;
  P7        : byte absolute $D8;
  T2CAP     : byte absolute $D9;
  T2CAP0L   : byte absolute $DA;
  T2CAP0H   : byte absolute $DB;
  T2CAP1L   : byte absolute $DC;
  T2CAP1H   : byte absolute $DD;
  T2CNTL    : byte absolute $DE;
  T2CNTH    : byte absolute $DF;
  T3CON     : byte absolute $E1;
  T3STA     : byte absolute $E2;
  T3CMP     : byte absolute $E3;
  T3CMP0L   : byte absolute $E4;
  T3CMP0H   : byte absolute $E5;
  T3CMP1L   : byte absolute $E6;
  T3CMP1H   : byte absolute $E7;
  IE_1      : byte absolute $E8;  // the Sharp name IE1 conflicts with bit IE1 in TCON
  T3CAP     : byte absolute $E9;
  T3CAP0L   : byte absolute $EA;
  T3CAP0H   : byte absolute $EB;
  T3CAP1L   : byte absolute $EC;
  T3CAP1H   : byte absolute $ED;
  T3CNTL    : byte absolute $EE;
  T3CNTH    : byte absolute $EF;
  T4CON     : byte absolute $F1;
  T4STA     : byte absolute $F2;
  T4CMP     : byte absolute $F3;
  T4CMP0L   : byte absolute $F4;
  T4CMP0H   : byte absolute $F5;
  T4CMP1L   : byte absolute $F6;
  T4CMP1H   : byte absolute $F7;
  IP1       : byte absolute $F8;
  IPH1      : byte absolute $F9;
  WGMA0     : byte absolute $FA;
  WGMD0     : byte absolute $FB;
  WGMA1     : byte absolute $FC;
  WGMD1     : byte absolute $FD;
  T4CNTL    : byte absolute $FE;
  T4CNTH    : byte absolute $FF;

  INT2      : boolean absolute $82;
  INT3      : boolean absolute $83;
  INT4      : boolean absolute $84;
  INT5      : boolean absolute $85;
  INT6      : boolean absolute $86;
  INT7      : boolean absolute $87;


  CTIN3     : boolean absolute $90;  // P1
  CTCAP3A   : boolean absolute $92;
  CTCAP3B   : boolean absolute $93;
  CTCMP3A   : boolean absolute $94;
  CTCMP3B   : boolean absolute $95;
  nPSWR     : boolean absolute $96;
  nPSEN     : boolean absolute $97;



  RXD0      : boolean absolute $B0;  // P3
  TXD0      : boolean absolute $B1;
  TXD1      : boolean absolute $B2;
  RXD1      : boolean absolute $B3;
  WFGIN1    : boolean absolute $B4;
  WFGIN0    : boolean absolute $B5;
  SCL       : boolean absolute $B6;
  SDA       : boolean absolute $B7;


  CTIN4     : boolean absolute $C0;  // P6
  CTCMP4A   : boolean absolute $C2;
  CTCMP4B   : boolean absolute $C3;
  CTIN5     : boolean absolute $C4;
  CTCMP5A   : boolean absolute $C6;
  CTCMP5B   : boolean absolute $C7;

  RI_1      : boolean absolute $C8;  // SCON1
  TI_1      : boolean absolute $C9;
  RB8_1     : boolean absolute $CA;  // renamed all SCON1 bit symbols
  TB8_1     : boolean absolute $CB;  // to avoid name conflicts with the
  REN_1     : boolean absolute $CC;  // corresponding SCON bit symbols
  SM2_1     : boolean absolute $CD;
  SM1_1     : boolean absolute $CE;
  SM0_1     : boolean absolute $CF;

  F1        : boolean absolute $D1;

  CTIN2     : boolean absolute $D8;  // P7
  CTCAP2A   : boolean absolute $DA;
  CTCAP2B   : boolean absolute $DB;
  CTCMP2A   : boolean absolute $DC;
  CTCMP2B   : boolean absolute $DD;
  CTIN0     : boolean absolute $DE;
  CTIN1     : boolean absolute $DF;

  ET4T5     : boolean absolute $E8;  // IE_1
  ET2T3     : boolean absolute $E9;
  EI2C      : boolean absolute $EA;
  ES1       : boolean absolute $EB;
  EADC      : boolean absolute $EC;
  EDAC0     : boolean absolute $ED;
  EDAC1     : boolean absolute $EE;
  EX2       : boolean absolute $EF;

  PT4T5     : boolean absolute $F8;  // IP1
  PT2T3     : boolean absolute $F9;
  PI2C      : boolean absolute $FA;  // the original Sharp names PI6 .. PI13
  PS1       : boolean absolute $FB;  // are not very comprehensive and do not
  PADC      : boolean absolute $FC;  // match the corresponding bit names in IE_1
  PDAC0     : boolean absolute $FD;
  PDAC1     : boolean absolute $FE;
  PX2       : boolean absolute $FF;


const
  TIMER45   = $33;  // shared by timers 4 and 5
  TIMER23   = $3B;  // shared by timers 2 and 3
  I2C       = $43;
  SINT1     = $4B;
  ADC       = $53;
  DAC0      = $5B;
  DAC1      = $63;
  EXTI2     = $6B;  // shared by external interrupts 2 thru 7

implementation

end.
