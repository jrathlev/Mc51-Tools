// C8051F0xx processor definition file
// ===================================
// Cygnal C8051F000/1/2/5/6/7 and C8051F010/1/2/5/6/7


unit Sys_C8051F0X;

interface

var
  CKCON     : byte absolute $8E;
  PSCTL     : byte absolute $8F;
  TMR3CN    : byte absolute $91;
  TMR3RLL   : byte absolute $92;
  TMR3RLH   : byte absolute $93;
  TMR3L     : byte absolute $94;
  TMR3H     : byte absolute $95;
  SPI0CFG   : byte absolute $9A;
  SPI0DAT   : byte absolute $9B;
  SPI0CKR   : byte absolute $9D;
  CPT0CN    : byte absolute $9E;
  CPT1CN    : byte absolute $9F;
  PRT0CF    : byte absolute $A4;
  PRT1CF    : byte absolute $A5;
  PRT2CF    : byte absolute $A6;
  PRT3CF    : byte absolute $A7;
  PRT1IF    : byte absolute $AD;
  EMI0CN    : byte absolute $AF;
  OSCXCN    : byte absolute $B1;
  OSCICN    : byte absolute $B2;
  FLSCL     : byte absolute $B6;
  FLACL     : byte absolute $B7;
  AMX0CF    : byte absolute $BA;
  AMX0SL    : byte absolute $BB;
  ADC0CF    : byte absolute $BC;
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



  ET2       : boolean absolute $AD;
  IEGF0     : boolean absolute $AE;

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
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
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

  ADLJST    : boolean absolute $E8;  // ADC0CN
  ADWINT    : boolean absolute $E9;
  ADSTM0    : boolean absolute $EA;
  ADSTM1    : boolean absolute $EB;
  ADBUSY    : boolean absolute $EC;
  ADCINT    : boolean absolute $ED;
  ADCTM     : boolean absolute $EE;
  ADCEN     : boolean absolute $EF;

  SPIEN     : boolean absolute $F8;  // SPI0CN
  MSTEN     : boolean absolute $F9;
  SLVSEL    : boolean absolute $FA;
  TXBSY     : boolean absolute $FB;
  RXOVRN    : boolean absolute $FC;
  MODF      : boolean absolute $FD;
  WCOL      : boolean absolute $FE;
  SPIF      : boolean absolute $FF;


const
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
  EXTI4     = $83;
  EXTI5     = $8B;
  EXTI6     = $93;
  EXTI7     = $9B;
  OSC       = $AB;

implementation

end.
