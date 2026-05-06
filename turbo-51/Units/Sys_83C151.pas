// 8xC151SA/SB processor definition file
// =====================================


unit Sys_83C151;

interface

var
  WDTRST    : byte absolute $A6;
  SADDR     : byte absolute $A9;
  IPH0      : byte absolute $B7;
  IPL0      : byte absolute $B8;
  SADEN     : byte absolute $B9;
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  PSW1      : byte absolute $D1;
  CCON      : byte absolute $D8;
  CMOD      : byte absolute $D9;
  CH        : byte absolute $F9;
  CL        : byte absolute $E9;
  CCAP0H    : byte absolute $FA;
  CCAP0L    : byte absolute $EA;
  CCAP1H    : byte absolute $FB;
  CCAP1L    : byte absolute $EB;
  CCAP2H    : byte absolute $FC;
  CCAP2L    : byte absolute $EC;
  CCAP3H    : byte absolute $FD;
  CCAP3L    : byte absolute $ED;
  CCAP4H    : byte absolute $FE;
  CCAP4L    : byte absolute $EE;
  CCAPM0    : byte absolute $DA;
  CCAPM1    : byte absolute $DB;
  CCAPM2    : byte absolute $DC;
  CCAPM3    : byte absolute $DD;
  CCAPM4    : byte absolute $DE;

  T2        : boolean absolute $90;
  T2EX      : boolean absolute $91;
  ECI       : boolean absolute $92;
  CEX0      : boolean absolute $93;
  CEX1      : boolean absolute $94;
  CEX2      : boolean absolute $95;
  CEX3      : boolean absolute $96;
  CEX4      : boolean absolute $97;
  ET2       : boolean absolute $AD;
  EC        : boolean absolute $AE;
  PT2       : boolean absolute $BD;  // for compatibility
  PPC       : boolean absolute $BE;  // reasons!
  CPRL2     : boolean absolute $C8;
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;
  UD        : boolean absolute $D1;
  CCF0      : boolean absolute $D8;
  CCF1      : boolean absolute $D9;
  CCF2      : boolean absolute $DA;
  CCF3      : boolean absolute $DB;
  CCF4      : boolean absolute $DC;
  CR        : boolean absolute $DE;
  CF        : boolean absolute $DF;


const
  TIMER2    = $2B;
  PCA       = $33;

  UCONFIG0  = $FFF8;  // configuration
  UCONFIG1  = $FFF9;  // bytes

implementation

end.
