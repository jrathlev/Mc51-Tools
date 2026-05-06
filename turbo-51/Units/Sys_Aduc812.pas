// ADuC812 (Analog Devices)
// Special function registers
// J. Rathlev, June 2005
// --------------------------------------------

// BYTE addressable register


unit Sys_Aduc812;

interface

var
  DPP       : byte absolute $84;
  I2CDAT    : byte absolute $9A;
  I2CADD    : byte absolute $9B;
  IE2       : byte absolute $A9;
  ECON      : byte absolute $B9;
  ETIM1     : byte absolute $BA;
  ETIM2     : byte absolute $BB;
  EDATA1    : byte absolute $BC;
  EDATA2    : byte absolute $BD;
  EDATA3    : byte absolute $BE;
  EDATA4    : byte absolute $BF;
  WDCON     : byte absolute $C0;
  ETIM3     : byte absolute $C4;
  EADRL     : byte absolute $C6;
  T2CON     : byte absolute $C8;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  DMAL      : byte absolute $D2;
  DMAH      : byte absolute $D3;
  DMAP      : byte absolute $D4;
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

// BIT addressable register


  T2        : boolean absolute $90;  // P1
  T2EX      : boolean absolute $91;

  ADC0      : boolean absolute $90;
  ADC1      : boolean absolute $91;
  ADC2      : boolean absolute $92;
  ADC3      : boolean absolute $93;
  ADC4      : boolean absolute $94;
  ADC5      : boolean absolute $95;
  ADC6      : boolean absolute $96;
  ADC7      : boolean absolute $97;


  ET2       : boolean absolute $AD;
  EADC      : boolean absolute $AE;


  PT2       : boolean absolute $BD;
  PADC      : boolean absolute $BE;
  PSI       : boolean absolute $BF;

  WDE       : boolean absolute $C0;  // WDCON
  WDS       : boolean absolute $C1;
  WDR2      : boolean absolute $C2;
  WDR1      : boolean absolute $C3;
  PRE0      : boolean absolute $C5;
  PRE1      : boolean absolute $C6;
  PRE2      : boolean absolute $C7;

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
  DMA       : boolean absolute $DE;
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

// Interrupt vectors


const
  SERIAL    = $23;
  TIMER2    = $2B;
  ADCINT    = $33;
  I2CINT    = $3B;
  PSMINT    = $43;


implementation

end.
