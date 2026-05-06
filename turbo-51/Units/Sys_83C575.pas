// 83C575 processor definition file
// ================================
// Philips 83C575, 80C575 and 87C575


unit Sys_83C575;

interface

var
  AUXR      : byte absolute $8E;
  CMPE      : byte absolute $91;
  P2OD      : byte absolute $A1;
  SADDR     : byte absolute $A9;
  SADEN     : byte absolute $B9;
  WDCON     : byte absolute $C0;
  WDL       : byte absolute $C1;
  WFEED1    : byte absolute $C2;
  WFEED2    : byte absolute $C3;
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  CCON      : byte absolute $D8;
  CMOD      : byte absolute $D9;
  CCAPM0    : byte absolute $DA;
  CCAPM1    : byte absolute $DB;
  CCAPM2    : byte absolute $DC;
  CCAPM3    : byte absolute $DD;
  CCAPM4    : byte absolute $DE;
  CMP       : byte absolute $E8;
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


  T2        : boolean absolute $90;  // P1
  CMP0P     : boolean absolute $90;
  T2EX      : boolean absolute $91;
  CMP0M     : boolean absolute $91;
  ECI       : boolean absolute $92;
  CEX0      : boolean absolute $93;
  CMP0      : boolean absolute $93;
  CEX1      : boolean absolute $94;
  CMP1      : boolean absolute $94;
  CEX2      : boolean absolute $95;
  CMP2      : boolean absolute $95;
  CEX3      : boolean absolute $96;
  CMP3      : boolean absolute $96;
  CEX4      : boolean absolute $97;

  FE        : boolean absolute $9F;

  ET2       : boolean absolute $AD;
  EC        : boolean absolute $AE;

  CMPRM     : boolean absolute $B4;
  CMP1P     : boolean absolute $B5;
  CMP2P     : boolean absolute $B6;
  CMP3P     : boolean absolute $B7;

  PT2       : boolean absolute $BD;
  PPC       : boolean absolute $BE;

  WDMOD     : boolean absolute $C0;  // WDCON
  WDTOF     : boolean absolute $C1;
  WDRUN     : boolean absolute $C2;
  OFRE      : boolean absolute $C3;
  LVRE      : boolean absolute $C4;
  PRE0      : boolean absolute $C5;
  PRE1      : boolean absolute $C6;
  PRE2      : boolean absolute $C7;

  CPRL2     : boolean absolute $C8;  // T2CON
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;


  CCF0      : boolean absolute $D8;  // CCON
  CCF1      : boolean absolute $D9;
  CCF2      : boolean absolute $DA;
  CCF3      : boolean absolute $DB;
  CCF4      : boolean absolute $DC;
  CR        : boolean absolute $DE;
  CF        : boolean absolute $DF;

  C0RO      : boolean absolute $E8;  // CMP
  C1RO      : boolean absolute $E9;
  C2RO      : boolean absolute $EA;
  C3RO      : boolean absolute $EB;
  EC0DP     : boolean absolute $EC;
  EC1DP     : boolean absolute $ED;
  EC2DP     : boolean absolute $EE;
  EC3DP     : boolean absolute $EF;


const
  TIMER2    = $2B;
  PCA       = $33;

implementation

end.
