// C8051F5xx processor definition file
// ===================================
// Silicon Labs C8051F520/1/3/4/6/7 and C8051F530/1/3/4/6/7


unit Sys_C8051F5X;

interface

var
  CKCON     : byte absolute $8E;
  PSCTL     : byte absolute $8F;
  LINADDR   : byte absolute $92;
  LINDATA   : byte absolute $93;
  LINCF     : byte absolute $95;
  SCON0     : byte absolute $98;
  SBUF0     : byte absolute $99;
  CPT0CN    : byte absolute $9B;
  CPT0MD    : byte absolute $9D;
  CPT0MX    : byte absolute $9F;
  SPI0CFG   : byte absolute $A1;
  SPI0CKR   : byte absolute $A2;
  SPI0DAT   : byte absolute $A3;
  P0MDOUT   : byte absolute $A4;
  P1MDOUT   : byte absolute $A5;
  CLKSEL    : byte absolute $A9;
  OSCIFIN   : byte absolute $B0;
  OSCXCN    : byte absolute $B1;
  OSCICN    : byte absolute $B2;
  OSCICL    : byte absolute $B3;
  FLKEY     : byte absolute $B7;
  ADC0TK    : byte absolute $BA;
  ADC0MX    : byte absolute $BB;
  ADC0CF    : byte absolute $BC;
  ADC0L     : byte absolute $BD;
  ADC0H     : byte absolute $BE;
  P1MASK    : byte absolute $BF;
  ADC0GTL   : byte absolute $C3;
  ADC0GTH   : byte absolute $C4;
  ADC0LTL   : byte absolute $C5;
  ADC0LTH   : byte absolute $C6;
  P0MASK    : byte absolute $C7;
  TMR2CN    : byte absolute $C8;
  REG0CN    : byte absolute $C9;
  TMR2RLL   : byte absolute $CA;
  TMR2RLH   : byte absolute $CB;
  TMR2L     : byte absolute $CC;
  TMR2H     : byte absolute $CD;
  P1MAT     : byte absolute $CF;
  REF0CN    : byte absolute $D1;
  P0SKIP    : byte absolute $D4;
  P1SKIP    : byte absolute $D5;
  P0MAT     : byte absolute $D7;
  PCA0CN    : byte absolute $D8;
  PCA0MD    : byte absolute $D9;
  PCA0CPM0  : byte absolute $DA;
  PCA0CPM1  : byte absolute $DB;
  PCA0CPM2  : byte absolute $DC;
  XBR0      : byte absolute $E1;
  XBR1      : byte absolute $E2;
  IT01CF    : byte absolute $E4;
  EIE1      : byte absolute $E6;
  ADC0CN    : byte absolute $E8;
  PCA0CPL1  : byte absolute $E9;
  PCA0CPH1  : byte absolute $EA;
  PCA0CPL2  : byte absolute $EB;
  PCA0CPH2  : byte absolute $EC;
  RSTSRC    : byte absolute $EF;
  P0MDIN    : byte absolute $F1;
  P1MDIN    : byte absolute $F2;
  EIP1      : byte absolute $F6;
  SPI0CN    : byte absolute $F8;
  PCA0L     : byte absolute $F9;
  PCA0H     : byte absolute $FA;
  PCA0CPL0  : byte absolute $FB;
  PCA0CPH0  : byte absolute $FC;
  VDDMON    : byte absolute $FF;


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

  T2XCLK    : boolean absolute $C8;  // TMR2CN
  T2RCLK    : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  T2SPLIT   : boolean absolute $CB;
  TF2CEN    : boolean absolute $CC;
  TF2LEN    : boolean absolute $CD;
  TF2L      : boolean absolute $CE;
  TF2H      : boolean absolute $CF;

  F1        : boolean absolute $D1;

  CCF0      : boolean absolute $D8;  // PCA0CN
  CCF1      : boolean absolute $D9;
  CCF2      : boolean absolute $DA;
  CR        : boolean absolute $DE;
  CF        : boolean absolute $DF;

  AD0CM0    : boolean absolute $E8;  // ADC0CN
  AD0CM1    : boolean absolute $E9;
  AD0LJST   : boolean absolute $EA;
  AD0WINT   : boolean absolute $EB;
  AD0BUSY   : boolean absolute $EC;
  AD0INT    : boolean absolute $ED;
  BURSTEN   : boolean absolute $EE;
  AD0EN     : boolean absolute $EF;

  SPIEN     : boolean absolute $F8;  // SPI0CN
  TXBMT     : boolean absolute $F9;
  NSSMD0    : boolean absolute $FA;
  NSSMD1    : boolean absolute $FB;
  RXOVRN    : boolean absolute $FC;
  MODF      : boolean absolute $FD;
  WCOL      : boolean absolute $FE;
  SPIF      : boolean absolute $FF;


const
  SINT0     = $23;
  TIMER2    = $2B;
  SPI       = $33;
  ADC0WC    = $3B;
  ADC0EC    = $43;
  PCA       = $4B;
  CMP0FE    = $53;
  CMP0RE    = $5B;
  LIN       = $63;
  VREG      = $6B;
  PMATCH    = $73;

implementation

end.
