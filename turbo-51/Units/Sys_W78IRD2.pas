// W78IRD2 processor definition file
// =================================
// Winbond W78IRD2/W78IRD2A and W78ERD2/W78ERD2A


unit Sys_W78IRD2;

interface

var
  P40AL     : byte absolute $84;
  P40AH     : byte absolute $85;
  POPT      : byte absolute $86;
  AUXR      : byte absolute $8E;
  P41AL     : byte absolute $94;
  P41AH     : byte absolute $95;
  P2EAL     : byte absolute $9E;  // ?
  P2EAH     : byte absolute $9F;  // ?
  XRAMAH    : byte absolute $A1;
  AUXR1     : byte absolute $A2;
  WDTRST    : byte absolute $A6;
  SADDR     : byte absolute $A9;
  P42AL     : byte absolute $AC;
  P42AH     : byte absolute $AD;
  P4CSIN    : byte absolute $AE;
  P43AL     : byte absolute $B4;
  P43AH     : byte absolute $B5;
  IPH       : byte absolute $B7;
  SADEN     : byte absolute $B9;
  CHPCON    : byte absolute $BF;
  XICON     : byte absolute $C0;
  XICONH    : byte absolute $C1;
  P4CONA    : byte absolute $C2;
  P4CONB    : byte absolute $C3;
  SFRAL     : byte absolute $C4;
  SFRAH     : byte absolute $C5;
  SFRFD     : byte absolute $C6;
  SFRCN     : byte absolute $C7;
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
  CKCON     : byte absolute $DF;
  P4        : byte absolute $E8;  // not present at the 40-pin DIP package
  CL        : byte absolute $E9;
  CCAP0L    : byte absolute $EA;
  CCAP1L    : byte absolute $EB;
  CCAP2L    : byte absolute $EC;
  CCAP3L    : byte absolute $ED;
  CCAP4L    : byte absolute $EE;
  CHPENR    : byte absolute $F6;
  CH        : byte absolute $F9;
  CCAP0H    : byte absolute $FA;
  CCAP1H    : byte absolute $FB;
  CCAP2H    : byte absolute $FC;
  CCAP3H    : byte absolute $FD;
  CCAP4H    : byte absolute $FE;


  T2        : boolean absolute $90;  // P1
  T2EX      : boolean absolute $91;
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

  IT2       : boolean absolute $C0;  // XICON
  IE2       : boolean absolute $C1;
  EX2       : boolean absolute $C2;
  PX2       : boolean absolute $C3;
  IT3       : boolean absolute $C4;
  IE3       : boolean absolute $C5;
  EX3       : boolean absolute $C6;
  PX3       : boolean absolute $C7;

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
  CCF2      : boolean absolute $DA;
  CCF3      : boolean absolute $DB;
  CCF4      : boolean absolute $DC;
  CR        : boolean absolute $DE;
  CF        : boolean absolute $DF;

  INT3      : boolean absolute $EA;  // P4
  INT2      : boolean absolute $EB;


const
  TIMER2    = $2B;
  PCA       = $33;
  EXTI2     = $3B;
  EXTI3     = $43;

implementation

end.
