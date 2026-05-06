// 89L556X2 processor definition file
// ==================================
// Megawin MPC89L556X2


unit Sys_89L556X2;

interface

var
  AUXR      : byte absolute $8E;
  P1SFAD    : byte absolute $97;
  AUXR1     : byte absolute $A2;
  SADDR     : byte absolute $A9;
  IPH       : byte absolute $B7;
  SADEN     : byte absolute $B9;
  P4        : byte absolute $C0;  // not present at the 40-pin DIP package
  ADCON     : byte absolute $C5;
  ADAT      : byte absolute $C6;  // sometimes also named ADC in the Megawin data sheet
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  WDTCR     : byte absolute $E1;
  IFD       : byte absolute $E2;
  IFADRH    : byte absolute $E3;
  IFADRL    : byte absolute $E4;
  IFMT      : byte absolute $E5;
  SCMD      : byte absolute $E6;
  ISPCR     : byte absolute $E7;


  T2        : boolean absolute $90;  // P1
  ADC0      : boolean absolute $90;
  T2EX      : boolean absolute $91;
  ADC1      : boolean absolute $91;
  ADC2      : boolean absolute $92;
  ADC3      : boolean absolute $93;
  ADC4      : boolean absolute $94;
  ADC5      : boolean absolute $95;
  ADC6      : boolean absolute $96;
  ADC7      : boolean absolute $97;

  FE        : boolean absolute $9F;

  ET2       : boolean absolute $AD;
  EAD       : boolean absolute $AE;


  PT2       : boolean absolute $BD;
  PAD       : boolean absolute $BE;

  CPRL2     : boolean absolute $C8;  // T2CON
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;



const
  TIMER2    = $2B;
  ADCINT    = $33;

implementation

end.
