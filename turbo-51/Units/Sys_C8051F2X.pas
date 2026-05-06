// C8051F2xx processor definition file
// ===================================
// Cygnal C8051F206, C8051F220/1/6 and C8051F230/1/6


unit Sys_C8051F2X;

interface

var
  CKCON     : byte absolute $8E;
  PSCTL     : byte absolute $8F;
  SPI0CFG   : byte absolute $9A;
  SPI0DAT   : byte absolute $9B;
  SPI0CKR   : byte absolute $9D;
  CPT0CN    : byte absolute $9E;
  CPT1CN    : byte absolute $9F;
  PRT0CF    : byte absolute $A4;
  PRT1CF    : byte absolute $A5;
  PRT2CF    : byte absolute $A6;
  PRT3CF    : byte absolute $A7;
  SWCINT    : byte absolute $AD;
  EMI0CN    : byte absolute $AF;
  OSCXCN    : byte absolute $B1;
  OSCICN    : byte absolute $B2;
  FLSCL     : byte absolute $B6;
  FLACL     : byte absolute $B7;
  AMX0SL    : byte absolute $BB;
  ADC0CF    : byte absolute $BC;
  ADC0L     : byte absolute $BE;
  ADC0H     : byte absolute $BF;
  ADC0GTL   : byte absolute $C4;
  ADC0GTH   : byte absolute $C5;
  ADC0LTL   : byte absolute $C6;
  ADC0LTH   : byte absolute $C7;
  T2CON     : byte absolute $C8;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  REF0CN    : byte absolute $D1;
  PRT0MX    : byte absolute $E1;
  PRT1MX    : byte absolute $E2;
  PRT2MX    : byte absolute $E3;
  EIE1      : byte absolute $E6;
  EIE2      : byte absolute $E7;
  ADC0CN    : byte absolute $E8;
  RSTSRC    : byte absolute $EF;
  P0MODE    : byte absolute $F1;
  P1MODE    : byte absolute $F2;
  P2MODE    : byte absolute $F3;
  P3MODE    : byte absolute $F4;
  EIP1      : byte absolute $F6;
  EIP2      : byte absolute $F7;
  SPI0CN    : byte absolute $F8;
  WDTCN     : byte absolute $FF;



  ET2       : boolean absolute $AD;

  PT2       : boolean absolute $BD;

  CPRL2     : boolean absolute $C8;  // T2CON
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;

  F1        : boolean absolute $D1;

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
  ADC0WC    = $43;
  CMP0FE    = $53;
  CMP0RE    = $5B;
  CMP1FE    = $63;
  CMP1RE    = $6B;
  ADC0EC    = $7B;
  SOFTI0    = $83;
  SOFTI1    = $8B;
  SOFTI2    = $93;
  SOFTI3    = $9B;
  OSC       = $AB;

implementation

end.
