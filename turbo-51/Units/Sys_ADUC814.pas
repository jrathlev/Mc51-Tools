// ADuC814 processor definition file
// =================================
// Reference: Analog Devices ADuC814 data sheet Rev. A


unit Sys_ADUC814;

interface

var
  I2CDAT    : byte absolute $9A;
  I2CADD    : byte absolute $9B;
  CFG814    : byte absolute $9C;
  TIMECON   : byte absolute $A1;
  HTHSEC    : byte absolute $A2;
  SEC       : byte absolute $A3;
  MIN       : byte absolute $A4;
  HOUR      : byte absolute $A5;
  INTVAL    : byte absolute $A6;
  IEIP2     : byte absolute $A9;
  ECON      : byte absolute $B9;
  ETIM1     : byte absolute $BA;
  ETIM2     : byte absolute $BB;
  EDATA1    : byte absolute $BC;
  EDATA2    : byte absolute $BD;
  EDATA3    : byte absolute $BE;
  EDATA4    : byte absolute $BF;
  WDCON     : byte absolute $C0;
  CHIPID    : byte absolute $C2;
  EADRL     : byte absolute $C6;
  T2CON     : byte absolute $C8;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  PLLCON    : byte absolute $D7;
  ADCCON2   : byte absolute $D8;
  ADCDATAL  : byte absolute $D9;
  ADCDATAH  : byte absolute $DA;
  PSMCON    : byte absolute $DF;
  I2CCON    : byte absolute $E8;
  ADCCON1   : byte absolute $EF;
  ADCOFSL   : byte absolute $F1;
  ADCOFSH   : byte absolute $F2;
  ADCGAINL  : byte absolute $F3;
  ADCGAINH  : byte absolute $F4;
  ADCCON3   : byte absolute $F5;
  SPIDAT    : byte absolute $F7;
  SPICON    : byte absolute $F8;
  DAC0L     : byte absolute $F9;
  DAC0H     : byte absolute $FA;
  DAC1L     : byte absolute $FB;
  DAC1H     : byte absolute $FC;
  DACCON    : byte absolute $FD;


  T2        : boolean absolute $90;  // P1
  T2EX      : boolean absolute $91;
  ADC0      : boolean absolute $92;
  ADC1      : boolean absolute $93;
  ADC2      : boolean absolute $94;
  ADC3      : boolean absolute $95;
  ADC4      : boolean absolute $96;
  DAC0      : boolean absolute $96;
  ADC5      : boolean absolute $97;
  DAC1      : boolean absolute $97;


  ET2       : boolean absolute $AD;
  EADC      : boolean absolute $AE;

  CONVST    : boolean absolute $B4;
  SS        : boolean absolute $B5;  // serves also as EXTCLK
  MISO      : boolean absolute $B6;
  MOSI      : boolean absolute $B7;
  SDATA     : boolean absolute $B7;

  PT2       : boolean absolute $BD;
  PADC      : boolean absolute $BE;

  WDWR      : boolean absolute $C0;  // WDCON
  WDE       : boolean absolute $C1;
  WDS       : boolean absolute $C2;
  WDIR      : boolean absolute $C3;
  PRE0      : boolean absolute $C4;
  PRE1      : boolean absolute $C5;
  PRE2      : boolean absolute $C6;
  PRE3      : boolean absolute $C7;

  CAP2      : boolean absolute $C8;  // T2CON
  CNT2      : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;

  F1        : boolean absolute $D1;

  CS0       : boolean absolute $D8;  // ADCCON2
  CS1       : boolean absolute $D9;
  CS2       : boolean absolute $DA;
  CS3       : boolean absolute $DB;
  SCONV     : boolean absolute $DC;
  CCONV     : boolean absolute $DD;
  ADCSPI    : boolean absolute $DE;
  ADCI      : boolean absolute $DF;

  I2CI      : boolean absolute $E8;  // I2CCON
  I2CTX     : boolean absolute $E9;
  I2CRS     : boolean absolute $EA;
  I2CM      : boolean absolute $EB;
  MDI       : boolean absolute $EC;
  MCO       : boolean absolute $ED;
  MDE       : boolean absolute $EE;
  MDO       : boolean absolute $EF;

  SPR0      : boolean absolute $F8;  // SPICON
  SPR1      : boolean absolute $F9;
  CPHA      : boolean absolute $FA;
  CPOL      : boolean absolute $FB;
  SPIM      : boolean absolute $FC;
  SPE       : boolean absolute $FD;
  WCOL      : boolean absolute $FE;
  ISPI      : boolean absolute $FF;


const
  TIMER2    = $2B;
  ADCINT    = $33;
  SPIINT    = $3B;
  PSMINT    = $43;
  TICINT    = $53;
  WDTINT    = $5B;

implementation

end.
