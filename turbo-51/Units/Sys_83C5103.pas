// AT83C5103 processor definition file
// ===================================
// Atmel AT83C5103 and AT87C5103


unit Sys_83C5103;

interface

var
  CKCON0    : byte absolute $8F;
  AUXR1     : byte absolute $A2;
  CKCON1    : byte absolute $AF;
  IE_1      : byte absolute $B1;  // the Atmel name IE1 conflicts with bit IE1 in TCON
  IPL1      : byte absolute $B2;
  IPH1      : byte absolute $B3;
  IPH0      : byte absolute $B7;
  IPL0      : byte absolute $B8;
  P4        : byte absolute $C0;  // 24-pin package only
  SPCON     : byte absolute $C3;
  SPSTA     : byte absolute $C4;
  SPDAT     : byte absolute $C5;
  P1M1      : byte absolute $D4;
  P3M1      : byte absolute $D5;
  CCON      : byte absolute $D8;
  CMOD      : byte absolute $D9;
  CCAPM0    : byte absolute $DA;
  CCAPM1    : byte absolute $DB;
  CCAPM2    : byte absolute $DC;
  CCAPM3    : byte absolute $DD;
  CCAPM4    : byte absolute $DE;
  P1M2      : byte absolute $E2;
  P3M2      : byte absolute $E4;
  CL        : byte absolute $E9;
  CCAP0L    : byte absolute $EA;
  CCAP1L    : byte absolute $EB;
  CCAP2L    : byte absolute $EC;
  CCAP3L    : byte absolute $ED;
  CCAP4L    : byte absolute $EE;
  CH        : byte absolute $F9;
  CCAP0H    : byte absolute $FA;
  CCAP1H    : byte absolute $FB;
  CCAP2H    : byte absolute $FC;
  CCAP3H    : byte absolute $FD;
  CCAP4H    : byte absolute $FE;


  MISO      : boolean absolute $90;  // P1
  MOSI      : boolean absolute $91;
  ECI       : boolean absolute $92;
  DIG2      : boolean absolute $92;
  CEX0      : boolean absolute $93;
  CEX1      : boolean absolute $94;
  CEX2      : boolean absolute $95;
  CEX3      : boolean absolute $96;
  CEX4      : boolean absolute $97;
  SS        : boolean absolute $97;

  EC        : boolean absolute $AE;

  TEST0     : boolean absolute $B2;
  DIG0      : boolean absolute $B2;
  TEST1     : boolean absolute $B4;
  DIG1      : boolean absolute $B4;
  SPICK     : boolean absolute $B6;

  PX0L      : boolean absolute $B8;  // IPL0
  PT0L      : boolean absolute $B9;
  PT1L      : boolean absolute $BB;
  PPCL      : boolean absolute $BE;


  CCF0      : boolean absolute $D8;  // CCON
  CCF1      : boolean absolute $D9;
  CCF2      : boolean absolute $DA;
  CCF3      : boolean absolute $DB;
  CCF4      : boolean absolute $DC;
  CR        : boolean absolute $DE;
  CF        : boolean absolute $DF;


const
  PCA       = $33;
  SPI       = $4B;

implementation

end.
