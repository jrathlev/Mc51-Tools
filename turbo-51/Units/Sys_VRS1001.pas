// VRS1001 processor definition file
// =================================
// Goal VRS1001, better known as VERSA1


unit Sys_VRS1001;

interface

var
  DPL0      : byte absolute $82;
  DPH0      : byte absolute $83;
  DPL1      : byte absolute $84;
  DPH1      : byte absolute $85;
  DPS       : byte absolute $86;
  CKCON     : byte absolute $8E;
  SPC_FNC   : byte absolute $8F;
  EXIF      : byte absolute $91;
  MPAGE     : byte absolute $92;
  ADCCTRL   : byte absolute $94;
  BGAPCAL   : byte absolute $95;
  ADCALADR  : byte absolute $96;
  ADCALDAT  : byte absolute $97;
  SCON0     : byte absolute $98;
  SBUF0     : byte absolute $99;
  ADCSTAT   : byte absolute $9C;
  ADCD0LO   : byte absolute $A4;
  ADCD0HI   : byte absolute $A5;
  ADCD1LO   : byte absolute $A6;
  ADCD1HI   : byte absolute $A7;
  ADCD2LO   : byte absolute $AC;
  ADCD2HI   : byte absolute $AD;
  ADCD3LO   : byte absolute $AE;
  ADCD3HI   : byte absolute $AF;
  SPICTRL   : byte absolute $B4;
  SPIRX     : byte absolute $B5;
  SPITX     : byte absolute $B6;
  SPIIE     : byte absolute $B7;
  IOCTRL    : byte absolute $BA;
  IOREAD    : byte absolute $BB;
  SPIINTSTAT: byte absolute $BC;
  SPIRXOVC  : byte absolute $BD;
  SCON1     : byte absolute $C0;
  SBUF1     : byte absolute $C1;
  MACACC0   : byte absolute $C4;
  MACACC1   : byte absolute $C5;
  MACACC2   : byte absolute $C6;
  MACACC3   : byte absolute $C7;
  T2CON     : byte absolute $C8;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  S1ACTIVATE: byte absolute $D7;
  EICON     : byte absolute $D8;
  INTSRC    : byte absolute $E4;
  CLKDIV    : byte absolute $E5;
  MACA0     : byte absolute $E6;
  MACA1     : byte absolute $E7;
  EIE       : byte absolute $E8;
  MACRES0   : byte absolute $EA;
  MACRES1   : byte absolute $EB;
  MACRES2   : byte absolute $EC;
  MACRES3   : byte absolute $ED;
  MACB0     : byte absolute $EE;
  MACB1     : byte absolute $EF;
  CONVRLO   : byte absolute $F5;
  CONVRMED  : byte absolute $F6;
  CONVRHI   : byte absolute $F7;
  EIP       : byte absolute $F8;
  PGACTRL   : byte absolute $F9;
  ISRC1     : byte absolute $FA;
  ISRC2     : byte absolute $FB;
  INMUX     : byte absolute $FC;
  OUTMUX    : byte absolute $FD;
  ADCCKDIV  : byte absolute $FE;


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

  RL2       : boolean absolute $C8;  // T2CON
  T2        : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  FIRQT2    : boolean absolute $CE;
  TF2       : boolean absolute $CF;

  F1        : boolean absolute $D1;

  EXT2      : boolean absolute $DB;  // EICON
  SMOD1     : boolean absolute $DF;

  EX2       : boolean absolute $E8;  // EIE
  EX3       : boolean absolute $E9;
  EIE2      : boolean absolute $EC;

  PEX2      : boolean absolute $F8;  // EIP
  PEX3      : boolean absolute $F9;
  PEI2      : boolean absolute $FC;


const
  SPI       = $03;
  SINT0     = $23;
  TIMER2    = $2B;
  SINT1     = $3B;
  ADC       = $43;
  EXTI2     = $63;

  // calibration




implementation

end.
