// AT83C5111 processor definition file
// ===================================
// Atmel AT83C5111 and AT87C5111


unit Sys_83C5111;

interface

var
  CKSEL     : byte absolute $85;
  OSCCON    : byte absolute $86;
  CKCON0    : byte absolute $8F;
  CKRL      : byte absolute $97;
  BRL       : byte absolute $9A;
  BDRCON    : byte absolute $9B;
  AUXR1     : byte absolute $A2;
  WDTRST    : byte absolute $A6;  // sometimes also named WDRST in the Atmel data sheet
  WDTPRG    : byte absolute $A7;
  SADDR     : byte absolute $A9;
  CKCON1    : byte absolute $AF;
  IE_1      : byte absolute $B1;  // the Atmel name IE1 conflicts with bit IE1 in TCON
  IPL1      : byte absolute $B2;
  IPH1      : byte absolute $B3;
  IPH0      : byte absolute $B7;
  IPL0      : byte absolute $B8;
  SADEN     : byte absolute $B9;
  P4        : byte absolute $C0;
  SPCON     : byte absolute $C3;
  SPSTA     : byte absolute $C4;
  SPDAT     : byte absolute $C5;
  P1M1      : byte absolute $D4;
  P3M1      : byte absolute $D5;
  P4M1      : byte absolute $D6;
  CCON      : byte absolute $D8;
  CMOD      : byte absolute $D9;
  CCAPM0    : byte absolute $DA;
  CCAPM1    : byte absolute $DB;
  CCAPM2    : byte absolute $DC;
  CCAPM3    : byte absolute $DD;
  CCAPM4    : byte absolute $DE;
  P1M2      : byte absolute $E2;
  P3M2      : byte absolute $E4;
  P4M2      : byte absolute $E5;
  CL        : byte absolute $E9;
  CCAP0L    : byte absolute $EA;
  CCAP1L    : byte absolute $EB;
  CCAP2L    : byte absolute $EC;
  CCAP3L    : byte absolute $ED;
  CCAP4L    : byte absolute $EE;
  CONF      : byte absolute $EF;
  ADCLK     : byte absolute $F2;
  ADCON     : byte absolute $F3;
  ADDL      : byte absolute $F4;
  ADDH      : byte absolute $F5;
  ADCF      : byte absolute $F6;
  CH        : byte absolute $F9;
  CCAP0H    : byte absolute $FA;
  CCAP1H    : byte absolute $FB;
  CCAP2H    : byte absolute $FC;
  CCAP3H    : byte absolute $FD;
  CCAP4H    : byte absolute $FE;


  ECI       : boolean absolute $92;  // P1
  CEX0      : boolean absolute $93;
  CEX1      : boolean absolute $94;
  CEX2      : boolean absolute $95;
  CEX3      : boolean absolute $96;
  CEX4      : boolean absolute $97;  // not present at the SSOP24 package

  FE        : boolean absolute $9F;

  EC        : boolean absolute $AE;


  PPC       : boolean absolute $BE;

  AIN0      : boolean absolute $C0;  // P4
  AIN1      : boolean absolute $C1;
  AIN2      : boolean absolute $C2;
  SS        : boolean absolute $C2;
  AIN3      : boolean absolute $C3;
  AIN4      : boolean absolute $C4;
  MISO      : boolean absolute $C4;
  AIN5      : boolean absolute $C5;
  MOSI      : boolean absolute $C5;
  AIN6      : boolean absolute $C6;
  SPSCK     : boolean absolute $C6;
  AIN7      : boolean absolute $C7;  // not present at the SSOP24 package


  CCF0      : boolean absolute $D8;  // CCON
  CCF1      : boolean absolute $D9;
  CCF2      : boolean absolute $DA;
  CCF3      : boolean absolute $DB;
  CCF4      : boolean absolute $DC;
  CR        : boolean absolute $DE;
  CF        : boolean absolute $DF;


const
  PCA       = $33;
  ADC       = $43;
  SPI       = $4B;

implementation

end.
