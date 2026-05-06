// C8051F02x processor definition file
// ===================================
// Cygnal C8051F020/1/2/3


unit Sys_C8051F02;

interface

var
  P4        : byte absolute $84;
  P5        : byte absolute $85;
  P6        : byte absolute $86;
  CKCON     : byte absolute $8E;
  PSCTL     : byte absolute $8F;
  TMR3CN    : byte absolute $91;
  TMR3RLL   : byte absolute $92;
  TMR3RLH   : byte absolute $93;
  TMR3L     : byte absolute $94;
  TMR3H     : byte absolute $95;
  P7        : byte absolute $96;
  SCON0     : byte absolute $98;
  SBUF0     : byte absolute $99;
  SPI0CFG   : byte absolute $9A;
  SPI0DAT   : byte absolute $9B;
  ADC1      : byte absolute $9C;
  SPI0CKR   : byte absolute $9D;
  CPT0CN    : byte absolute $9E;
  CPT1CN    : byte absolute $9F;
  EMI0TC    : byte absolute $A1;
  EMI0CF    : byte absolute $A3;
  P0MDOUT   : byte absolute $A4;
  P1MDOUT   : byte absolute $A5;
  P2MDOUT   : byte absolute $A6;
  P3MDOUT   : byte absolute $A7;
  SADDR0    : byte absolute $A9;
  ADC1CN    : byte absolute $AA;
  ADC1CF    : byte absolute $AB;
  AMX1SL    : byte absolute $AC;
  P3IF      : byte absolute $AD;
  SADEN1    : byte absolute $AE;
  EMI0CN    : byte absolute $AF;
  OSCXCN    : byte absolute $B1;
  OSCICN    : byte absolute $B2;
  P74OUT    : byte absolute $B5;
  FLSCL     : byte absolute $B6;
  FLACL     : byte absolute $B7;
  SADEN0    : byte absolute $B9;
  AMX0CF    : byte absolute $BA;
  AMX0SL    : byte absolute $BB;
  ADC0CF    : byte absolute $BC;
  P1MDIN    : byte absolute $BD;
  ADC0L     : byte absolute $BE;
  ADC0H     : byte absolute $BF;
  SMB0CN    : byte absolute $C0;
  SMB0STA   : byte absolute $C1;
  SMB0DAT   : byte absolute $C2;
  SMB0ADR   : byte absolute $C3;
  ADC0GTL   : byte absolute $C4;
  ADC0GTH   : byte absolute $C5;
  ADC0LTL   : byte absolute $C6;
  ADC0LTH   : byte absolute $C7;
  T2CON     : byte absolute $C8;
  T4CON     : byte absolute $C9;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  SMB0CR    : byte absolute $CF;
  REF0CN    : byte absolute $D1;
  DAC0L     : byte absolute $D2;
  DAC0H     : byte absolute $D3;
  DAC0CN    : byte absolute $D4;
  DAC1L     : byte absolute $D5;
  DAC1H     : byte absolute $D6;
  DAC1CN    : byte absolute $D7;
  PCA0CN    : byte absolute $D8;
  PCA0MD    : byte absolute $D9;
  PCA0CPM0  : byte absolute $DA;
  PCA0CPM1  : byte absolute $DB;
  PCA0CPM2  : byte absolute $DC;
  PCA0CPM3  : byte absolute $DD;
  PCA0CPM4  : byte absolute $DE;
  XBR0      : byte absolute $E1;
  XBR1      : byte absolute $E2;
  XBR2      : byte absolute $E3;
  RCAP4L    : byte absolute $E4;
  RCAP4H    : byte absolute $E5;
  EIE1      : byte absolute $E6;
  EIE2      : byte absolute $E7;
  ADC0CN    : byte absolute $E8;
  PCA0L     : byte absolute $E9;
  PCA0CPL0  : byte absolute $EA;
  PCA0CPL1  : byte absolute $EB;
  PCA0CPL2  : byte absolute $EC;
  PCA0CPL3  : byte absolute $ED;
  PCA0CPL4  : byte absolute $EE;
  RSTSRC    : byte absolute $EF;
  SCON1     : byte absolute $F1;
  SBUF1     : byte absolute $F2;
  SADDR1    : byte absolute $F3;
  TL4       : byte absolute $F4;
  TH4       : byte absolute $F5;
  EIP1      : byte absolute $F6;
  EIP2      : byte absolute $F7;
  SPI0CN    : byte absolute $F8;
  PCA0H     : byte absolute $F9;
  PCA0CPH0  : byte absolute $FA;
  PCA0CPH1  : byte absolute $FB;
  PCA0CPH2  : byte absolute $FC;
  PCA0CPH3  : byte absolute $FD;
  PCA0CPH4  : byte absolute $FE;
  WDTCN     : byte absolute $FF;


  RI0       : boolean absolute $98;  // SCON0
  TI0       : boolean absolute $99;
  RB80      : boolean absolute $9A;
  TB80      : boolean absolute $9B;
  REN0      : boolean absolute $9C;
  SM20      : boolean absolute $9D;
  TXCOL0    : boolean absolute $9D;
  SM10      : boolean absolute $9E;
  RXOV0     : boolean absolute $9E;
  SM00      : boolean absolute $9F;
  FE0       : boolean absolute $9F;

  ES0       : boolean absolute $AC;
  ET2       : boolean absolute $AD;
  IEGF0     : boolean absolute $AE;

  PS0       : boolean absolute $BC;
  PT2       : boolean absolute $BD;

  TOE       : boolean absolute $C0;  // SMB0CN
  FTE       : boolean absolute $C1;
  AA        : boolean absolute $C2;
  SI        : boolean absolute $C3;
  STO       : boolean absolute $C4;
  STA       : boolean absolute $C5;
  ENSMB     : boolean absolute $C6;
  BUSY      : boolean absolute $C7;

  CPRL2     : boolean absolute $C8;  // T2CON
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK0     : boolean absolute $CC;
  RCLK0     : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;

  F1        : boolean absolute $D1;

  CCF0      : boolean absolute $D8;  // PCA0CN
  CCF1      : boolean absolute $D9;
  CCF2      : boolean absolute $DA;
  CCF3      : boolean absolute $DB;
  CCF4      : boolean absolute $DC;
  CR        : boolean absolute $DE;
  CF        : boolean absolute $DF;

  AD0LJST   : boolean absolute $E8;  // ADC0CN
  AD0WINT   : boolean absolute $E9;
  AD0CM0    : boolean absolute $EA;
  AD0CM1    : boolean absolute $EB;
  AD0BUSY   : boolean absolute $EC;
  AD0INT    : boolean absolute $ED;
  AD0TM     : boolean absolute $EE;
  AD0EN     : boolean absolute $EF;

  SPIEN     : boolean absolute $F8;  // SPI0CN
  MSTEN     : boolean absolute $F9;
  SLVSEL    : boolean absolute $FA;
  TXBSY     : boolean absolute $FB;
  RXOVRN    : boolean absolute $FC;
  MODF      : boolean absolute $FD;
  WCOL      : boolean absolute $FE;
  SPIF      : boolean absolute $FF;


const
  SINT0     = $23;
  TIMER2    = $2B;
  SPI       = $33;
  SMB       = $3B;
  ADC0WC    = $43;
  PCA       = $4B;
  CMP0FE    = $53;
  CMP0RE    = $5B;
  CMP1FE    = $63;
  CMP1RE    = $6B;
  TIMER3    = $73;
  ADC0EC    = $7B;
  TIMER4    = $83;
  ADC1EC    = $8B;
  EXTI6     = $93;
  EXTI7     = $9B;
  SINT1     = $A3;
  OSC       = $AB;

implementation

end.
