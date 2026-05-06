// 89C420 processor definition file
// ================================


unit Sys_89C420;

interface

var
  DPL1      : byte absolute $84;
  DPH1      : byte absolute $85;
  DPS       : byte absolute $86;
  CKCON     : byte absolute $8E;
  EXIF      : byte absolute $91;
  CKMOD     : byte absolute $96;
  SCON0     : byte absolute $98;
  SBUF0     : byte absolute $99;
  ACON      : byte absolute $9D;
  SADDR0    : byte absolute $A9;
  SADDR1    : byte absolute $AA;
  IP1       : byte absolute $B1;
  IP0       : byte absolute $B8;
  SADEN0    : byte absolute $B9;
  SADEN1    : byte absolute $BA;
  SCON1     : byte absolute $C0;
  SBUF1     : byte absolute $C1;
  ROMSIZE   : byte absolute $C2;
  PMR       : byte absolute $C4;
  STATUS    : byte absolute $C5;
  TA        : byte absolute $C7;
  T2CON     : byte absolute $C8;
  T2MOD     : byte absolute $C9;
  RCAP2L    : byte absolute $CA;
  RCAP2H    : byte absolute $CB;
  TL2       : byte absolute $CC;
  TH2       : byte absolute $CD;
  FCNTL     : byte absolute $D5;
  FDATA     : byte absolute $D6;
  WDCON     : byte absolute $D8;
  EIE       : byte absolute $E8;
  EIP1      : byte absolute $F1;
  EIP0      : byte absolute $F8;

  T2        : boolean absolute $90;
  T2EX      : boolean absolute $91;
  RXD1      : boolean absolute $92;
  TXD1      : boolean absolute $93;
  INT2      : boolean absolute $94;
  INT3      : boolean absolute $95;
  INT4      : boolean absolute $96;
  INT5      : boolean absolute $97;
  RI_0      : boolean absolute $98;
  TI_0      : boolean absolute $99;
  RB8_0     : boolean absolute $9A;
  TB8_0     : boolean absolute $9B;
  REN_0     : boolean absolute $9C;
  SM2_0     : boolean absolute $9D;
  SM1_0     : boolean absolute $9E;
  SM0FE_0   : boolean absolute $9F;
  ES0       : boolean absolute $AC;
  ET2       : boolean absolute $AD;
  ES1       : boolean absolute $AE;
  RXD0      : boolean absolute $B0;
  TXD0      : boolean absolute $B1;
  LPX0      : boolean absolute $B8;
  LPT0      : boolean absolute $B9;
  LPX1      : boolean absolute $BA;
  LPT1      : boolean absolute $BB;
  LPS0      : boolean absolute $BC;
  LPT2      : boolean absolute $BD;
  LPS1      : boolean absolute $BE;
  RI_1      : boolean absolute $C0;
  TI_1      : boolean absolute $C1;
  RB8_1     : boolean absolute $C2;
  TB8_1     : boolean absolute $C3;
  REN_1     : boolean absolute $C4;
  SM2_1     : boolean absolute $C5;
  SM1_1     : boolean absolute $C6;
  SM0FE_1   : boolean absolute $C7;
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
  SMOD_1    : boolean absolute $DF;
  EX2       : boolean absolute $E8;
  EX3       : boolean absolute $E9;
  EX4       : boolean absolute $EA;
  EX5       : boolean absolute $EB;
  EWDI      : boolean absolute $EC;
  LPX2      : boolean absolute $F8;
  LPX3      : boolean absolute $F9;
  LPX4      : boolean absolute $FA;
  LPX5      : boolean absolute $FB;
  LPWDI     : boolean absolute $FC;


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
