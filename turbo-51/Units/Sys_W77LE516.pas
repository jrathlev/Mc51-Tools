// W77LE516 processor definition file
// ==================================
// Winbond W77LE516 and W77L516A


unit Sys_W77LE516;

interface

var
  DPL1      : byte absolute $84;
  DPH1      : byte absolute $85;
  DPS       : byte absolute $86;
  CKCON     : byte absolute $8E;
  EXIF      : byte absolute $91;
  P4CONA    : byte absolute $92;
  P4CONB    : byte absolute $93;
  P40AL     : byte absolute $94;
  P40AH     : byte absolute $95;
  P41AL     : byte absolute $96;
  P41AH     : byte absolute $97;
  P42AL     : byte absolute $9A;
  P42AH     : byte absolute $9B;
  P43AL     : byte absolute $9C;
  P43AH     : byte absolute $9D;
  CHPCON    : byte absolute $9F;
  P4CSIN    : byte absolute $A2;
  P4        : byte absolute $A5;  // not present at the 40-pin DIP package
  SADDR     : byte absolute $A9;
  SADDR1    : byte absolute $AA;
  SFRAL     : byte absolute $AC;
  SFRAH     : byte absolute $AD;
  SFRFD     : byte absolute $AE;
  SFRCN     : byte absolute $AF;
  SADEN     : byte absolute $B9;
  SADEN1    : byte absolute $BA;
  SCON1     : byte absolute $C0;
  SBUF1     : byte absolute $C1;
  WSCON     : byte absolute $C2;
  PMR       : byte absolute $C4;
  STATUS    : byte absolute $C5;
  TA        : byte absolute $C7;
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  WDCON     : byte absolute $D8;
  EIE       : byte absolute $E8;
  EIP       : byte absolute $F8;

  T2        : boolean absolute $90;
  T2EX      : boolean absolute $91;
  RXD1      : boolean absolute $92;
  TXD1      : boolean absolute $93;
  INT2      : boolean absolute $94;
  INT3      : boolean absolute $95;
  INT4      : boolean absolute $96;
  INT5      : boolean absolute $97;
  FE        : boolean absolute $9F;
  ET2       : boolean absolute $AD;
  ES1       : boolean absolute $AE;
  PT2       : boolean absolute $BD;
  PS1       : boolean absolute $BE;
  RI_1      : boolean absolute $C0;
  TI_1      : boolean absolute $C1;
  RB8_1     : boolean absolute $C2;
  TB8_1     : boolean absolute $C3;
  REN_1     : boolean absolute $C4;
  SM2_1     : boolean absolute $C5;
  SM1_1     : boolean absolute $C6;
  SM0_1     : boolean absolute $C7;
  FE_1      : boolean absolute $C7;
  CPRL2     : boolean absolute $C8;
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;
  F1        : boolean absolute $D1;
  RWT       : boolean absolute $D8;
  EWT       : boolean absolute $D9;
  WTRF      : boolean absolute $DA;
  WDIF      : boolean absolute $DB;
  POR       : boolean absolute $DE;
  SMOD_1    : boolean absolute $DF;
  EX2       : boolean absolute $E8;
  EX3       : boolean absolute $E9;
  EX4       : boolean absolute $EA;
  EX5       : boolean absolute $EB;
  EWDI      : boolean absolute $EC;
  PX2       : boolean absolute $F8;
  PX3       : boolean absolute $F9;
  PX4       : boolean absolute $FA;
  PX5       : boolean absolute $FB;
  PWDI      : boolean absolute $FC;


const
  TIMER2    = $2B;
  SINT1     = $3B;
  EXTI2     = $43;
  EXTI3     = $4B;
  EXTI4     = $53;
  EXTI5     = $5B;
  WATCHD    = $63;

implementation

end.
