// C8051F35x processor definition file
// ===================================
// Cygnal C8051F350/1/2/3


unit Sys_C8051F35;

interface

var
  CKCON     : byte absolute $8E;
  PSCTL     : byte absolute $8F;
  TMR3CN    : byte absolute $91;
  TMR3RLL   : byte absolute $92;
  TMR3RLH   : byte absolute $93;
  TMR3L     : byte absolute $94;
  TMR3H     : byte absolute $95;
  IDA0      : byte absolute $96;
  SCON0     : byte absolute $98;
  SBUF0     : byte absolute $99;
  ADC0DECL  : byte absolute $9A;
  ADC0DECH  : byte absolute $9B;
  CPT0CN    : byte absolute $9C;
  CPT0MD    : byte absolute $9D;
  CPT0MX    : byte absolute $9F;
  SPI0CFG   : byte absolute $A1;
  SPI0CKR   : byte absolute $A2;
  SPI0DAT   : byte absolute $A3;
  P0MDOUT   : byte absolute $A4;
  P1MDOUT   : byte absolute $A5;
  P2MDOUT   : byte absolute $A6;
  CLKSEL    : byte absolute $A9;
  EMI0CN    : byte absolute $AA;
  ADC0CGL   : byte absolute $AB;
  ADC0CGM   : byte absolute $AC;
  ADC0CGH   : byte absolute $AD;
  OSCXCN    : byte absolute $B1;
  OSCICN    : byte absolute $B2;
  OSCICL    : byte absolute $B3;
  FLSCL     : byte absolute $B6;
  FLKEY     : byte absolute $B7;
  IDA0CN    : byte absolute $B9;
  ADC0COL   : byte absolute $BA;
  ADC0COM   : byte absolute $BB;
  ADC0COH   : byte absolute $BC;
  ADC0BUF   : byte absolute $BD;
  CLKMUL    : byte absolute $BE;
  ADC0DAC   : byte absolute $BF;
  SMB0CN    : byte absolute $C0;
  SMB0CF    : byte absolute $C1;
  SMB0DAT   : byte absolute $C2;
  ADC0L     : byte absolute $C3;
  ADC0M     : byte absolute $C4;
  ADC0H     : byte absolute $C5;
  ADC0MUX   : byte absolute $C6;
  TMR2CN    : byte absolute $C8;
  TMR2RLL   : byte absolute $CA;
  TMR2RLH   : byte absolute $CB;
  TMR2L     : byte absolute $CC;
  TMR2H     : byte absolute $CD;
  REF0CN    : byte absolute $D1;
  P0SKIP    : byte absolute $D4;
  P1SKIP    : byte absolute $D5;
  IDA1CN    : byte absolute $D7;
  PCA0CN    : byte absolute $D8;
  PCA0MD    : byte absolute $D9;
  PCA0CPM0  : byte absolute $DA;
  PCA0CPM1  : byte absolute $DB;
  PCA0CPM2  : byte absolute $DC;
  IDA1      : byte absolute $DD;
  XBR0      : byte absolute $E1;
  XBR1      : byte absolute $E2;
  PFE0CN    : byte absolute $E3;
  IT01CF    : byte absolute $E4;
  EIE1      : byte absolute $E6;
  ADC0STA   : byte absolute $E8;
  PCA0CPL0  : byte absolute $E9;
  PCA0CPH0  : byte absolute $EA;
  PCA0CPL1  : byte absolute $EB;
  PCA0CPH1  : byte absolute $EC;
  PCA0CPL2  : byte absolute $ED;
  PCA0CPH2  : byte absolute $EE;
  RSTSRC    : byte absolute $EF;
  P0MDIN    : byte absolute $F1;
  P1MDIN    : byte absolute $F2;
  ADC0MD    : byte absolute $F3;
  ADC0CN    : byte absolute $F4;
  EIP1      : byte absolute $F6;
  ADC0CLK   : byte absolute $F7;
  SPI0CN    : byte absolute $F8;
  PCA0L     : byte absolute $F9;
  PCA0H     : byte absolute $FA;
  ADC0CF    : byte absolute $FB;
  ADC0FL    : byte absolute $FC;
  ADC0FM    : byte absolute $FD;
  ADC0FH    : byte absolute $FE;
  VDM0CN    : byte absolute $FF;


  RI0       : boolean absolute $98;  // SCON0
  TI0       : boolean absolute $99;
  RB80      : boolean absolute $9A;
  TB80      : boolean absolute $9B;
  REN0      : boolean absolute $9C;
  MCE0      : boolean absolute $9D;
  S0MODE    : boolean absolute $9F;

  ES0       : boolean absolute $AC;
  ET2       : boolean absolute $AD;
  ESPI0     : boolean absolute $AE;

  PS0       : boolean absolute $BC;
  PT2       : boolean absolute $BD;
  PSPI0     : boolean absolute $BE;

  SI        : boolean absolute $C0;  // SMB0CN
  ACK       : boolean absolute $C1;
  ARBLOST   : boolean absolute $C2;
  ACKRQ     : boolean absolute $C3;
  STO       : boolean absolute $C4;
  STA       : boolean absolute $C5;
  TXMODE    : boolean absolute $C6;
  MASTER    : boolean absolute $C7;

  T2XCLK    : boolean absolute $C8;  // TMR2CN
  TR2       : boolean absolute $CA;
  T2SPLIT   : boolean absolute $CB;
  TF2LEN    : boolean absolute $CD;
  TF2L      : boolean absolute $CE;
  TF2H      : boolean absolute $CF;

  F1        : boolean absolute $D1;

  CCF0      : boolean absolute $D8;  // PCA0CN
  CCF1      : boolean absolute $D9;
  CCF2      : boolean absolute $DA;
  CR        : boolean absolute $DE;
  CF        : boolean absolute $DF;

  AD0OVR    : boolean absolute $E8;  // ADC0STA
  AD0ERR    : boolean absolute $E9;
  AD0CALC   : boolean absolute $EA;
  AD0FFC    : boolean absolute $EB;
  AD0S3C    : boolean absolute $EC;
  AD0INT    : boolean absolute $ED;
  AD0CBSY   : boolean absolute $EE;
  AD0BUSY   : boolean absolute $EF;

  SPIEN     : boolean absolute $F8;  // SPI0CN
  TXBMT     : boolean absolute $F9;
  NSSMD0    : boolean absolute $FA;
  NSSMD1    : boolean absolute $FB;
  RXOVRN    : boolean absolute $FC;
  MODF      : boolean absolute $FD;
  WCOL      : boolean absolute $FE;
  SPIF      : boolean absolute $FF;


const
  TIMER2    = $2B;
  SPI       = $33;
  SMB       = $3B;
  ADC0      = $53;
  PCA       = $5B;
  CMP0      = $63;
  TIMER3    = $73;

implementation

end.
