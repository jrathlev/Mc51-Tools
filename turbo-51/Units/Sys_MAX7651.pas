// MAX7651/MAX7652 processor definition file
// =========================================


unit Sys_MAX7651;

interface

var
  DPL0      : byte absolute $82;
  DPH0      : byte absolute $83;
  DPL1      : byte absolute $84;
  DPH1      : byte absolute $85;
  DPS       : byte absolute $86;
  CKCON     : byte absolute $8E;
  EXIF      : byte absolute $91;
  SCON0     : byte absolute $98;
  SBUF0     : byte absolute $99;
  VERSION   : byte absolute $B2;
  SCON1     : byte absolute $C0;
  SBUF1     : byte absolute $C1;
  ADDAT0    : byte absolute $C2;
  ADDAT1    : byte absolute $C3;
  ADCON     : byte absolute $C5;
  T2CON     : byte absolute $C8;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  EICON     : byte absolute $D8;  // not bit-addressable
  PWPS      : byte absolute $DA;
  PWDA      : byte absolute $DB;
  PWDB      : byte absolute $DC;
  WDT       : byte absolute $DD;
  EIE       : byte absolute $E8;
  EEAL      : byte absolute $EA;
  EEAH      : byte absolute $EB;
  EEDAT     : byte absolute $EC;
  EESTCMD   : byte absolute $ED;
  EIP       : byte absolute $F8;
  PWMC      : byte absolute $FE;


  T2        : boolean absolute $90;  // P1
  T2EX      : boolean absolute $91;
  RXD1      : boolean absolute $92;
  TXD1      : boolean absolute $93;

  RI_0      : boolean absolute $98;  // SCON0
  TI_0      : boolean absolute $99;
  RB8_0     : boolean absolute $9A;
  TB8_0     : boolean absolute $9B;
  REN_0     : boolean absolute $9C;
  SM2_0     : boolean absolute $9D;
  SM1_0     : boolean absolute $9E;
  SM0_0     : boolean absolute $9F;

  ES0       : boolean absolute $AC;
  ET2       : boolean absolute $AD;
  ES1       : boolean absolute $AE;

  RXD0      : boolean absolute $B0;  // P3
  TXD0      : boolean absolute $B1;

  PS0       : boolean absolute $BC;
  PT2       : boolean absolute $BD;
  PS1       : boolean absolute $BE;

  RI_1      : boolean absolute $C0;  // SCON1
  TI_1      : boolean absolute $C1;
  RB8_1     : boolean absolute $C2;
  TB8_1     : boolean absolute $C3;
  REN_1     : boolean absolute $C4;
  SM2_1     : boolean absolute $C5;
  SM1_1     : boolean absolute $C6;
  SM0_1     : boolean absolute $C7;

  CPRL2     : boolean absolute $C8;  // T2CON
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;

  F1        : boolean absolute $D1;

// EICON is not bit-addressable!

  EX2       : boolean absolute $E8;  // EIE
  EX3       : boolean absolute $E9;
  EWDI      : boolean absolute $EC;

  PX2       : boolean absolute $F8;  // EIP
  PX3       : boolean absolute $F9;
  PWDI      : boolean absolute $FC;


const
  SINT0     = $23;
  TIMER2    = $2B;
  SINT1     = $3B;
  FLASH     = $43;  // flash write/erase
  ADCONV    = $4B;  // A/D converter
  WATCHD    = $63;  // watchdog timer

implementation

end.
