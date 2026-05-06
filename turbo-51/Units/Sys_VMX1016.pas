// VMX1016 processor definition file
// =================================
// Goal VMX1016 and Ramtron VMX51C1016


unit Sys_VMX1016;

interface

var
  DPL0      : byte absolute $82;
  DPH0      : byte absolute $83;
  DPL1      : byte absolute $84;
  DPH1      : byte absolute $85;
  DPS       : byte absolute $86;
  IRCON     : byte absolute $91;
  ANALOGPWREN: byte absolute $92;
  DIGPWREN  : byte absolute $93;
  CLKDIVCTRL: byte absolute $94;
  ADCCLKDIV : byte absolute $95;
  S0RELL    : byte absolute $96;
  S0RELH    : byte absolute $97;
  S0CON     : byte absolute $98;
  S0BUF     : byte absolute $99;
  IEN2      : byte absolute $9A;
  P0PINCFG  : byte absolute $9B;
  P1PINCFG  : byte absolute $9C;
  P2PINCFG  : byte absolute $9D;
  P3PINCFG  : byte absolute $9E;
  PORTIRQEN : byte absolute $9F;
  PORTIRQSTAT: byte absolute $A1;
  ADCCTRL   : byte absolute $A2;
  ADCCONVRLOW: byte absolute $A3;
  ADCCONVRMED: byte absolute $A4;
  ADCCONVRHIGH: byte absolute $A5;
  ADCD0LO   : byte absolute $A6;
  ADCD0HI   : byte absolute $A7;
  IEN0      : byte absolute $A8;
  ADCD1LO   : byte absolute $A9;
  ADCD1HI   : byte absolute $AA;
  ADCD2LO   : byte absolute $AB;
  ADCD2HI   : byte absolute $AC;
  ADCD3LO   : byte absolute $AD;
  ADCD3HI   : byte absolute $AE;
  BGAPCAL   : byte absolute $B3;
  PGACAL    : byte absolute $B4;
  INMUXCTRL : byte absolute $B5;
  OUTMUXCTRL: byte absolute $B6;
  SWITCHCTRL: byte absolute $B7;
  IP0       : byte absolute $B8;
  IP1       : byte absolute $B9;
  PGACAL0   : byte absolute $BC;
  S1RELL    : byte absolute $BE;
  S1RELH    : byte absolute $BF;
  S1CON     : byte absolute $C0;
  S1BUF     : byte absolute $C1;
  CCL1      : byte absolute $C2;
  CCH1      : byte absolute $C3;
  CCL2      : byte absolute $C4;
  CCH2      : byte absolute $C5;
  CCL3      : byte absolute $C6;
  CCH3      : byte absolute $C7;
  T2CON     : byte absolute $C8;
  CCEN      : byte absolute $C9;
  CRCL      : byte absolute $CA;
  CRCH      : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  MPAGE     : byte absolute $CF;
  U0BAUD    : byte absolute $D8;
  WDTREL    : byte absolute $D9;
  I2CCONFIG : byte absolute $DA;
  I2CCLKCTRL: byte absolute $DB;
  I2CCHIPID : byte absolute $DC;
  I2CIRQSTAT: byte absolute $DD;
  I2CRXTX   : byte absolute $DE;
  SPIRX3TX0 : byte absolute $E1;
  SPIRX2TX1 : byte absolute $E2;
  SPIRX1TX2 : byte absolute $E3;
  SPIRX0TX3 : byte absolute $E4;
  SPICTRL   : byte absolute $E5;
  SPICONFIG : byte absolute $E6;
  SPISIZE   : byte absolute $E7;
  IEN1      : byte absolute $E8;
  SPIIRQSTAT: byte absolute $E9;
  MACCTRL1  : byte absolute $EB;
  MACC0     : byte absolute $EC;
  MACC1     : byte absolute $ED;
  MACC2     : byte absolute $EE;
  MACC3     : byte absolute $EF;
  MACCTRL2  : byte absolute $F1;
  MACA0     : byte absolute $F2;
  MACA1     : byte absolute $F3;
  MACRES0   : byte absolute $F4;
  MACRES1   : byte absolute $F5;
  MACRES2   : byte absolute $F6;
  MACRES3   : byte absolute $F7;
  USERFLAGS : byte absolute $F8;
  MACB0     : byte absolute $F9;
  MACB1     : byte absolute $FA;
  MACSHIFTCTRL: byte absolute $FB;
  MACPREV0  : byte absolute $FC;
  MACPREV1  : byte absolute $FD;
  MACPREV2  : byte absolute $FE;
  MACPREV3  : byte absolute $FF;

  T2IN      : boolean absolute $80;  // P0
  T2EX      : boolean absolute $81;
  TX1       : boolean absolute $82;
  RX1       : boolean absolute $83;


  PWM0      : boolean absolute $90;  // P1
  PWM1      : boolean absolute $91;
  PWM2      : boolean absolute $92;
  PWM3      : boolean absolute $93;

  R0I       : boolean absolute $98;  // S0CON
  T0I       : boolean absolute $99;
  R0B8      : boolean absolute $9A;
  T0B8      : boolean absolute $9B;
  R0EN      : boolean absolute $9C;
  MPCE0     : boolean absolute $9D;
  S0M1      : boolean absolute $9E;
  S0M0      : boolean absolute $9F;

  CS3       : boolean absolute $A0;  // P2
  CS2       : boolean absolute $A1;
  CS1       : boolean absolute $A2;
  CS0       : boolean absolute $A3;
  SS        : boolean absolute $A4;
  SCK       : boolean absolute $A5;
  SDO       : boolean absolute $A6;
  SDI       : boolean absolute $A7;

  INT0IE    : boolean absolute $A8;  // IEN0
  T0IE      : boolean absolute $A9;
  T1IE      : boolean absolute $AB;
  S0IE      : boolean absolute $AC;
  T2IE      : boolean absolute $AD;
  WDT       : boolean absolute $AE;

  TX0       : boolean absolute $B0;  // P3
  RX0       : boolean absolute $B1;
  T0IN      : boolean absolute $B2;
  CCU0      : boolean absolute $B3;
  CCU1      : boolean absolute $B4;
  T1IN      : boolean absolute $B5;
  SDA       : boolean absolute $B6;
  SCL       : boolean absolute $B7;

  PSPIRX    : boolean absolute $BA;
  PS0       : boolean absolute $BC;
  PT2       : boolean absolute $BD;
  WDTSTAT   : boolean absolute $BE;
  UF8       : boolean absolute $BF;

  R1I       : boolean absolute $C0;  // S1CON
  T1I       : boolean absolute $C1;
  R1B8      : boolean absolute $C2;
  T1B8      : boolean absolute $C3;
  R1EN      : boolean absolute $C4;
  MPCE1     : boolean absolute $C5;
  S1M       : boolean absolute $C7;

  T2IN0     : boolean absolute $C8;  // T2CON
  T2IN1     : boolean absolute $C9;
  T2CM      : boolean absolute $CA;
  T2RM0     : boolean absolute $CB;
  T2RM1     : boolean absolute $CC;
  T2SIZE    : boolean absolute $CD;
  T2PSM     : boolean absolute $CE;
  T2PS      : boolean absolute $CF;


  BAUDSRC   : boolean absolute $DF;  // U0BAUD

  SPITEIE   : boolean absolute $E9;  // IEN1
  SPIRXOVIE : boolean absolute $EA;
  I2CIE     : boolean absolute $EB;
  MACOVIE   : boolean absolute $EC;
  ADCPCIE   : boolean absolute $ED;
  SWDT      : boolean absolute $EE;
  T2EXIE    : boolean absolute $EF;

  UF0       : boolean absolute $F8;  // USERFLAGS
  UF1       : boolean absolute $F9;
  UF2       : boolean absolute $FA;
  UF3       : boolean absolute $FB;
  UF4       : boolean absolute $FC;
  UF5       : boolean absolute $FD;
  UF6       : boolean absolute $FE;
  UF7       : boolean absolute $FF;


const
  SINT0     = $23;
  TIMER2    = $2B;
  SPITXE    = $4B;  // SPI Tx empty
  SPIRXO    = $53;  // SPI Rx and Rx overrun
  I2CINT    = $5B;
  MULTOV    = $63;
  ADCINT    = $6B;
  SINT1     = $83;

implementation

end.
