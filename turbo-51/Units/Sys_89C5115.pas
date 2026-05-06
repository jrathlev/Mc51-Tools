// T89C5115 processor definition file
// ==================================


unit Sys_89C5115;

interface

var
  CKCON     : byte absolute $8F;
  AUXR1     : byte absolute $A2;
  WDTRST    : byte absolute $A6;
  WDTPRG    : byte absolute $A7;
  IEN0      : byte absolute $A8;
  SADDR     : byte absolute $A9;
  IPH0      : byte absolute $B7;
  IPL0      : byte absolute $B8;
  SADEN     : byte absolute $B9;
  P4        : byte absolute $C0;
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  FCON      : byte absolute $D1;
  EECON     : byte absolute $D2;
  CCON      : byte absolute $D8;
  CMOD      : byte absolute $D9;
  CCAPM0    : byte absolute $DA;
  CCAPM1    : byte absolute $DB;
  IEN1      : byte absolute $E8;
  CL        : byte absolute $E9;
  CCAP0L    : byte absolute $EA;
  CCAP1L    : byte absolute $EB;
  ADCLK     : byte absolute $F2;
  ADCON     : byte absolute $F3;
  ADDL      : byte absolute $F4;
  ADDH      : byte absolute $F5;
  ADCF      : byte absolute $F6;
  IPH1      : byte absolute $F7;
  IPL1      : byte absolute $F8;
  CH        : byte absolute $F9;
  CCAP0H    : byte absolute $FA;
  CCAP1H    : byte absolute $FB;


  T2        : boolean absolute $90;  // P1
  AN0       : boolean absolute $90;
  T2EX      : boolean absolute $91;
  AN1       : boolean absolute $91;
  ECI       : boolean absolute $92;
  AN2       : boolean absolute $92;
  CEX0      : boolean absolute $93;
  AN3       : boolean absolute $93;
  CEX1      : boolean absolute $94;
  AN4       : boolean absolute $94;
  AN5       : boolean absolute $95;
  AN6       : boolean absolute $96;
  AN7       : boolean absolute $97;

  FE        : boolean absolute $9F;

  ET2       : boolean absolute $AD;
  EC        : boolean absolute $AE;


  PT2       : boolean absolute $BD;
  PPC       : boolean absolute $BE;

  CPRL2     : boolean absolute $C8;  // T2CON
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;

  F1        : boolean absolute $D1;

  CCF0      : boolean absolute $D8;  // CCON
  CCF1      : boolean absolute $D9;
  CR        : boolean absolute $DE;
  CF        : boolean absolute $DF;

  EADC      : boolean absolute $E9;  // IEN1

  PADCL     : boolean absolute $F9;  // IPL1
  POVRL     : boolean absolute $FA;


const
  TIMER2    = $2B;
  PCA       = $33;
  ADC       = $43;

implementation

end.
