// W79E834A processor definition file
// ==================================
// Winbond W79E834A, W79E833A, W79E832A


unit Sys_W79E834A;

interface

var
  CKCON     : byte absolute $8E;
  DIVM      : byte absolute $95;
  P3M1      : byte absolute $9E;
  P3M2      : byte absolute $9F;
  KBI       : byte absolute $A1;
  AUXR1     : byte absolute $A2;
  CAPCON0   : byte absolute $A3;
  CAPCON1   : byte absolute $A4;
  CCL2      : byte absolute $A6;
  CCH2      : byte absolute $A7;
  SADDR     : byte absolute $A9;
  P0M1      : byte absolute $B1;
  P0M2      : byte absolute $B2;
  P1M1      : byte absolute $B3;
  P1M2      : byte absolute $B4;
  P2M1      : byte absolute $B5;
  P2M2      : byte absolute $B6;
  IP0H      : byte absolute $B7;
  IP0       : byte absolute $B8;
  SADEN     : byte absolute $B9;
  TA        : byte absolute $C7;
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  PWMPH     : byte absolute $D1;
  PWM0H     : byte absolute $D2;
  PWM1H     : byte absolute $D3;
  PWM2H     : byte absolute $D5;
  PWM3H     : byte absolute $D6;
  PWMCON3   : byte absolute $D7;
  WDCON     : byte absolute $D8;
  PWMPL     : byte absolute $D9;
  PWM0L     : byte absolute $DA;
  PWM1L     : byte absolute $DB;
  PWMCON1   : byte absolute $DC;
  PWM2L     : byte absolute $DD;
  PWM3L     : byte absolute $DE;
  ADCCON    : byte absolute $E1;
  ADCH      : byte absolute $E2;
  CCL0      : byte absolute $E4;
  CCH0      : byte absolute $E5;
  CCL1      : byte absolute $E6;
  CCH1      : byte absolute $E7;
  EIE       : byte absolute $E8;
  SPCR      : byte absolute $F3;
  SPSR      : byte absolute $F4;
  SPDR      : byte absolute $F5;
  PADIDS    : byte absolute $F6;
  IP1H      : byte absolute $F7;
  IP1       : byte absolute $F8;

  KB0       : boolean absolute $80;  // P0
  KB1       : boolean absolute $81;
  KB2       : boolean absolute $82;
  KB3       : boolean absolute $83;
  KB4       : boolean absolute $84;
  KB5       : boolean absolute $85;
  KB6       : boolean absolute $86;
  KB7       : boolean absolute $87;
  PWM2      : boolean absolute $80;
  ADC0      : boolean absolute $81;
  ADC1      : boolean absolute $82;
  ADC2      : boolean absolute $83;
  ADC3      : boolean absolute $84;
  ADC4      : boolean absolute $85;  // W79E834A only
  ADC5      : boolean absolute $86;  // W79E834A only


  STADC     : boolean absolute $94;
  RST       : boolean absolute $95;
  PWM0      : boolean absolute $96;
  PWM1      : boolean absolute $97;

  FE        : boolean absolute $9F;

  T2        : boolean absolute $A0;  // P2 (not present at the 20-pin package)
  PWM3      : boolean absolute $A1;
  MOSI      : boolean absolute $A2;  // P2.2 thru P2.5
  MISO      : boolean absolute $A3;  // are present at the
  SS        : boolean absolute $A4;  // 28-pin and 48-pin
  SCLK      : boolean absolute $A5;  // packages only.
  ADC6      : boolean absolute $A6;  // W79E834A only
  ADC7      : boolean absolute $A7;  // W79E834A only

  EBO       : boolean absolute $AD;
  EADC      : boolean absolute $AE;

  CLKOUT    : boolean absolute $B0;  // P3
  X2        : boolean absolute $B0;
  X1        : boolean absolute $B1;

  PBO       : boolean absolute $BD;
  PADC      : boolean absolute $BE;

  CPRL2     : boolean absolute $C8;  // T2CON
  TR2       : boolean absolute $CA;
  TF2       : boolean absolute $CF;

  F1        : boolean absolute $D1;

  WDCLR     : boolean absolute $D8;  // WDCON
  EWRST     : boolean absolute $D9;
  WTRF      : boolean absolute $DA;
  WDIF      : boolean absolute $DB;
  WD0       : boolean absolute $DC;
  WD1       : boolean absolute $DD;
  WDRUN     : boolean absolute $DF;

  EKB       : boolean absolute $E9;  // EIE
  ESPI      : boolean absolute $EB;
  EWDI      : boolean absolute $EC;
  EPWM      : boolean absolute $ED;
  ET2       : boolean absolute $EE;
  ECPTF     : boolean absolute $EF;

  PKB       : boolean absolute $F9;  // IP1
  PSPI      : boolean absolute $FB;
  PWDI      : boolean absolute $FC;
  PPWM      : boolean absolute $FD;
  PT2       : boolean absolute $FE;
  PCAP      : boolean absolute $FF;


const
  BROWN     = $2B;
  KBINT     = $3B;
  TIMER2    = $43;
  SPI       = $4B;
  WATCHD    = $53;
  ADCONV    = $5B;
  CAPT      = $6B;
  PWM       = $73;

implementation

end.
