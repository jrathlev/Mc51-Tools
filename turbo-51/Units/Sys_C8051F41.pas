// C8051F41x processor definition file
// ===================================
// Silicon Labs C8051F410/1/2/3


unit Sys_C8051F41;

interface

var
  CRC0CN    : byte absolute $84;
  CRC0IN    : byte absolute $85;
  CRC0DAT   : byte absolute $86;
  CKCON     : byte absolute $8E;
  PSCTL     : byte absolute $8F;
  TMR3CN    : byte absolute $91;
  TMR3RLL   : byte absolute $92;
  TMR3RLH   : byte absolute $93;
  TMR3L     : byte absolute $94;
  TMR3H     : byte absolute $95;
  IDA0L     : byte absolute $96;
  IDA0H     : byte absolute $97;
  SCON0     : byte absolute $98;
  SBUF0     : byte absolute $99;
  CPT1CN    : byte absolute $9A;
  CPT0CN    : byte absolute $9B;
  CPT1MD    : byte absolute $9C;
  CPT0MD    : byte absolute $9D;
  CPT1MX    : byte absolute $9E;
  CPT0MX    : byte absolute $9F;
  SPI0CFG   : byte absolute $A1;
  SPI0CKR   : byte absolute $A2;
  SPI0DAT   : byte absolute $A3;
  P0MDOUT   : byte absolute $A4;
  P1MDOUT   : byte absolute $A5;
  P2MDOUT   : byte absolute $A6;
  CLKSEL    : byte absolute $A9;
  EMI0CN    : byte absolute $AA;
  CLKMUL    : byte absolute $AB;
  RTC0ADR   : byte absolute $AC;
  RTC0DAT   : byte absolute $AD;
  RTC0KEY   : byte absolute $AE;
  ONESHOT   : byte absolute $AF;
  P0ODEN    : byte absolute $B0;
  OSCXCN    : byte absolute $B1;
  OSCICN    : byte absolute $B2;
  OSCICL    : byte absolute $B3;
  IDA1CN    : byte absolute $B5;
  FLSCL     : byte absolute $B6;
  FLKEY     : byte absolute $B7;
  IDA0CN    : byte absolute $B9;
  ADC0TK    : byte absolute $BA;
  ADC0MX    : byte absolute $BB;
  ADC0CF    : byte absolute $BC;
  ADC0L     : byte absolute $BD;
  ADC0H     : byte absolute $BE;
  P1MASK    : byte absolute $BF;
  SMB0CN    : byte absolute $C0;
  SMB0CF    : byte absolute $C1;
  SMB0DAT   : byte absolute $C2;
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
  PCA0CPM5  : byte absolute $CE;
  P1MAT     : byte absolute $CF;
  REF0CN    : byte absolute $D1;
  PCA0CPL5  : byte absolute $D2;
  PCA0CPH5  : byte absolute $D3;
  P0SKIP    : byte absolute $D4;
  P1SKIP    : byte absolute $D5;
  P2SKIP    : byte absolute $D6;
  P0MAT     : byte absolute $D7;
  PCA0CN    : byte absolute $D8;
  PCA0MD    : byte absolute $D9;
  PCA0CPM0  : byte absolute $DA;
  PCA0CPM1  : byte absolute $DB;
  PCA0CPM2  : byte absolute $DC;
  PCA0CPM3  : byte absolute $DD;
  PCA0CPM4  : byte absolute $DE;
  CRC0FLIP  : byte absolute $DF;
  XBR0      : byte absolute $E1;
  XBR1      : byte absolute $E2;
  PFE0CN    : byte absolute $E3;
  IT01CF    : byte absolute $E4;
  EIE1      : byte absolute $E6;
  EIE2      : byte absolute $E7;
  ADC0CN    : byte absolute $E8;
  PCA0CPL1  : byte absolute $E9;
  PCA0CPH1  : byte absolute $EA;
  PCA0CPL2  : byte absolute $EB;
  PCA0CPH2  : byte absolute $EC;
  PCA0CPL3  : byte absolute $ED;
  PCA0CPH3  : byte absolute $EE;
  RSTSRC    : byte absolute $EF;
  P0MDIN    : byte absolute $F1;
  P1MDIN    : byte absolute $F2;
  P2MDIN    : byte absolute $F3;
  IDA1L     : byte absolute $F4;
  IDA1H     : byte absolute $F5;
  EIP1      : byte absolute $F6;
  EIP2      : byte absolute $F7;
  SPI0CN    : byte absolute $F8;
  PCA0L     : byte absolute $F9;
  PCA0H     : byte absolute $FA;
  PCA0CPL0  : byte absolute $FB;
  PCA0CPH0  : byte absolute $FC;
  PCA0CPL4  : byte absolute $FD;
  PCA0CPH4  : byte absolute $FE;
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
  CCF3      : boolean absolute $DB;
  CCF4      : boolean absolute $DC;
  CCF5      : boolean absolute $DD;
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
  SMB       = $3B;
  RTC       = $43;
  ADC0WC    = $4B;
  ADC0EC    = $53;
  PCA       = $5B;
  CMP0      = $63;
  CMP1      = $6B;
  TIMER3    = $73;
  VREG      = $7B;
  PMATCH    = $83;

implementation

end.
