// 83C654X2 processor definition file
// ==================================
// Philips P83C654X2 and P87C654X2


unit Sys_83C654X2;

interface

var
  AUXR      : byte absolute $8E;
  CKCON     : byte absolute $8F;
  AUXR1     : byte absolute $A2;
  WDTRST    : byte absolute $A6;
  IEN0      : byte absolute $A8;
  SADDR     : byte absolute $A9;
  IPH       : byte absolute $B7;
  SADEN     : byte absolute $B9;
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  S1CON     : byte absolute $D8;
  S1STA     : byte absolute $D9;
  S1DAT     : byte absolute $DA;
  S1ADR     : byte absolute $DB;
  IEN1      : byte absolute $E8;


  T2        : boolean absolute $90;  // P1
  T2EX      : boolean absolute $91;
  SCL       : boolean absolute $96;
  SDA       : boolean absolute $97;

  FE        : boolean absolute $9F;

  ES0       : boolean absolute $AC;
  ES1       : boolean absolute $AD;


  PS0       : boolean absolute $BC;
  PS1       : boolean absolute $BD;
  PT2       : boolean absolute $BF;

  CPRL2     : boolean absolute $C8;  // T2CON
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;

  F1        : boolean absolute $D1;

  CR0       : boolean absolute $D8;  // S1CON
  CR1       : boolean absolute $D9;
  AA        : boolean absolute $DA;
  SI        : boolean absolute $DB;
  STO       : boolean absolute $DC;
  STA       : boolean absolute $DD;
  ENS1      : boolean absolute $DE;  // sometimes also named ENA1 in the Philips data sheet
  CR2       : boolean absolute $DF;

  ET2       : boolean absolute $E8;  // IEN1


const
  I2CBUS    = $2B;
  TIMER2    = $3B;

implementation

end.
