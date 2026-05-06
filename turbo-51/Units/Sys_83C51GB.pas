// 83C51GB processor definition file
// =================================
// 
// There is a potential name conflict between the SEPDAT(A)
// register and the SEPDAT bit!
// In the Intel "MCS 51 Microcontroller Family User's Manual"
// (February 1994), the alternate function bit P4.1 is named
// SEPDAT, and so is the special function register at address
// E7H in the SFR table, but it is called SEPDATA in the text!
// Thus it is assumed that SEPDATA is the correct name for the
// SFR E7H, and SEPDAT for bit P4.1!


unit Sys_83C51GB;

interface

var
  AD0       : byte absolute $84;
  AD1       : byte absolute $94;
  ACON      : byte absolute $97;
  C1CAPM0   : byte absolute $9A;
  C1CAPM1   : byte absolute $9B;
  C1CAPM2   : byte absolute $9C;
  C1CAPM3   : byte absolute $9D;
  C1CAPM4   : byte absolute $9E;
  C1MOD     : byte absolute $9F;
  AD2       : byte absolute $A4;
  OSCR      : byte absolute $A5;
  WDTRST    : byte absolute $A6;
  IEA       : byte absolute $A7;
  SADDR     : byte absolute $A9;
  C1CAP0L   : byte absolute $AA;
  C1CAP1L   : byte absolute $AB;
  C1CAP2L   : byte absolute $AC;
  C1CAP3L   : byte absolute $AD;
  C1CAP4L   : byte absolute $AE;
  CL1       : byte absolute $AF;
  AD3       : byte absolute $B4;
  IPAH      : byte absolute $B5;
  IPA       : byte absolute $B6;
  IPH       : byte absolute $B7;
  SADEN     : byte absolute $B9;
  C1CAP0H   : byte absolute $BA;
  C1CAP1H   : byte absolute $BB;
  C1CAP2H   : byte absolute $BC;
  C1CAP3H   : byte absolute $BD;
  C1CAP4H   : byte absolute $BE;
  CH1       : byte absolute $BF;
  P4        : byte absolute $C0;
  AD4       : byte absolute $C4;
  EXICON    : byte absolute $C6;
  ACMP      : byte absolute $C7;
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  AD5       : byte absolute $D4;
  SEPCON    : byte absolute $D7;
  CCON      : byte absolute $D8;
  CMOD      : byte absolute $D9;
  CCAPM0    : byte absolute $DA;
  CCAPM1    : byte absolute $DB;
  CCAPM2    : byte absolute $DC;
  CCAPM3    : byte absolute $DD;
  CCAPM4    : byte absolute $DE;
  AD6       : byte absolute $E4;
  SEPDATA   : byte absolute $E7;  // possible name conflict with the SEPDAT bit
  C1CON     : byte absolute $E8;
  CL        : byte absolute $E9;
  CCAP0L    : byte absolute $EA;
  CCAP1L    : byte absolute $EB;
  CCAP2L    : byte absolute $EC;
  CCAP3L    : byte absolute $ED;
  CCAP4L    : byte absolute $EE;
  AD7       : byte absolute $F4;
  SEPSTAT   : byte absolute $F7;
  P5        : byte absolute $F8;
  CH        : byte absolute $F9;
  CCAP0H    : byte absolute $FA;
  CCAP1H    : byte absolute $FB;
  CCAP2H    : byte absolute $FC;
  CCAP3H    : byte absolute $FD;
  CCAP4H    : byte absolute $FE;

  T2        : boolean absolute $90;
  T2EX      : boolean absolute $91;
  ECI       : boolean absolute $92;
  CEX0      : boolean absolute $93;
  CEX1      : boolean absolute $94;
  CEX2      : boolean absolute $95;
  CEX3      : boolean absolute $96;
  CEX4      : boolean absolute $97;
  FE        : boolean absolute $9F;
  ET2       : boolean absolute $AD;
  EC        : boolean absolute $AE;
  PT2       : boolean absolute $BD;
  PPC       : boolean absolute $BE;
  SEPCLK    : boolean absolute $C0;
  SEPDAT    : boolean absolute $C1;
  ECI1      : boolean absolute $C2;
  C1EX0     : boolean absolute $C3;
  C1EX1     : boolean absolute $C4;
  C1EX2     : boolean absolute $C5;
  C1EX3     : boolean absolute $C6;
  C1EX4     : boolean absolute $C7;
  CPRL2     : boolean absolute $C8;
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;
  CCF0      : boolean absolute $D8;
  CCF1      : boolean absolute $D9;
  CCF2      : boolean absolute $DA;
  CCF3      : boolean absolute $DB;
  CCF4      : boolean absolute $DC;
  CR        : boolean absolute $DE;
  CF        : boolean absolute $DF;
  C1CF0     : boolean absolute $E8;
  C1CF1     : boolean absolute $E9;
  C1CF2     : boolean absolute $EA;
  C1CF3     : boolean absolute $EB;
  C1CF4     : boolean absolute $EC;
  CRE       : boolean absolute $ED;
  CR1       : boolean absolute $EE;
  CF1       : boolean absolute $EF;
  INT2      : boolean absolute $FA;
  INT3      : boolean absolute $FB;
  INT4      : boolean absolute $FC;
  INT5      : boolean absolute $FD;
  INT6      : boolean absolute $FE;


const
  TIMER2    = $2B;
  PCA       = $33;
  ADCONV    = $3B;
  PCA1      = $43;
  SEP       = $4B;
  EXTI2     = $53;
  EXTI3     = $5B;
  EXTI4     = $63;
  EXTI5     = $6B;
  EXTI6     = $73;

implementation

end.
