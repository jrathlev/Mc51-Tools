// uPSD3312 processor definition file
// ==================================
// ST uPSD3312, uPSD3333, uPSD3334, uPSD3354


unit Sys_UPSD3312;

interface

var
  DPTC      : byte absolute $85;
  DPTM      : byte absolute $86;
  P1SFS0    : byte absolute $8E;
  P1SFS1    : byte absolute $8F;
  P3SFS     : byte absolute $91;
  P4SFS0    : byte absolute $92;
  P4SFS1    : byte absolute $93;
  ADCPS     : byte absolute $94;
  ADAT0     : byte absolute $95;
  ADAT1     : byte absolute $96;
  ACON      : byte absolute $97;
  SCON0     : byte absolute $98;
  SBUF0     : byte absolute $99;
  BUSCON    : byte absolute $9D;
  PCACL0    : byte absolute $A2;
  PCACH0    : byte absolute $A3;
  PCACON0   : byte absolute $A4;
  PCASTA    : byte absolute $A5;
  WDRST     : byte absolute $A6;
  IEA       : byte absolute $A7;
  TCMMODE0  : byte absolute $A9;
  TCMMODE1  : byte absolute $AA;
  TCMMODE2  : byte absolute $AB;
  CAPCOML0  : byte absolute $AC;
  CAPCOMH0  : byte absolute $AD;
  WDKEY     : byte absolute $AE;
  CAPCOML1  : byte absolute $AF;
  CAPCOMH1  : byte absolute $B1;
  CAPCOML2  : byte absolute $B2;
  CAPCOMH2  : byte absolute $B3;
  PWMF0     : byte absolute $B4;
  IPA       : byte absolute $B7;
  PCACL1    : byte absolute $BA;
  PCACH1    : byte absolute $BB;
  PCACON1   : byte absolute $BC;
  TCMMODE3  : byte absolute $BD;
  TCMMODE4  : byte absolute $BE;
  TCMMODE5  : byte absolute $BF;
  P4        : byte absolute $C0;
  CAPCOML3  : byte absolute $C1;
  CAPCOMH3  : byte absolute $C2;
  CAPCOML4  : byte absolute $C3;
  CAPCOMH4  : byte absolute $C4;
  CAPCOML5  : byte absolute $C5;
  CAPCOMH5  : byte absolute $C6;
  PWMF1     : byte absolute $C7;
  T2CON     : byte absolute $C8;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  IRDACON   : byte absolute $CE;
  SPICLKD   : byte absolute $D2;
  SPISTAT   : byte absolute $D3;
  SPITDR    : byte absolute $D4;
  SPIRDR    : byte absolute $D5;
  SPICON0   : byte absolute $D6;
  SPICON1   : byte absolute $D7;
  SCON1     : byte absolute $D8;
  SBUF1     : byte absolute $D9;
  S1SETUP   : byte absolute $DB;
  S1CON     : byte absolute $DC;
  S1STA     : byte absolute $DD;
  S1DAT     : byte absolute $DE;
  S1ADR     : byte absolute $DF;
  CCON0     : byte absolute $F9;
  CCON2     : byte absolute $FB;
  CCON3     : byte absolute $FC;


  T2        : boolean absolute $90;  // P1
  T2X       : boolean absolute $91;
  RXD1      : boolean absolute $92;
  TXD1      : boolean absolute $93;
  SPICLK    : boolean absolute $94;
  SPIRXD    : boolean absolute $95;
  SPITXD    : boolean absolute $96;
  SPISEL    : boolean absolute $97;
  ADC0      : boolean absolute $90;
  ADC1      : boolean absolute $91;
  ADC2      : boolean absolute $92;
  ADC3      : boolean absolute $93;
  ADC4      : boolean absolute $94;
  ADC5      : boolean absolute $95;
  ADC6      : boolean absolute $96;
  ADC7      : boolean absolute $97;


  ES0       : boolean absolute $AC;
  ET2       : boolean absolute $AD;

  RXD0      : boolean absolute $B0;  // P3
  TXD0      : boolean absolute $B1;
  EXINT0    : boolean absolute $B2;
  TG0       : boolean absolute $B2;
  EXINT1    : boolean absolute $B3;
  TG1       : boolean absolute $B3;
  C0        : boolean absolute $B4;
  C1        : boolean absolute $B5;
  SDA       : boolean absolute $B6;
  SCL       : boolean absolute $B7;

  PS0       : boolean absolute $BC;
  PT2       : boolean absolute $BD;
// P4
  TCM0      : boolean absolute $C0;  // (T2)
  TCM1      : boolean absolute $C1;  // (T2X)
  TCM2      : boolean absolute $C2;  // (RXD1)
  PCACLK0   : boolean absolute $C3;  // (TXD1)
  TCM3      : boolean absolute $C4;  // (SPICLK)
  TCM4      : boolean absolute $C5;  // (SPIRXD)
  TCM5      : boolean absolute $C6;  // (SPITXD)
  PCACLK1   : boolean absolute $C7;  // (SPISEL)

  CPRL2     : boolean absolute $C8;  // T2CON
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;


  RI_1      : boolean absolute $D8;  // SCON1
  TI_1      : boolean absolute $D9;
  RB8_1     : boolean absolute $DA;  // renamed all SCON1 bit symbols
  TB8_1     : boolean absolute $DB;  // to avoid name conflicts with the
  REN_1     : boolean absolute $DC;  // corresponding SCON0 bit symbols
  SM2_1     : boolean absolute $DD;
  SM1_1     : boolean absolute $DE;
  SM0_1     : boolean absolute $DF;


const
  SINT0     = $23;
  TIMER2    = $2B;
  ADCINT    = $3B;
  I2CINT    = $43;
  SINT1     = $4B;
  SPIINT    = $53;
  PCAINT    = $5B;

implementation

end.
