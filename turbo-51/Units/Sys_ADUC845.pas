// ADuC845 processor definition file
// =================================


unit Sys_ADUC845;

interface

var
  DPP       : byte absolute $84;
  I2CDAT    : byte absolute $9A;
  I2CADD    : byte absolute $9B;
  T3FD      : byte absolute $9D;
  T3CON     : byte absolute $9E;
  EWAIT     : byte absolute $9F;
  TIMECON   : byte absolute $A1;
  HTHSEC    : byte absolute $A2;
  SEC       : byte absolute $A3;
  MIN       : byte absolute $A4;
  HOUR      : byte absolute $A5;
  INTVAL    : byte absolute $A6;
  DPCON     : byte absolute $A7;
  IEIP2     : byte absolute $A9;
  PWMCON    : byte absolute $AE;
  CFG845    : byte absolute $AF;
  PWM0L     : byte absolute $B1;
  PWM0H     : byte absolute $B2;
  PWM1L     : byte absolute $B3;
  PWM1H     : byte absolute $B4;
  SPH       : byte absolute $B7;
  ECON      : byte absolute $B9;
  EDATA1    : byte absolute $BC;
  EDATA2    : byte absolute $BD;
  EDATA3    : byte absolute $BE;
  EDATA4    : byte absolute $BF;
  WDCON     : byte absolute $C0;
  CHIPID    : byte absolute $C2;
  EADRL     : byte absolute $C6;
  EADRH     : byte absolute $C7;
  T2CON     : byte absolute $C8;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  ADCMODE   : byte absolute $D1;
  ADC0CON1  : byte absolute $D2;
  ADC1CON   : byte absolute $D3;
  SF        : byte absolute $D4;
  ICON      : byte absolute $D5;
  PLLCON    : byte absolute $D7;
  ADCSTAT   : byte absolute $D8;
  ADC0L     : byte absolute $D9;
  ADC0M     : byte absolute $DA;
  ADC0H     : byte absolute $DB;
  ADC1M     : byte absolute $DC;
  ADC1H     : byte absolute $DD;
  ADC1L     : byte absolute $DE;
  PSMCON    : byte absolute $DF;
  OF0L      : byte absolute $E1;
  OF0M      : byte absolute $E2;
  OF0H      : byte absolute $E3;
  OF1L      : byte absolute $E4;
  OF1H      : byte absolute $E5;
  ADC0CON2  : byte absolute $E6;
  I2CCON    : byte absolute $E8;
  GN0L      : byte absolute $E9;
  GN0M      : byte absolute $EA;
  GN0H      : byte absolute $EB;
  GN1L      : byte absolute $EC;
  GN1H      : byte absolute $ED;
  I2CADD1   : byte absolute $F2;
  SPIDAT    : byte absolute $F7;
  SPICON    : byte absolute $F8;
  DACL      : byte absolute $FB;
  DACH      : byte absolute $FC;
  DACCON    : byte absolute $FD;


  AIN1      : boolean absolute $90;  // P1
  AIN2      : boolean absolute $91;
  AIN3      : boolean absolute $92;  // serves also as REFIN2+
  AIN4      : boolean absolute $93;  // serves also as REFIN2-
  AIN5      : boolean absolute $94;
  AIN6      : boolean absolute $95;
  AIN7      : boolean absolute $96;
  IEXC1     : boolean absolute $96;
  AIN8      : boolean absolute $97;
  IEXC2     : boolean absolute $97;


  SCLOCK    : boolean absolute $A0;  // P2
  MOSI      : boolean absolute $A1;
  MISO      : boolean absolute $A2;
  SS        : boolean absolute $A3;
  T2        : boolean absolute $A3;
  T2EX      : boolean absolute $A4;
  PWM0      : boolean absolute $A5;
  PWM1      : boolean absolute $A6;
  PWMCLK    : boolean absolute $A7;

  ET2       : boolean absolute $AD;
  EADC      : boolean absolute $AE;


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

  ERR1      : boolean absolute $DA;  // ADCSTAT
  ERR0      : boolean absolute $DB;
  NOXREF    : boolean absolute $DC;
  CAL       : boolean absolute $DD;
  RDY1      : boolean absolute $DE;
  RDY0      : boolean absolute $DF;

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
  I2CINT    = $3B;  // serves also as SPI interrupt
  PSMINT    = $43;
  TICINT    = $53;
  WDTINT    = $5B;

implementation

end.
