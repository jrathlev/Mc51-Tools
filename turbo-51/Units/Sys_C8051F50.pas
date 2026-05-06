// C8051F50x processor definition file
// ===================================
// Silicon Labs C8051F500/1/2/3/4/5/6/7
// 
// SFR Paging:
// -----------
// 0  =  SFR is accessible from page 0 only.
// C  =  SFR is accessible from page C only.
// F  =  SFR is accessible from page F only.
// 0+F =  SFR is accessible from pages 0 and F.
// all =  SFR is accessible from pages 0, C and F.
// 
// Note:
// The CAN controller registers on SFR page C and
// the LIN controller registers are present in the
// C8051F500/2/4/6 devices only. P4 is present in
// the 48-pin devices (C8051F500/1/4/5) only.

// SFR page

unit Sys_C8051F50;

interface

var
  SFR0CN    : byte absolute $84;  // F
  SFRNEXT   : byte absolute $85;  // all
  SFRLAST   : byte absolute $86;  // all
  CKCON     : byte absolute $8E;  // all
  PSCTL     : byte absolute $8F;  // 0
  CLKSEL    : byte absolute $8F;  // F
  TMR3CN    : byte absolute $91;  // 0
  TMR3RLL   : byte absolute $92;  // 0
  CAN0CFG   : byte absolute $92;  // C
  TMR3RLH   : byte absolute $93;  // 0
  TMR3L     : byte absolute $94;  // 0
  CAN0STAT  : byte absolute $94;  // C
  TMR3H     : byte absolute $95;  // 0
  CAN0ERRL  : byte absolute $96;  // C
  CAN0ERRH  : byte absolute $97;  // C
  CLKMUL    : byte absolute $97;  // F
  SCON0     : byte absolute $98;  // all
  SBUF0     : byte absolute $99;  // 0
  CPT0CN    : byte absolute $9A;  // 0
  CAN0BTL   : byte absolute $9A;  // C
  CPT0MD    : byte absolute $9B;  // 0
  CAN0BTH   : byte absolute $9B;  // C
  CPT0MX    : byte absolute $9C;  // 0
  CAN0IIDL  : byte absolute $9C;  // C
  CPT1CN    : byte absolute $9D;  // 0
  CAN0IIDH  : byte absolute $9D;  // C
  CPT1MD    : byte absolute $9E;  // 0
  CAN0TST   : byte absolute $9E;  // C
  OSCIFIN   : byte absolute $9E;  // F
  CPT1MX    : byte absolute $9F;  // 0
  OSCXCN    : byte absolute $9F;  // F
  SPI0CFG   : byte absolute $A1;  // 0
  CAN0BRPE  : byte absolute $A1;  // C
  OSCICN    : byte absolute $A1;  // F
  SPI0CKR   : byte absolute $A2;  // 0
  CAN0TR1L  : byte absolute $A2;  // C
  OSCICRS   : byte absolute $A2;  // F
  SPI0DAT   : byte absolute $A3;  // 0
  CAN0TR1H  : byte absolute $A3;  // C
  CAN0TR2L  : byte absolute $A4;  // C
  P0MDOUT   : byte absolute $A4;  // F
  CAN0TR2H  : byte absolute $A5;  // C
  P1MDOUT   : byte absolute $A5;  // F
  P2MDOUT   : byte absolute $A6;  // F
  SFRPAGE   : byte absolute $A7;  // all
  SMOD0     : byte absolute $A9;  // 0
  EMI0CN    : byte absolute $AA;  // 0
  CAN0ND1L  : byte absolute $AA;  // C
  EMI0TC    : byte absolute $AA;  // F
  CAN0ND1H  : byte absolute $AB;  // C
  SBCON0    : byte absolute $AB;  // F
  CAN0ND2L  : byte absolute $AC;  // C
  SBRLL0    : byte absolute $AC;  // F
  CAN0ND2H  : byte absolute $AD;  // C
  SBRLH0    : byte absolute $AD;  // F
  P3MAT     : byte absolute $AE;  // 0
  CAN0IP1L  : byte absolute $AE;  // C
  P3MDOUT   : byte absolute $AE;  // F
  P3MASK    : byte absolute $AF;  // 0
  CAN0IP1H  : byte absolute $AF;  // C
  P4MDOUT   : byte absolute $AF;  // F
  P2MAT     : byte absolute $B1;  // 0
  P2MASK    : byte absolute $B2;  // 0
  CAN0IP2L  : byte absolute $B2;  // C
  EMI0CF    : byte absolute $B2;  // F
  CAN0IP2H  : byte absolute $B3;  // C
  P4        : byte absolute $B5;  // all  (C8051F500/1/4/5 only)
  FLSCL     : byte absolute $B6;  // all
  FLKEY     : byte absolute $B7;  // all
  SMB0ADR   : byte absolute $B9;  // F
  ADC0TK    : byte absolute $BA;  // 0
  CAN0MV1L  : byte absolute $BA;  // C
  SMB0ADM   : byte absolute $BA;  // F
  ADC0MX    : byte absolute $BB;  // 0
  CAN0MV1H  : byte absolute $BB;  // C
  ADC0CF    : byte absolute $BC;  // 0
  CAN0MV2L  : byte absolute $BC;  // C
  ADC0L     : byte absolute $BD;  // 0
  CAN0MV2H  : byte absolute $BD;  // C
  ADC0H     : byte absolute $BE;  // 0
  CAN0IF1CRL: byte absolute $BE;  // C
  ONESHOT   : byte absolute $BE;  // F
  CAN0IF1CRH: byte absolute $BF;  // C
  SMB0CN    : byte absolute $C0;  // 0
  CAN0CN    : byte absolute $C0;  // C
  SMB0CF    : byte absolute $C1;  // 0
  SMB0DAT   : byte absolute $C2;  // 0
  CAN0IF1CML: byte absolute $C2;  // C
  ADC0GTL   : byte absolute $C3;  // 0
  CAN0IF1CMH: byte absolute $C3;  // C
  ADC0GTH   : byte absolute $C4;  // 0
  CAN0IF1M1L: byte absolute $C4;  // C
  ADC0LTL   : byte absolute $C5;  // 0
  CAN0IF1M1H: byte absolute $C5;  // C
  ADC0LTH   : byte absolute $C6;  // 0
  CAN0IF1M2L: byte absolute $C6;  // C
  CAN0IF1M2H: byte absolute $C7;  // C
  XBR2      : byte absolute $C7;  // F
  TMR2CN    : byte absolute $C8;  // 0
  REG0CN    : byte absolute $C9;  // 0
  LIN0CF    : byte absolute $C9;  // F    (C8051F500/2/4/6 only)
  TMR2RLL   : byte absolute $CA;  // 0
  CAN0IF1A1L: byte absolute $CA;  // C
  TMR2RLH   : byte absolute $CB;  // 0
  CAN0IF1A1H: byte absolute $CB;  // C
  TMR2L     : byte absolute $CC;  // 0
  CAN0IF1A2L: byte absolute $CC;  // C
  TMR2H     : byte absolute $CD;  // 0
  CAN0IF1A2H: byte absolute $CD;  // C
  PCA0CPL5  : byte absolute $CE;  // 0
  CAN0IF2MCL: byte absolute $CE;  // C
  PCA0CPH5  : byte absolute $CF;  // 0
  CAN0IF2MCH: byte absolute $CF;  // C
  REF0CN    : byte absolute $D1;  // 0
  LIN0DAT   : byte absolute $D2;  // 0    (C8051F500/2/4/6 only)
  CAN0IF1MCL: byte absolute $D2;  // C
  LIN0ADR   : byte absolute $D3;  // 0    (C8051F500/2/4/6 only)
  CAN0IF1MCH: byte absolute $D3;  // C
  CAN0IF1DA1L: byte absolute $D4;  // C
  P0SKIP    : byte absolute $D4;  // F
  CAN0IF1DA1H: byte absolute $D5;  // C
  P1SKIP    : byte absolute $D5;  // F
  CAN0IF1DA2L: byte absolute $D6;  // C
  P2SKIP    : byte absolute $D6;  // F
  CAN0IF1DA2H: byte absolute $D7;  // C
  P3SKIP    : byte absolute $D7;  // F
  PCA0CN    : byte absolute $D8;  // 0
  PCA0MD    : byte absolute $D9;  // 0
  PCA0PWM   : byte absolute $D9;  // F
  PCA0CPM0  : byte absolute $DA;  // 0
  CAN0IF1DB1L: byte absolute $DA;  // C
  PCA0CPM1  : byte absolute $DB;  // 0
  CAN0IF1DB1H: byte absolute $DB;  // C
  PCA0CPM2  : byte absolute $DC;  // 0
  CAN0IF1DB2L: byte absolute $DC;  // C
  PCA0CPM3  : byte absolute $DD;  // 0
  CAN0IF1DB2H: byte absolute $DD;  // C
  PCA0CPM4  : byte absolute $DE;  // 0
  CAN0IF2CRL: byte absolute $DE;  // C
  PCA0CPM5  : byte absolute $DF;  // 0
  CAN0IF2CRH: byte absolute $DF;  // C
  XBR0      : byte absolute $E1;  // F
  CAN0IF2CML: byte absolute $E2;  // C
  XBR1      : byte absolute $E2;  // F
  CAN0IF2CMH: byte absolute $E3;  // C
  CCH0CN    : byte absolute $E3;  // F
  IT01CF    : byte absolute $E4;  // F
  EIE1      : byte absolute $E6;  // all
  EIE2      : byte absolute $E7;  // all
  ADC0CN    : byte absolute $E8;  // 0
  PCA0CPL1  : byte absolute $E9;  // 0
  PCA0CPH1  : byte absolute $EA;  // 0
  CAN0IF2M1L: byte absolute $EA;  // C
  PCA0CPL2  : byte absolute $EB;  // 0
  CAN0IF2M1H: byte absolute $EB;  // C
  PCA0CPH2  : byte absolute $EC;  // 0
  CAN0IF2M2L: byte absolute $EC;  // C
  PCA0CPL3  : byte absolute $ED;  // 0
  CAN0IF2M2H: byte absolute $ED;  // C
  PCA0CPH3  : byte absolute $EE;  // 0
  CAN0IF2A1L: byte absolute $EE;  // C
  RSTSRC    : byte absolute $EF;  // 0
  CAN0IF2A1H: byte absolute $EF;  // C
  P0MAT     : byte absolute $F1;  // 0
  P0MDIN    : byte absolute $F1;  // F
  P0MASK    : byte absolute $F2;  // 0
  CAN0IF2A2L: byte absolute $F2;  // C
  P1MDIN    : byte absolute $F2;  // F
  P1MAT     : byte absolute $F3;  // 0
  CAN0IF2A2H: byte absolute $F3;  // C
  P2MDIN    : byte absolute $F3;  // F
  P1MASK    : byte absolute $F4;  // 0
  P3MDIN    : byte absolute $F4;  // F
  EIP1      : byte absolute $F6;  // 0+F
  CAN0IF2DA1L: byte absolute $F6;  // C
  EIP2      : byte absolute $F7;  // 0+F
  CAN0IF2DA1H: byte absolute $F7;  // C
  SPI0CN    : byte absolute $F8;  // 0
  PCA0L     : byte absolute $F9;  // 0
  SN0       : byte absolute $F9;  // F
  PCA0H     : byte absolute $FA;  // 0
  CAN0IF2DA2L: byte absolute $FA;  // C
  SN1       : byte absolute $FA;  // F
  PCA0CPL0  : byte absolute $FB;  // 0
  CAN0IF2DA2H: byte absolute $FB;  // C
  SN2       : byte absolute $FB;  // F
  PCA0CPH0  : byte absolute $FC;  // 0
  CAN0IF2DB1L: byte absolute $FC;  // C
  SN3       : byte absolute $FC;  // F
  PCA0CPL4  : byte absolute $FD;  // 0
  CAN0IF2DB1H: byte absolute $FD;  // C
  PCA0CPH4  : byte absolute $FE;  // 0
  CAN0IF2DB2L: byte absolute $FE;  // C
  VDM0CN    : byte absolute $FF;  // 0
  CAN0IF2DB2H: byte absolute $FF;  // C


  RI0       : boolean absolute $98;  // SCON0 (all pages)
  TI0       : boolean absolute $99;
  RBX0      : boolean absolute $9A;
  TBX0      : boolean absolute $9B;
  REN0      : boolean absolute $9C;
  THRE0     : boolean absolute $9D;
  PERR0     : boolean absolute $9E;
  OVR0      : boolean absolute $9F;

  ES0       : boolean absolute $AC;
  ET2       : boolean absolute $AD;
  ESPI0     : boolean absolute $AE;

  PS0       : boolean absolute $BC;
  PT2       : boolean absolute $BD;
  PSPI0     : boolean absolute $BE;

  SI        : boolean absolute $C0;  // SMB0CN (page 0)
  ACK       : boolean absolute $C1;
  ARBLOST   : boolean absolute $C2;
  ACKRQ     : boolean absolute $C3;
  STO       : boolean absolute $C4;
  STA       : boolean absolute $C5;
  TXMODE    : boolean absolute $C6;
  MASTER    : boolean absolute $C7;
// C8051F500/2/4/6 only:
  INIT      : boolean absolute $C0;  // CAN0CN (page C)
  MIE       : boolean absolute $C1;
  SIE       : boolean absolute $C2;
  EIE       : boolean absolute $C3;
  CANIF     : boolean absolute $C4;
  DAR       : boolean absolute $C5;
  CCE       : boolean absolute $C6;
  TEST      : boolean absolute $C7;

  T2XCLK    : boolean absolute $C8;  // TMR2CN (page 0)
  TR2       : boolean absolute $CA;
  T2SPLIT   : boolean absolute $CB;
  TF2CEN    : boolean absolute $CC;
  TF2LEN    : boolean absolute $CD;
  TF2L      : boolean absolute $CE;
  TF2H      : boolean absolute $CF;

  F1        : boolean absolute $D1;

  CCF0      : boolean absolute $D8;  // PCA0CN (page 0)
  CCF1      : boolean absolute $D9;
  CCF2      : boolean absolute $DA;
  CCF3      : boolean absolute $DB;
  CCF4      : boolean absolute $DC;
  CCF5      : boolean absolute $DD;
  CR        : boolean absolute $DE;
  CF        : boolean absolute $DF;

  ADC0CM0   : boolean absolute $E8;  // ADC0CN (page 0)
  ADC0CM1   : boolean absolute $E9;
  AD0LJST   : boolean absolute $EA;
  AD0WINT   : boolean absolute $EB;
  AD0BUSY   : boolean absolute $EC;
  AD0INT    : boolean absolute $ED;
  BURSTEN   : boolean absolute $EE;
  AD0EN     : boolean absolute $EF;

  SPIEN     : boolean absolute $F8;  // SPI0CN (page 0)
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
  SPI0      = $33;
  SMB0      = $3B;
  ADC0WC    = $43;
  ADC0EC    = $4B;
  PCA0      = $53;
  CMP0      = $5B;
  CMP1      = $63;
  TIMER3    = $6B;
  LIN0      = $73;  // C8051F500/2/4/6 only
  VREG0     = $7B;
  CAN0      = $83;  // C8051F500/2/4/6 only
  PMATCH    = $8B;

implementation

end.
