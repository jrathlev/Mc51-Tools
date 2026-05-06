// 83C528 processor definition file
// ================================


unit Sys_83C528;

interface

var
  WDCON     : byte absolute $A5;
  T2CON     : byte absolute $C8;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  S1SCS     : byte absolute $D8;
  S1BIT     : byte absolute $D9;
  S1INT     : byte absolute $DA;
  FMCON     : byte absolute $FB;  // only present in the 89CE528
  T3        : byte absolute $FF;

  T2        : boolean absolute $90;
  T2EX      : boolean absolute $91;
  SCL       : boolean absolute $96;
  SDA       : boolean absolute $97;
  ES0       : boolean absolute $AC;
  ET2       : boolean absolute $AD;
  ES1       : boolean absolute $AE;
  PS0       : boolean absolute $BC;
  PT2       : boolean absolute $BD;
  PS1       : boolean absolute $BE;
  CPRL2     : boolean absolute $C8;
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;
  F1        : boolean absolute $D1;
  ENS       : boolean absolute $D8;
  STR       : boolean absolute $D9;
  WBF       : boolean absolute $DA;
  RBF       : boolean absolute $DB;
  BB        : boolean absolute $DC;
  CLH       : boolean absolute $DD;
  SCI       : boolean absolute $DE;  // read
  SCO       : boolean absolute $DE;  // write
  SDI       : boolean absolute $DF;  // read
  SDO       : boolean absolute $DF;  // write


const
  TIMER2    = $2B;
  I2CBUS    = $33;

implementation

end.
