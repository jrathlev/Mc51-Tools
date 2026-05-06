// W78L801 processor definition file
// =================================
// W78L801, W78C801


unit Sys_W78L801;

interface

var
  POR       : byte absolute $86;
  AUXR      : byte absolute $8E;
  WDTC      : byte absolute $8F;
  IRQ       : byte absolute $C0;
  P4        : byte absolute $D8;  // not present at the 40-pin DIP package
  IE_1      : byte absolute $E8;  // the Winbond name IE1 conflicts with bit IE1 in TCON
  IX        : byte absolute $E9;
  IP1       : byte absolute $F8;

  INT2      : boolean absolute $90;
  INT3      : boolean absolute $91;
  INT4      : boolean absolute $92;
  INT5      : boolean absolute $93;
  INT6      : boolean absolute $94;
  INT7      : boolean absolute $95;
  INT8      : boolean absolute $96;
  INT9      : boolean absolute $97;
  IQ2       : boolean absolute $C0;
  IQ3       : boolean absolute $C1;
  IQ4       : boolean absolute $C2;
  IQ5       : boolean absolute $C3;
  IQ6       : boolean absolute $C4;
  IQ7       : boolean absolute $C5;
  IQ8       : boolean absolute $C6;
  IQ9       : boolean absolute $C7;
  EX2       : boolean absolute $E8;
  EX3       : boolean absolute $E9;
  EX4       : boolean absolute $EA;
  EX5       : boolean absolute $EB;
  EX6       : boolean absolute $EC;
  EX7       : boolean absolute $ED;
  EX8       : boolean absolute $EE;
  EX9       : boolean absolute $EF;
  PX2       : boolean absolute $F8;
  PX3       : boolean absolute $F9;
  PX4       : boolean absolute $FA;
  PX5       : boolean absolute $FB;
  PX6       : boolean absolute $FC;
  PX7       : boolean absolute $FD;
  PX8       : boolean absolute $FE;
  PX9       : boolean absolute $FF;


const
  EXTI2     = $3B;
  EXTI3     = $43;
  EXTI4     = $4B;
  EXTI5     = $53;
  EXTI6     = $5B;
  EXTI7     = $63;
  EXTI8     = $6B;
  EXTI9     = $73;

implementation

end.
