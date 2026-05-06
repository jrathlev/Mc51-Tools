// 80C310 processor definition file
// ================================


unit Sys_80C310;

interface

var
  DPL1      : byte absolute $84;
  DPH1      : byte absolute $85;
  DPS       : byte absolute $86;
  CKCON     : byte absolute $8E;
  EXIF      : byte absolute $91;
  SADDR0    : byte absolute $A9;
  SADEN0    : byte absolute $B9;
  STATUS    : byte absolute $C5;
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
  INT2      : boolean absolute $94;
  INT3      : boolean absolute $95;
  INT4      : boolean absolute $96;
  INT5      : boolean absolute $97;
  SM0FE     : boolean absolute $9F;
  ES0       : boolean absolute $AC;
  ET2       : boolean absolute $AD;
  RXD0      : boolean absolute $B0;
  TXD0      : boolean absolute $B1;
  PS0       : boolean absolute $BC;
  PT2       : boolean absolute $BD;
  CPRL2     : boolean absolute $C8;
  CT2       : boolean absolute $C9;
  TR2       : boolean absolute $CA;
  EXEN2     : boolean absolute $CB;
  TCLK      : boolean absolute $CC;
  RCLK      : boolean absolute $CD;
  EXF2      : boolean absolute $CE;
  TF2       : boolean absolute $CF;
  FL        : boolean absolute $D1;
  POR       : boolean absolute $DE;
  EX2       : boolean absolute $E8;
  EX3       : boolean absolute $E9;
  EX4       : boolean absolute $EA;
  EX5       : boolean absolute $EB;
  PX2       : boolean absolute $F8;
  PX3       : boolean absolute $F9;
  PX4       : boolean absolute $FA;
  PX5       : boolean absolute $FB;


const
  SINT0     = $23;
  TIMER2    = $2B;
  EXTI2     = $43;
  EXTI3     = $4B;
  EXTI4     = $53;
  EXTI5     = $5B;

implementation

end.
