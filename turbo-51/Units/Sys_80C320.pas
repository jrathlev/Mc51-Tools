// 80C320 processor definition file
// ================================


unit Sys_80C320;

interface

var
  DPL1      : byte absolute $84;
  DPH1      : byte absolute $85;
  DPS       : byte absolute $86;
  CKCON     : byte absolute $8E;
  EXIF      : byte absolute $91;
  SCON0     : byte absolute $98;
  SBUF0     : byte absolute $99;
  SADDR0    : byte absolute $A9;
  SADDR1    : byte absolute $AA;
  SADEN0    : byte absolute $B9;
  SADEN1    : byte absolute $BA;
  SCON1     : byte absolute $C0;
  SBUF1     : byte absolute $C1;
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
  SM0FE     : boolean absolute $9F;
  ES0       : boolean absolute $AC;
  ET2       : boolean absolute $AD;
  ES1       : boolean absolute $AE;
  RXD0      : boolean absolute $B0;
  TXD0      : boolean absolute $B1;
  PS0       : boolean absolute $BC;
  PT2       : boolean absolute $BD;
  PS1       : boolean absolute $BE;
  RI_1      : boolean absolute $C0;  // Dallas Semiconductor
  TI_1      : boolean absolute $C1;  // uses the same names
  RB8_1     : boolean absolute $C2;  // for SCON0 and SCON1
  TB8_1     : boolean absolute $C3;  // register bits. (!)
  REN_1     : boolean absolute $C4;  // So I added the suffix
  SM2_1     : boolean absolute $C5;  // _1 to the SCON1 bit
  SM1_1     : boolean absolute $C6;  // names, just to make
  SM0FE_1   : boolean absolute $C7;  // things unique!
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
  PFI       : boolean absolute $DC;
  EPFI      : boolean absolute $DD;
  POR       : boolean absolute $DE;
  SMOD      : boolean absolute $D8;
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
  SINT0     = $23;
  TIMER2    = $2B;
  PWFAIL    = $33;
  SINT1     = $3B;
  EXTI2     = $43;
  EXTI3     = $4B;
  EXTI4     = $53;
  EXTI5     = $5B;
  WATCHD    = $63;

implementation

end.
