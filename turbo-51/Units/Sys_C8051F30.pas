// C8051F30x processor definition file
// ===================================
// Cygnal C8051F300/1/2/3/4/5


unit Sys_C8051F30;

interface

var
  CKCON     : byte absolute $8E;
  PSCTL     : byte absolute $8F;
  SCON0     : byte absolute $98;
  SBUF0     : byte absolute $99;
  CPT0MD    : byte absolute $9D;
  CPT0MX    : byte absolute $9F;
  P0MDOUT   : byte absolute $A4;
  OSCXCN    : byte absolute $B1;
  OSCICN    : byte absolute $B2;
  OSCICL    : byte absolute $B3;
  FLSCL     : byte absolute $B6;
  FLKEY     : byte absolute $B7;
  AMX0SL    : byte absolute $BB;
  ADC0CF    : byte absolute $BC;
  ADC0      : byte absolute $BE;
  SMB0CN    : byte absolute $C0;
  SMB0CF    : byte absolute $C1;
  SMB0DAT   : byte absolute $C2;
  ADC0GT    : byte absolute $C4;
  ADC0LT    : byte absolute $C6;
  TMR2CN    : byte absolute $C8;
  TMR2RLL   : byte absolute $CA;
  TMR2RLH   : byte absolute $CB;
  TMR2L     : byte absolute $CC;
  TMR2H     : byte absolute $CD;
  REF0CN    : byte absolute $D1;
  PCA0CN    : byte absolute $D8;
  PCA0MD    : byte absolute $D9;
  PCA0CPM0  : byte absolute $DA;
  PCA0CPM1  : byte absolute $DB;
  PCA0CPM2  : byte absolute $DC;
  XBR0      : byte absolute $E1;
  XBR1      : byte absolute $E2;
  XBR2      : byte absolute $E3;
  IT01CF    : byte absolute $E4;
  EIE1      : byte absolute $E6;
  ADC0CN    : byte absolute $E8;
  PCA0CPL1  : byte absolute $E9;
  PCA0CPH1  : byte absolute $EA;
  PCA0CPL2  : byte absolute $EB;
  PCA0CPH2  : byte absolute $EC;
  RSTSRC    : byte absolute $EF;
  P0MDIN    : byte absolute $F1;
  EIP1      : byte absolute $F6;
  CPT0CN    : byte absolute $F8;
  PCA0L     : byte absolute $F9;
  PCA0H     : byte absolute $FA;
  PCA0CPL0  : byte absolute $FB;
  PCA0CPH0  : byte absolute $FC;


  RI0       : boolean absolute $98;  // SCON0
  TI0       : boolean absolute $99;
  RB80      : boolean absolute $9A;
  TB80      : boolean absolute $9B;
  REN0      : boolean absolute $9C;
  MCE0      : boolean absolute $9D;
  S0MODE    : boolean absolute $9F;

  ES0       : boolean absolute $AC;
  ET2       : boolean absolute $AD;
  IEGF0     : boolean absolute $AE;

  PS0       : boolean absolute $BC;
  PT2       : boolean absolute $BD;

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

  AD0CM0    : boolean absolute $E8;  // ADC0CN
  AD0CM1    : boolean absolute $E9;
  AD0CM2    : boolean absolute $EA;
  AD0WINT   : boolean absolute $EB;
  AD0BUSY   : boolean absolute $EC;
  AD0INT    : boolean absolute $ED;
  AD0TM     : boolean absolute $EE;
  AD0EN     : boolean absolute $EF;

  CP0HYN0   : boolean absolute $F8;  // CPT0CN
  CP0HYN1   : boolean absolute $F9;
  CP0HYP0   : boolean absolute $FA;
  CP0HYP1   : boolean absolute $FB;
  CP0FIF    : boolean absolute $FC;
  CP0RIF    : boolean absolute $FD;
  CP0OUT    : boolean absolute $FE;
  CP0EN     : boolean absolute $FF;


const
  TIMER2    = $2B;
  SMB       = $33;
  ADC0WC    = $3B;
  ADC0EC    = $43;
  PCA       = $4B;
  CMP0FE    = $53;
  CMP0RE    = $5B;

implementation

end.
