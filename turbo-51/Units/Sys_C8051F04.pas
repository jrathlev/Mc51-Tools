// C8051F04x processor definition file
// ===================================
// Cygnal C8051F040/1/2/3/4/5/6/7


unit Sys_C8051F04;

interface

var
  SFRPAGE   : byte absolute $84;
  SFRNEXT   : byte absolute $85;
  SFRLAST   : byte absolute $86;
  CPT0CN    : byte absolute $88;  // 1
  CPT1CN    : byte absolute $88;  // 2
  CPT2CN    : byte absolute $88;  // 3
  CPT0MD    : byte absolute $89;  // 1
  CPT1MD    : byte absolute $89;  // 2
  CPT2MD    : byte absolute $89;  // 3
  OSCICN    : byte absolute $8A;  // F
  OSCICL    : byte absolute $8B;  // F
  OSCXCN    : byte absolute $8C;  // F
  CKCON     : byte absolute $8E;  // 0
  PSCTL     : byte absolute $8F;  // 0
  SSTA0     : byte absolute $91;  // 0
  SFRPGCN   : byte absolute $96;  // F
  CLKSEL    : byte absolute $97;  // F
  SCON0     : byte absolute $98;  // 0
  SCON1     : byte absolute $98;  // 1
  SBUF0     : byte absolute $99;  // 0
  SBUF1     : byte absolute $99;  // 1
  SPI0CFG   : byte absolute $9A;  // 0
  SPI0DAT   : byte absolute $9B;  // 0
  P4MDOUT   : byte absolute $9C;  // F
  SPI0CKR   : byte absolute $9D;  // 0
  P5MDOUT   : byte absolute $9D;  // F
  P6MDOUT   : byte absolute $9E;  // F
  P7MDOUT   : byte absolute $9F;  // F
  EMI0TC    : byte absolute $A1;  // 0
  EMI0CN    : byte absolute $A2;  // 0
  EMI0CF    : byte absolute $A3;  // 0
  P0MDOUT   : byte absolute $A4;  // F
  P1MDOUT   : byte absolute $A5;  // F
  P2MDOUT   : byte absolute $A6;  // F
  P3MDOUT   : byte absolute $A7;  // F
  SADDR0    : byte absolute $A9;  // 0
  P1MDIN    : byte absolute $AD;  // F
  P2MDIN    : byte absolute $AE;  // F
  P3MDIN    : byte absolute $AF;  // F
  FLSCL     : byte absolute $B7;  // 0
  FLACL     : byte absolute $B7;  // F
  SADEN0    : byte absolute $B9;  // 0
  AMX0CF    : byte absolute $BA;  // 0
  AMX2CF    : byte absolute $BA;  // 2
  AMX0SL    : byte absolute $BB;  // 0
  AMX2SL    : byte absolute $BB;  // 2
  ADC0CF    : byte absolute $BC;  // 0
  ADC2CF    : byte absolute $BC;  // 2
  AMX0PRT   : byte absolute $BD;  // 0
  ADC0L     : byte absolute $BE;  // 0
  ADC2      : byte absolute $BE;  // 2
  ADC0H     : byte absolute $BF;  // 0
  SMB0CN    : byte absolute $C0;  // 0
  CAN0STA   : byte absolute $C0;  // 1
  SMB0STA   : byte absolute $C1;  // 0
  SMB0DAT   : byte absolute $C2;  // 0
  SMB0ADR   : byte absolute $C3;  // 0
  ADC0GTL   : byte absolute $C4;  // 0
  ADC2GT    : byte absolute $C4;  // 2
  ADC0GTH   : byte absolute $C5;  // 0
  ADC0LTL   : byte absolute $C6;  // 0
  ADC2LT    : byte absolute $C6;  // 2
  ADC0LTH   : byte absolute $C7;  // 0
  TMR2CN    : byte absolute $C8;  // 0
  TMR3CN    : byte absolute $C8;  // 1
  TMR4CN    : byte absolute $C8;  // 2
  P4        : byte absolute $C8;  // F
  TMR2CF    : byte absolute $C9;  // 0
  TMR3CF    : byte absolute $C9;  // 1
  TMR4CF    : byte absolute $C9;  // 2
  RCAP2L    : byte absolute $CA;  // 0
  RCAP3L    : byte absolute $CA;  // 1
  RCAP4L    : byte absolute $CA;  // 2
  RCAP2H    : byte absolute $CB;  // 0
  RCAP3H    : byte absolute $CB;  // 1
  RCAP4H    : byte absolute $CB;  // 2
  TMR2L     : byte absolute $CC;  // 0
  TMR3L     : byte absolute $CC;  // 1
  TMR4L     : byte absolute $CC;  // 2
  TMR2H     : byte absolute $CD;  // 0
  TMR3H     : byte absolute $CD;  // 1
  TMR4H     : byte absolute $CD;  // 2
  SMB0CR    : byte absolute $CF;  // 0
  REF0CN    : byte absolute $D1;  // 0
  DAC0L     : byte absolute $D2;  // 0
  DAC1L     : byte absolute $D2;  // 1
  DAC0H     : byte absolute $D3;  // 0
  DAC1H     : byte absolute $D3;  // 1
  DAC0CN    : byte absolute $D4;  // 0
  DAC1CN    : byte absolute $D4;  // 1
  HVA0CN    : byte absolute $D6;  // 0
  PCA0CN    : byte absolute $D8;  // 0
  CAN0DATL  : byte absolute $D8;  // 1
  P5        : byte absolute $D8;  // F
  PCA0MD    : byte absolute $D9;  // 0
  CAN0DATH  : byte absolute $D9;  // 1
  PCA0CPM0  : byte absolute $DA;  // 0
  CAN0ADR   : byte absolute $DA;  // 1
  PCA0CPM1  : byte absolute $DB;  // 0
  CAN0TST   : byte absolute $DB;  // 1
  PCA0CPM2  : byte absolute $DC;  // 0
  PCA0CPM3  : byte absolute $DD;  // 0
  PCA0CPM4  : byte absolute $DE;  // 0
  PCA0CPM5  : byte absolute $DF;  // 0
  PCA0CPL5  : byte absolute $E1;  // 0
  XBR0      : byte absolute $E1;  // F
  PCA0CPH5  : byte absolute $E2;  // 0
  XBR1      : byte absolute $E2;  // F
  XBR2      : byte absolute $E3;  // F
  XBR3      : byte absolute $E4;  // F
  EIE1      : byte absolute $E6;
  EIE2      : byte absolute $E7;
  ADC0CN    : byte absolute $E8;  // 0
  ADC2CN    : byte absolute $E8;  // 2
  P6        : byte absolute $E8;  // F
  PCA0CPL2  : byte absolute $E9;  // 0
  PCA0CPH2  : byte absolute $EA;  // 0
  PCA0CPL3  : byte absolute $EB;  // 0
  PCA0CPH3  : byte absolute $EC;  // 0
  PCA0CPL4  : byte absolute $ED;  // 0
  PCA0CPH4  : byte absolute $EE;  // 0
  RSTSRC    : byte absolute $EF;  // 0
  EIP1      : byte absolute $F6;
  EIP2      : byte absolute $F7;
  SPI0CN    : byte absolute $F8;  // 0
  CAN0CN    : byte absolute $F8;  // 1
  P7        : byte absolute $F8;  // F
  PCA0L     : byte absolute $F9;  // 0
  PCA0H     : byte absolute $FA;  // 0
  PCA0CPL0  : byte absolute $FB;  // 0
  PCA0CPH0  : byte absolute $FC;  // 0
  PCA0CPL1  : byte absolute $FD;  // 0
  PCA0CPH1  : byte absolute $FE;  // 0
  WDTCN     : byte absolute $FF;


  CP0HYN0   : boolean absolute $88;  // CPT0CN (page 1)
  CP0HYN1   : boolean absolute $89;
  CP0HYP0   : boolean absolute $8A;
  CP0HYP1   : boolean absolute $8B;
  CP0FIF    : boolean absolute $8C;
  CP0RIF    : boolean absolute $8D;
  CP0OUT    : boolean absolute $8E;
  CP0EN     : boolean absolute $8F;

  CP1HYN0   : boolean absolute $88;  // CPT1CN (page 2)
  CP1HYN1   : boolean absolute $89;
  CP1HYP0   : boolean absolute $8A;
  CP1HYP1   : boolean absolute $8B;
  CP1FIF    : boolean absolute $8C;
  CP1RIF    : boolean absolute $8D;
  CP1OUT    : boolean absolute $8E;
  CP1EN     : boolean absolute $8F;

  CP2HYN0   : boolean absolute $88;  // CPT2CN (page 3)
  CP2HYN1   : boolean absolute $89;
  CP2HYP0   : boolean absolute $8A;
  CP2HYP1   : boolean absolute $8B;
  CP2FIF    : boolean absolute $8C;
  CP2RIF    : boolean absolute $8D;
  CP2OUT    : boolean absolute $8E;
  CP2EN     : boolean absolute $8F;

  RI0       : boolean absolute $98;  // SCON0 (page 0)
  TI0       : boolean absolute $99;
  RB80      : boolean absolute $9A;
  TB80      : boolean absolute $9B;
  REN0      : boolean absolute $9C;
  SM20      : boolean absolute $9D;
  SM10      : boolean absolute $9E;
  SM00      : boolean absolute $9F;

  RI1       : boolean absolute $98;  // SCON1 (page 1)
  TI1       : boolean absolute $99;
  RB81      : boolean absolute $9A;
  TB81      : boolean absolute $9B;
  REN1      : boolean absolute $9C;
  MCE1      : boolean absolute $9D;
  S1MODE    : boolean absolute $9F;

  ES0       : boolean absolute $AC;
  ET2       : boolean absolute $AD;
  IEGF0     : boolean absolute $AE;

  PS0       : boolean absolute $BC;
  PT2       : boolean absolute $BD;

  TOE       : boolean absolute $C0;  // SMB0CN (page 0)
  FTE       : boolean absolute $C1;
  AA        : boolean absolute $C2;
  SI        : boolean absolute $C3;
  STO       : boolean absolute $C4;
  STA       : boolean absolute $C5;
  ENSMB     : boolean absolute $C6;
  BUSY      : boolean absolute $C7;

  LEC0      : boolean absolute $C0;  // CAN0STA (page 1)
  LEC1      : boolean absolute $C1;
  LEC2      : boolean absolute $C2;
  TXOK      : boolean absolute $C3;
  RXOK      : boolean absolute $C4;
  EPASS     : boolean absolute $C5;
  EWARN     : boolean absolute $C6;
  BOFF      : boolean absolute $C7;

  CPRL2     : boolean absolute $C8;  // TMR2CN (page 0)
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;

  CPRL3     : boolean absolute $C8;  // TMR3CN (page 1)
  CT3       : boolean absolute $C9;
  TR3       : boolean absolute $CA;
  EXEN3     : boolean absolute $CB;
  EXF3      : boolean absolute $CE;
  TF3       : boolean absolute $CF;

  CPRL4     : boolean absolute $C8;  // TMR4CN (page 2)
  CT4       : boolean absolute $C9;
  TR4       : boolean absolute $CA;
  EXEN4     : boolean absolute $CB;
  EXF4      : boolean absolute $CE;
  TF4       : boolean absolute $CF;

  F1        : boolean absolute $D1;

  CCF0      : boolean absolute $D8;  // PCA0CN (page 0)
  CCF1      : boolean absolute $D9;
  CCF2      : boolean absolute $DA;
  CCF3      : boolean absolute $DB;
  CCF4      : boolean absolute $DC;
  CCF5      : boolean absolute $DD;
  CR        : boolean absolute $DE;
  CF        : boolean absolute $DF;

  AD0LJST   : boolean absolute $E8;  // ADC0CN (page 0)
  AD0WINT   : boolean absolute $E9;
  AD0CM0    : boolean absolute $EA;
  AD0CM1    : boolean absolute $EB;
  AD0BUSY   : boolean absolute $EC;
  AD0INT    : boolean absolute $ED;
  AD0TM     : boolean absolute $EE;
  AD0EN     : boolean absolute $EF;

  AD2WINT   : boolean absolute $E8;  // ADC2CN (page 2)
  AD2CM0    : boolean absolute $E9;
  AD2CM1    : boolean absolute $EA;
  AD2CM2    : boolean absolute $EB;
  AD2BUSY   : boolean absolute $EC;
  AD2INT    : boolean absolute $ED;
  AD2TM     : boolean absolute $EE;
  AD2EN     : boolean absolute $EF;

  SPIEN     : boolean absolute $F8;  // SPI0CN (page 0)
  TXBMT     : boolean absolute $F9;
  NSSMD0    : boolean absolute $FA;
  NSSMD1    : boolean absolute $FB;
  RXOVRN    : boolean absolute $FC;
  MODF      : boolean absolute $FD;
  WCOL      : boolean absolute $FE;
  SPIF      : boolean absolute $FF;

  INIT      : boolean absolute $F8;  // CAN0CN (page 1)
  MIE       : boolean absolute $F9;
  SIE       : boolean absolute $FA;
  EIE       : boolean absolute $FB;
  CANIF     : boolean absolute $FC;
  DAR       : boolean absolute $FD;
  CCE       : boolean absolute $FE;
  TEST      : boolean absolute $FF;


const
  SINT0     = $23;
  TIMER2    = $2B;
  SPI       = $33;
  SMB       = $3B;
  ADC0WC    = $43;
  PCA       = $4B;
  CMP0      = $53;
  CMP1      = $5B;
  CMP2      = $63;
  TIMER3    = $73;
  ADC0EC    = $7B;
  TIMER4    = $83;
  ADC2EC    = $8B;
  ADC2WC    = $93;
  CAN       = $9B;
  SINT1     = $A3;

implementation

end.
